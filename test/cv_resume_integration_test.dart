import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/network/api_constants.dart';
import 'package:vernita/core/network/interceptors/auth_interceptor.dart';
import 'package:vernita/features/home/data/data_source/cv_remote_data_source.dart';
import 'package:vernita/features/home/data/models/cv_response_model.dart';
import 'package:vernita/features/home/data/models/picked_cv_model.dart';
import 'package:vernita/features/home/data/repo/cv_repo.dart';
import 'package:vernita/features/home/data/repo/cv_repo_imp.dart';
import 'package:vernita/features/home/logic/cv_state.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';

class _CapturingHttpAdapter implements HttpClientAdapter {
  int statusCode = 200;
  String responseBody = '';
  Uint8List? responseBytes;
  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;

    final bytes = responseBytes;
    if (bytes != null) {
      return ResponseBody.fromBytes(
        bytes,
        statusCode,
        headers: {
          Headers.contentTypeHeader: ['application/octet-stream'],
        },
      );
    }

    return ResponseBody.fromString(
      responseBody,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FakeCvRepo implements CvRepo {
  Future<Either<ErrorHandler, List<CvResponseModel>>> Function()? onGetCvs;
  Future<Either<ErrorHandler, CvResponseModel>> Function(PickedCvModel cv)?
  onUploadCv;
  Future<Either<ErrorHandler, Unit>> Function(int id)? onDeleteCv;
  Future<Either<ErrorHandler, Uint8List>> Function(int id)? onDownloadCv;

  int getCvsCalls = 0;
  int uploadCvCalls = 0;
  int deleteCvCalls = 0;
  int downloadCvCalls = 0;

  @override
  Future<Either<ErrorHandler, List<CvResponseModel>>> getCvs() {
    getCvsCalls++;
    return onGetCvs!();
  }

  @override
  Future<Either<ErrorHandler, CvResponseModel>> uploadCv(PickedCvModel cv) {
    uploadCvCalls++;
    return onUploadCv!(cv);
  }

  @override
  Future<Either<ErrorHandler, Unit>> deleteCv(int id) {
    deleteCvCalls++;
    return onDeleteCv!(id);
  }

  @override
  Future<Either<ErrorHandler, Uint8List>> downloadCv(int id) {
    downloadCvCalls++;
    return onDownloadCv!(id);
  }
}

CvRemoteDataSource _dataSourceWith(_CapturingHttpAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: ApiEndPoints.apiBaseUrl));
  dio.httpClientAdapter = adapter;
  return CvRemoteDataSource(dio);
}

CvResponseModel _cv({
  required int id,
  required bool active,
  String fileType = 'PDF',
}) {
  return CvResponseModel(
    id: id,
    fileName: 'cv-$id.pdf',
    fileType: fileType,
    fileSize: 1024,
    active: active,
    uploadedAt: '2026-11-08T10:00:00',
  );
}

void main() {
  group('CV API contract', () {
    test('uploads the selected file in the "file" multipart field', () async {
      final tempDirectory = await Directory.systemTemp.createTemp(
        'vernita_cv_test',
      );
      addTearDown(() async {
        try {
          await tempDirectory.delete(recursive: true);
        } on FileSystemException {
          // The multipart stream can still hold the temporary file on Windows.
        }
      });

      final selectedFile = File(
        '${tempDirectory.path}${Platform.pathSeparator}my-cv.pdf',
      );
      await selectedFile.writeAsBytes([1, 2, 3]);

      final adapter = _CapturingHttpAdapter()
        ..statusCode = 201
        ..responseBody = '''
          {
            "id": 1,
            "fileName": "my-cv.pdf",
            "fileType": "PDF",
            "fileSize": 1024,
            "active": true,
            "uploadedAt": "2026-11-08T10:00:00"
          }
        ''';
      final dataSource = _dataSourceWith(adapter);

      final result = await dataSource.uploadCv(
        PickedCvModel(
          name: 'my-cv.pdf',
          path: selectedFile.path,
          sizeInBytes: 3,
        ),
      );

      final request = adapter.lastRequest!;
      final data = request.data as FormData;

      expect(request.method, 'POST');
      expect(request.uri.path, ApiEndPoints.uploadCv);
      expect(data.files.single.key, 'file');
      expect(data.files.single.value.filename, 'my-cv.pdf');
      expect(
        request.headers[Headers.contentTypeHeader].toString(),
        contains('multipart/form-data; boundary='),
      );
      expect(result.id, 1);
      expect(result.active, isTrue);
    });

    test(
      'parses the CV list without assuming the active CV is first',
      () async {
        final adapter = _CapturingHttpAdapter()
          ..responseBody = '''
          [
            {
              "id": 2,
              "fileName": "old.pdf",
              "fileType": "PDF",
              "fileSize": 2048,
              "active": false,
              "uploadedAt": "2026-11-08T09:00:00"
            },
            {
              "id": 1,
              "fileName": "current.pdf",
              "fileType": "DOCX",
              "fileSize": 4096,
              "active": true,
              "uploadedAt": "2026-11-08T10:00:00"
            }
          ]
        ''';
        final dataSource = _dataSourceWith(adapter);

        final cvs = await dataSource.getCvs();

        expect(adapter.lastRequest!.method, 'GET');
        expect(adapter.lastRequest!.uri.path, ApiEndPoints.getCv);
        expect(cvs, hasLength(2));
        expect(cvs[0].active, isFalse);
        expect(cvs[1].active, isTrue);
        expect(cvs[1].fileName, 'current.pdf');
      },
    );

    test(
      'treats a missing CV list body as an error, not an empty list',
      () async {
        final adapter = _CapturingHttpAdapter()..responseBody = 'null';
        final repo = CvRepoImp(_dataSourceWith(adapter));

        final result = await repo.getCvs();

        expect(result.isLeft(), isTrue);
      },
    );

    test('attaches the bearer token to CV requests', () async {
      final adapter = _CapturingHttpAdapter()..responseBody = '[]';
      final dio = Dio(BaseOptions(baseUrl: ApiEndPoints.apiBaseUrl))
        ..httpClientAdapter = adapter;
      dio.interceptors.add(
        AuthInterceptor(
          readToken: () async => 'secure-token',
          onUnauthorized: () async {},
        ),
      );
      final dataSource = CvRemoteDataSource(dio);

      await dataSource.getCvs();

      expect(
        adapter.lastRequest!.headers['Authorization'],
        'Bearer secure-token',
      );
    });

    test('deletes a CV with a bodyless 204 response', () async {
      final adapter = _CapturingHttpAdapter()
        ..statusCode = 204
        ..responseBytes = Uint8List(0);
      final dataSource = _dataSourceWith(adapter);

      await dataSource.deleteCv(7);

      expect(adapter.lastRequest!.method, 'DELETE');
      expect(adapter.lastRequest!.uri.path, ApiEndPoints.deleteResume(7));
    });

    test('downloads binary CV bytes without JSON deserialization', () async {
      final adapter = _CapturingHttpAdapter()
        ..responseBytes = Uint8List.fromList([37, 80, 68, 70]);
      final dataSource = _dataSourceWith(adapter);

      final bytes = await dataSource.downloadCv(7);

      expect(adapter.lastRequest!.method, 'GET');
      expect(adapter.lastRequest!.uri.path, ApiEndPoints.downloadResume(7));
      expect(adapter.lastRequest!.responseType, ResponseType.bytes);
      expect(bytes, [37, 80, 68, 70]);
    });

    test('rejects an empty downloaded file', () async {
      final adapter = _CapturingHttpAdapter()..responseBytes = Uint8List(0);
      final repo = CvRepoImp(_dataSourceWith(adapter));

      final result = await repo.downloadCv(7);

      expect(result.isLeft(), isTrue);
    });
  });

  group('CV Home state', () {
    test('starts with an initial state that does not claim an empty list', () {
      final cubit = CvUploadCubit(_FakeCvRepo());

      expect(cubit.state, isA<CvInitial>());
      expect(cubit.state.cvs, isEmpty);
      cubit.close();
    });

    test('uses the active flag instead of list position', () async {
      final repo = _FakeCvRepo()
        ..onGetCvs = () async =>
            right([_cv(id: 2, active: false), _cv(id: 1, active: true)]);
      final cubit = CvUploadCubit(repo);

      await cubit.fetchCvs();

      expect(cubit.state, isA<CvLoaded>());
      final loadedState = cubit.state as CvLoaded;
      expect(loadedState.cv?.id, 1);
      expect(loadedState.cvs, hasLength(2));
      expect(loadedState.actionType, CvActionType.fetch);
      await cubit.close();
    });

    test('treats an empty list as no CV', () async {
      final repo = _FakeCvRepo()..onGetCvs = () async => right([]);
      final cubit = CvUploadCubit(repo);

      await cubit.fetchCvs();

      expect(cubit.state, isA<CvLoaded>());
      final loadedState = cubit.state as CvLoaded;
      expect(loadedState.cv, isNull);
      expect(loadedState.cvs, isEmpty);
      expect(loadedState.actionType, CvActionType.fetch);
      await cubit.close();
    });

    test('treats a failed fetch as an error, not an empty list', () async {
      final repo = _FakeCvRepo()
        ..onGetCvs = () async => left(ErrorHandler.local('Network failed'));
      final cubit = CvUploadCubit(repo);

      await cubit.fetchCvs();

      expect(cubit.state, isA<CvError>());
      final errorState = cubit.state as CvError;
      expect(errorState.message, 'Network failed');
      expect(errorState.cvs, isEmpty);
      expect(errorState.actionType, CvActionType.fetch);
      await cubit.close();
    });

    test('ignores duplicate fetch requests while one is in flight', () async {
      final completer =
          Completer<Either<ErrorHandler, List<CvResponseModel>>>();
      final repo = _FakeCvRepo()..onGetCvs = () => completer.future;
      final cubit = CvUploadCubit(repo);

      final firstFetch = cubit.fetchCvs();
      final secondFetch = cubit.fetchCvs();

      expect(repo.getCvsCalls, 1);

      completer.complete(right([_cv(id: 1, active: true)]));
      await Future.wait([firstFetch, secondFetch]);

      expect(cubit.state, isA<CvLoaded>());
      expect((cubit.state as CvLoaded).cv?.id, 1);
      await cubit.close();
    });

    test('refreshes the list after a successful upload', () async {
      var getCalls = 0;
      final repo = _FakeCvRepo()
        ..onGetCvs = () async {
          getCalls++;
          return right([_cv(id: 1, active: getCalls > 1)]);
        }
        ..onUploadCv = (_) async => right(_cv(id: 1, active: true));
      final cubit = CvUploadCubit(repo);

      await cubit.fetchCvs();
      expect(cubit.state, isA<CvLoaded>());
      expect((cubit.state as CvLoaded).cv, isNull);

      await cubit.uploadCv(
        const PickedCvModel(
          name: 'my-cv.pdf',
          path: '/tmp/my-cv.pdf',
          sizeInBytes: 1024,
        ),
      );

      expect(repo.uploadCvCalls, 1);
      expect(repo.getCvsCalls, 2);
      expect(cubit.state, isA<CvLoaded>());
      final loadedState = cubit.state as CvLoaded;
      expect(loadedState.cv?.id, 1);
      expect(loadedState.actionType, CvActionType.upload);
      await cubit.close();
    });

    test(
      'does not treat an uploaded CV as active until the refresh confirms it',
      () async {
        final repo = _FakeCvRepo()
          ..onGetCvs = () async {
            return right([_cv(id: 1, active: false)]);
          }
          ..onUploadCv = (_) async => right(_cv(id: 1, active: true));
        final cubit = CvUploadCubit(repo);

        await cubit.fetchCvs();
        await cubit.uploadCv(
          const PickedCvModel(
            name: 'my-cv.pdf',
            path: '/tmp/my-cv.pdf',
            sizeInBytes: 1024,
          ),
        );

        expect(repo.uploadCvCalls, 1);
        expect(repo.getCvsCalls, 2);
        expect(cubit.state, isA<CvLoaded>());
        final loadedState = cubit.state as CvLoaded;
        expect(loadedState.cv, isNull);
        expect(loadedState.cvs, hasLength(1));
        expect(loadedState.actionType, CvActionType.upload);
        await cubit.close();
      },
    );

    test('does not refresh after a failed upload', () async {
      final repo = _FakeCvRepo()
        ..onGetCvs = () async {
          return right([_cv(id: 1, active: false)]);
        }
        ..onUploadCv = (_) async => left(ErrorHandler.local('Upload failed'));
      final cubit = CvUploadCubit(repo);

      await cubit.fetchCvs();
      await cubit.uploadCv(
        const PickedCvModel(
          name: 'my-cv.pdf',
          path: '/tmp/my-cv.pdf',
          sizeInBytes: 1024,
        ),
      );

      expect(repo.uploadCvCalls, 1);
      expect(repo.getCvsCalls, 1);
      expect(cubit.state, isA<CvError>());
      final errorState = cubit.state as CvError;
      expect(errorState.message, 'Upload failed');
      expect(errorState.actionType, CvActionType.upload);
      expect(errorState.fileName, 'my-cv.pdf');
      await cubit.close();
    });

    test('refreshes the list after deleting the active CV', () async {
      var getCalls = 0;
      final repo = _FakeCvRepo()
        ..onGetCvs = () async {
          getCalls++;
          return right(getCalls == 1 ? [_cv(id: 1, active: true)] : []);
        }
        ..onDeleteCv = (_) async => right(unit);
      final cubit = CvUploadCubit(repo);

      await cubit.fetchCvs();
      expect(cubit.state, isA<CvLoaded>());

      await cubit.deleteCv(1);

      expect(repo.deleteCvCalls, 1);
      expect(repo.getCvsCalls, 2);
      expect(cubit.state, isA<CvLoaded>());
      final loadedState = cubit.state as CvLoaded;
      expect(loadedState.cv, isNull);
      expect(loadedState.cvs, isEmpty);
      expect(loadedState.actionType, CvActionType.delete);
      await cubit.close();
    });

    test('does not refresh or report success when deletion fails', () async {
      final repo = _FakeCvRepo()
        ..onGetCvs = () async {
          return right([_cv(id: 1, active: true)]);
        }
        ..onDeleteCv = (_) async => left(ErrorHandler.local('Delete failed'));
      final cubit = CvUploadCubit(repo);

      await cubit.fetchCvs();
      await cubit.deleteCv(1);

      expect(repo.deleteCvCalls, 1);
      expect(repo.getCvsCalls, 1);
      expect(cubit.state, isA<CvError>());
      final errorState = cubit.state as CvError;
      expect(errorState.message, 'Delete failed');
      expect(errorState.actionType, CvActionType.delete);
      expect(errorState.cvs, hasLength(1));
      expect(errorState.cvs.single.active, isTrue);
      await cubit.close();
    });

    test('rejects invalid binary CV content before saving', () async {
      final repo = _FakeCvRepo()
        ..onGetCvs = () async {
          return right([_cv(id: 1, active: true)]);
        }
        ..onDownloadCv = (_) async => right(Uint8List.fromList([1, 2, 3]));
      final cubit = CvUploadCubit(repo);

      await cubit.fetchCvs();
      await cubit.downloadCv(1);

      expect(repo.downloadCvCalls, 1);
      expect(cubit.state, isA<CvError>());
      final errorState = cubit.state as CvError;
      expect(errorState.actionType, CvActionType.download);
      expect(errorState.message, contains('invalid'));
      expect(errorState.cvs, hasLength(1));
      await cubit.close();
    });
  });
}
