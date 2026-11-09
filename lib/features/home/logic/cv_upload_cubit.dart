import 'dart:io';

import 'package:file_picker/file_picker.dart' as picker;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/home/data/models/cv_response_model.dart';
import 'package:vernita/features/home/data/models/picked_cv_model.dart';
import 'package:vernita/features/home/data/repo/cv_repo.dart';
import 'package:vernita/features/home/logic/cv_rules.dart';
import 'package:vernita/features/home/logic/cv_state.dart';

class CvUploadCubit extends Cubit<CvState> {
  CvUploadCubit(this._cvRepo) : super(const CvState.initial());

  final CvRepo _cvRepo;

  bool _isFetching = false;
  bool _isUploading = false;
  bool _isDeleting = false;
  bool _isDownloading = false;

  bool get _isBusy =>
      _isFetching || _isUploading || _isDeleting || _isDownloading;

  Future<void> fetchCvs({bool showLoading = true}) async {
    if (_isBusy) return;

    _isFetching = true;
    final previousCvs = state.cvs;

    if (showLoading) {
      _safeEmit(
        CvState.loading(cvs: previousCvs, actionType: CvActionType.fetch),
      );
    }

    final result = await _cvRepo.getCvs();
    _isFetching = false;

    result.fold(
      (failure) {
        _safeEmit(
          CvState.error(
            message: failure.apiErrorModel.displayMessage,
            cvs: previousCvs,
            actionType: CvActionType.fetch,
          ),
        );
      },
      (cvs) {
        _safeEmit(_loadedState(cvs, CvActionType.fetch));
      },
    );
  }

  Future<void> pickCv() async {
    if (_isBusy) return;

    final previousCvs = state.cvs;
    _safeEmit(
      CvState.loading(cvs: previousCvs, actionType: CvActionType.upload),
    );

    try {
      final result = await picker.FilePicker.pickFiles(
        type: picker.FileType.custom,
        allowedExtensions: CvRules.allowedExtensions,
      );

      if (result.isEmpty) {
        _safeEmit(_loadedState(previousCvs, CvActionType.fetch));
        return;
      }

      final file = result.single;
      final extension = (file.extension ?? '').toLowerCase();
      final path = file.path;

      debugPrint('Selected file: ${file.name}');
      debugPrint('Selected extension: $extension');

      if (!CvRules.allowedExtensions.contains(extension)) {
        _safeEmit(
          CvState.error(
            message: 'Unsupported file format. Please choose PDF or DOCX.',
            fileName: file.name,
            cvs: previousCvs,
            actionType: CvActionType.upload,
          ),
        );
        return;
      }

      if (path == null || path.isEmpty) {
        _safeEmit(
          CvState.error(
            message: 'We couldn\'t read this file. Please try another one.',
            fileName: file.name,
            cvs: previousCvs,
            actionType: CvActionType.upload,
          ),
        );
        return;
      }

      final sizeInBytes = await File(path).length();

      if (sizeInBytes > CvRules.maxSizeInBytes) {
        _safeEmit(
          CvState.error(
            message: 'Your CV exceeds the maximum allowed file size.',
            fileName: file.name,
            sizeInBytes: sizeInBytes,
            cvs: previousCvs,
            actionType: CvActionType.upload,
          ),
        );
        return;
      }

      await uploadCv(
        PickedCvModel(name: file.name, path: path, sizeInBytes: sizeInBytes),
        fileName: file.name,
        sizeInBytes: sizeInBytes,
      );
    } catch (e, stackTrace) {
      debugPrint('CV picking failed: $e');
      debugPrintStack(stackTrace: stackTrace);

      _safeEmit(
        CvState.error(
          message:
              'Something went wrong while uploading your CV. Please try again.',
          cvs: previousCvs,
          actionType: CvActionType.upload,
        ),
      );
    }
  }

  Future<void> uploadCv(
    PickedCvModel cv, {
    String? fileName,
    int? sizeInBytes,
  }) async {
    if (_isBusy) return;

    final previousCvs = state.cvs;
    _isUploading = true;
    _safeEmit(
      CvState.loading(cvs: previousCvs, actionType: CvActionType.upload),
    );

    try {
      final result = await _cvRepo.uploadCv(cv);
      _isUploading = false;

      await result.fold(
        (failure) async {
          _safeEmit(
            CvState.error(
              message: failure.apiErrorModel.displayMessage,
              fileName: fileName ?? cv.name,
              sizeInBytes: sizeInBytes ?? cv.sizeInBytes,
              cvs: previousCvs,
              actionType: CvActionType.upload,
            ),
          );
        },
        (_) async {
          await fetchCvs(showLoading: false);
          final refreshedState = state;
          if (refreshedState is CvLoaded) {
            _safeEmit(
              CvState.loaded(
                cvs: refreshedState.cvs,
                actionType: CvActionType.upload,
                cv: _activeCv(refreshedState.cvs),
              ),
            );
          }
        },
      );
    } catch (e, stackTrace) {
      _isUploading = false;
      debugPrint('CV upload failed: $e');
      debugPrintStack(stackTrace: stackTrace);

      _safeEmit(
        CvState.error(
          message:
              'Something went wrong while uploading your CV. Please try again.',
          fileName: fileName ?? cv.name,
          sizeInBytes: sizeInBytes ?? cv.sizeInBytes,
          cvs: previousCvs,
          actionType: CvActionType.upload,
        ),
      );
    }
  }

  Future<void> deleteCv(int id) async {
    if (_isBusy) return;

    final previousState = state;
    final cv = _findCv(previousState.cvs, id);

    if (cv == null) {
      _safeEmit(
        CvState.error(
          message: 'The selected CV could not be found.',
          cvs: previousState.cvs,
          actionType: CvActionType.delete,
        ),
      );
      return;
    }

    _isDeleting = true;
    _safeEmit(
      CvState.loading(cvs: previousState.cvs, actionType: CvActionType.delete),
    );

    final result = await _cvRepo.deleteCv(id);
    _isDeleting = false;

    await result.fold(
      (failure) async {
        _safeEmit(
          CvState.error(
            message: failure.apiErrorModel.displayMessage,
            cvs: previousState.cvs,
            actionType: CvActionType.delete,
          ),
        );
      },
      (_) async {
        await fetchCvs(showLoading: false);
        final refreshedState = state;
        if (refreshedState is CvLoaded) {
          _safeEmit(
            CvState.loaded(
              cvs: refreshedState.cvs,
              actionType: CvActionType.delete,
              cv: _activeCv(refreshedState.cvs),
            ),
          );
        }
      },
    );
  }

  Future<void> downloadCv(int id) async {
    if (_isBusy) return;

    final currentState = state;
    final cv = _findCv(currentState.cvs, id);

    if (cv == null) {
      _safeEmit(
        CvState.error(
          message: 'The selected CV could not be found.',
          cvs: currentState.cvs,
          actionType: CvActionType.download,
        ),
      );
      return;
    }

    _isDownloading = true;
    _safeEmit(
      CvState.loading(cvs: currentState.cvs, actionType: CvActionType.download),
    );

    final result = await _cvRepo.downloadCv(id);

    await result.fold(
      (failure) async {
        _isDownloading = false;
        _safeEmit(
          CvState.error(
            message: failure.apiErrorModel.displayMessage,
            cvs: currentState.cvs,
            actionType: CvActionType.download,
          ),
        );
      },
      (bytes) async {
        if (!_isValidDownloadedFile(bytes, cv.fileType)) {
          _isDownloading = false;
          _safeEmit(
            CvState.error(
              message:
                  'The downloaded CV file appears to be invalid. Please try again.',
              cvs: currentState.cvs,
              actionType: CvActionType.download,
            ),
          );
          return;
        }

        try {
          await picker.FilePicker.saveFile(
            fileName: cv.fileName,
            bytes: bytes,
            mimeType: _mimeTypeFor(cv.fileType),
            dialogTitle: 'Save your CV',
          );

          _isDownloading = false;
          _safeEmit(_loadedState(currentState.cvs, CvActionType.download));
        } catch (e, stackTrace) {
          _isDownloading = false;
          debugPrint('CV download save failed: $e');
          debugPrintStack(stackTrace: stackTrace);

          _safeEmit(
            CvState.error(
              message: 'Could not save your CV. Please try again.',
              cvs: currentState.cvs,
              actionType: CvActionType.download,
            ),
          );
        }
      },
    );
  }

  void removeCv() {
    _safeEmit(_loadedState(state.cvs, CvActionType.fetch));
  }

  CvState _loadedState(List<CvResponseModel> cvs, CvActionType actionType) {
    return CvState.loaded(cvs: cvs, actionType: actionType, cv: _activeCv(cvs));
  }

  CvResponseModel? _activeCv(List<CvResponseModel> cvs) {
    for (final cv in cvs) {
      if (cv.active) return cv;
    }
    return null;
  }

  CvResponseModel? _findCv(List<CvResponseModel> cvs, int id) {
    for (final cv in cvs) {
      if (cv.id == id) return cv;
    }
    return null;
  }

  bool _isValidDownloadedFile(Uint8List bytes, String fileType) {
    if (bytes.isEmpty) return false;

    final normalizedType = fileType.toLowerCase();
    if (normalizedType.contains('pdf')) {
      return bytes.length >= 4 &&
          bytes[0] == 0x25 &&
          bytes[1] == 0x50 &&
          bytes[2] == 0x44 &&
          bytes[3] == 0x46;
    }
    if (normalizedType.contains('docx')) {
      return bytes.length >= 2 && bytes[0] == 0x50 && bytes[1] == 0x4B;
    }
    return true;
  }

  String _mimeTypeFor(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      default:
        return 'application/octet-stream';
    }
  }

  void _safeEmit(CvState nextState) {
    if (!isClosed) emit(nextState);
  }
}
