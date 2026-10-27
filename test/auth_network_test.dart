import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vernita/core/helper/shared_pref_helper.dart';
import 'package:vernita/core/network/api_constants.dart';
import 'package:vernita/core/network/dio_factory.dart';
import 'package:vernita/core/network/interceptors/auth_interceptor.dart';
import 'package:vernita/core/storage/auth_token_storage.dart';

class _CapturingHttpAdapter implements HttpClientAdapter {
  int statusCode = 200;
  String responseBody = '{"message":"ok"}';
  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
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

void main() {
  late Dio dio;
  late _CapturingHttpAdapter adapter;
  late String? token;
  late int tokenReads;
  late int unauthorizedCalls;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    DioFactory.reset();
    dio = Dio(BaseOptions(baseUrl: ApiEndPoints.apiBaseUrl));
    adapter = _CapturingHttpAdapter();
    dio.httpClientAdapter = adapter;
    token = 'access-token';
    tokenReads = 0;
    unauthorizedCalls = 0;

    dio.interceptors.add(
      AuthInterceptor(
        readToken: () async {
          tokenReads++;
          return token;
        },
        onUnauthorized: () async {
          unauthorizedCalls++;
        },
      ),
    );
  });

  test('attaches the token to protected requests', () async {
    await dio.get('/api/v1/users/me');

    expect(
      adapter.lastRequest?.headers['Authorization'],
      'Bearer access-token',
    );
    expect(tokenReads, 1);
    expect(unauthorizedCalls, 0);
  });

  test('does not attach a token to public authentication requests', () async {
    await dio.post(ApiEndPoints.login, data: {'email': 'a@b.com'});

    expect(adapter.lastRequest?.headers.containsKey('Authorization'), isFalse);
    expect(tokenReads, 0);
  });

  test('public requests remove a header restored at startup', () async {
    dio.options.headers['Authorization'] = 'Bearer stored-token';

    await dio.post(ApiEndPoints.login, data: {'email': 'a@b.com'});

    expect(adapter.lastRequest?.headers.containsKey('Authorization'), isFalse);
    expect(tokenReads, 0);
  });

  test('does not attach an empty token', () async {
    token = '   ';

    await dio.get('/api/v1/users/me');

    expect(adapter.lastRequest?.headers.containsKey('Authorization'), isFalse);
  });

  test('a protected 401 invalidates the session', () async {
    adapter.statusCode = 401;
    adapter.responseBody = '{"message":"Session expired"}';

    await expectLater(
      dio.get('/api/v1/users/me'),
      throwsA(isA<DioException>()),
    );

    expect(unauthorizedCalls, 1);
  });

  test('a public 401 does not invalidate the session', () async {
    adapter.statusCode = 401;
    adapter.responseBody = '{"message":"Invalid email or password"}';

    await expectLater(
      dio.post(ApiEndPoints.login, data: {'email': 'a@b.com'}),
      throwsA(isA<DioException>()),
    );

    expect(unauthorizedCalls, 0);
  });

  test('a protected 403 does not invalidate the session', () async {
    adapter.statusCode = 403;
    adapter.responseBody = '{"message":"Forbidden"}';

    await expectLater(
      dio.get('/api/v1/users/me'),
      throwsA(isA<DioException>()),
    );

    expect(unauthorizedCalls, 0);
  });

  test(
    'a protected 401 without a token does not invalidate the session',
    () async {
      token = null;
      adapter.statusCode = 401;
      adapter.responseBody = '{"message":"Authentication required"}';

      await expectLater(
        dio.get('/api/v1/users/me'),
        throwsA(isA<DioException>()),
      );

      expect(unauthorizedCalls, 0);
    },
  );

  test(
    'DioFactory installs the centralized authentication interceptor',
    () async {
      final factoryDio = DioFactory.getDio(
        readToken: () async => 'factory-token',
        onUnauthorized: () async {},
      );
      factoryDio.httpClientAdapter = adapter;

      await factoryDio.get('/api/v1/users/me');

      expect(
        adapter.lastRequest?.headers['Authorization'],
        'Bearer factory-token',
      );
    },
  );

  test('DioFactory loads the secured token into its default headers', () async {
    FlutterSecureStorage.setMockInitialValues({
      SharedPrefKeys.userToken: 'secure-token',
    });
    final factoryDio = DioFactory.getDio();

    await DioFactory.addDioHeaders();

    expect(factoryDio.options.headers['Accept'], 'application/json');
    expect(factoryDio.options.headers['Authorization'], 'Bearer secure-token');
  });

  test('DioFactory omits the header when no usable token exists', () async {
    FlutterSecureStorage.setMockInitialValues({
      SharedPrefKeys.userToken: '   ',
    });
    final factoryDio = DioFactory.getDio();

    await DioFactory.addDioHeaders();

    expect(factoryDio.options.headers['Accept'], 'application/json');
    expect(factoryDio.options.headers.containsKey('Authorization'), isFalse);
  });

  test('setTokenIntoHeaderAfterLogin updates and clears the header', () {
    final factoryDio = DioFactory.getDio();

    DioFactory.setTokenIntoHeaderAfterLogin('new-token');
    expect(factoryDio.options.headers['Authorization'], 'Bearer new-token');

    DioFactory.setTokenIntoHeaderAfterLogin('   ');
    expect(factoryDio.options.headers.containsKey('Authorization'), isFalse);
  });

  test('protected requests use the token loaded from secure storage', () async {
    FlutterSecureStorage.setMockInitialValues({
      SharedPrefKeys.userToken: 'secure-token',
    });
    final storage = AuthTokenStorage();
    final factoryDio = DioFactory.getDio(
      readToken: storage.readToken,
      onUnauthorized: () async {},
    );
    await DioFactory.addDioHeaders();
    factoryDio.httpClientAdapter = adapter;

    await factoryDio.get('/api/v1/users/me');

    expect(
      adapter.lastRequest?.headers['Authorization'],
      'Bearer secure-token',
    );
  });
}
