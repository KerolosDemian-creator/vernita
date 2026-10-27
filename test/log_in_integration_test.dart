import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/helper/shared_pref_helper.dart';
import 'package:vernita/core/network/dio_factory.dart';
import 'package:vernita/core/storage/auth_token_storage.dart';
import 'package:vernita/features/authentication/logic/auth_rules.dart';
import 'package:vernita/features/authentication/logic/auth_session_cubit.dart';
import 'package:vernita/features/authentication/log_in/data/models/log_in_request_model.dart';
import 'package:vernita/features/authentication/log_in/data/models/log_in_response_model.dart';
import 'package:vernita/features/authentication/log_in/data/repo/log_in_repo.dart';
import 'package:vernita/features/authentication/log_in/logic/log_in_cubit.dart';
import 'package:vernita/features/authentication/log_in/logic/log_in_state.dart';

class _FakeLogInRepo implements LogInRepo {
  _FakeLogInRepo(this.result);

  final Either<ErrorHandler, LogInResponseModel> result;
  LogInRequestModel? lastRequest;

  @override
  Future<Either<ErrorHandler, LogInResponseModel>> logIn(
    LogInRequestModel logInRequestBody,
  ) async {
    lastRequest = logInRequestBody;
    return result;
  }
}

class _PendingLogInRepo implements LogInRepo {
  final completer = Completer<Either<ErrorHandler, LogInResponseModel>>();

  @override
  Future<Either<ErrorHandler, LogInResponseModel>> logIn(
    LogInRequestModel logInRequestBody,
  ) => completer.future;
}

class _FailingAuthTokenStorage extends AuthTokenStorage {
  @override
  Future<void> saveToken({
    required String accessToken,
    required bool rememberMe,
  }) async {
    throw StateError('Secure storage is unavailable.');
  }
}

LogInResponseModel _response({String accessToken = 'test-access-token'}) =>
    LogInResponseModel(
      id: 1,
      fullName: 'Test User',
      email: 'user@example.com',
      message: 'Login successful',
      accessToken: accessToken,
      tokenType: 'Bearer',
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    DioFactory.reset();
  });

  group('login password minimum length', () {
    test('rejects passwords shorter than 8 characters', () {
      expect(
        AuthRules.password('1234567'),
        'Password must be at least 8 characters',
      );
    });

    test('accepts passwords with exactly 8 characters', () {
      expect(AuthRules.password('12345678'), isNull);
    });

    test('accepts passwords longer than 8 characters', () {
      expect(AuthRules.password('123456789'), isNull);
    });
  });

  test('login request JSON excludes rememberMe', () {
    const request = LogInRequestModel(
      email: 'user@example.com',
      password: 'password123',
      rememberMe: true,
    );

    expect(request.toJson(), {
      'email': 'user@example.com',
      'password': 'password123',
    });
  });

  test('remember me persists the access token', () async {
    final storage = AuthTokenStorage();

    await storage.saveToken(accessToken: 'remembered-token', rememberMe: true);

    expect(await AuthTokenStorage().readToken(), 'remembered-token');
    expect(
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken),
      'remembered-token',
    );
  });

  test('remember me disabled keeps the token in memory only', () async {
    final storage = AuthTokenStorage();
    await storage.saveToken(accessToken: 'remembered-token', rememberMe: true);

    await storage.saveToken(accessToken: 'session-token', rememberMe: false);

    expect(await storage.readToken(), 'session-token');
    expect(await AuthTokenStorage().readToken(), isNull);
  });

  test('successful login stores the token and emits success', () async {
    final repo = _FakeLogInRepo(right(_response()));
    final storage = AuthTokenStorage();
    final session = AuthSessionCubit(storage);
    final cubit = LogInCubit(repo, session);
    addTearDown(cubit.close);

    cubit.emailController.text = '  user@example.com  ';
    cubit.passwordController.text = 'password123';
    await cubit.submit();

    expect(cubit.state.status, LogInStatus.success);
    expect(cubit.state.response?.accessToken, 'test-access-token');
    expect(repo.lastRequest?.email, 'user@example.com');
    expect(repo.lastRequest?.rememberMe, isTrue);
    expect(session.isLoggedInUser, isTrue);
    expect(await AuthTokenStorage().readToken(), 'test-access-token');
    expect(
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken),
      'test-access-token',
    );
  });

  test('successful login updates the Dio authorization header', () async {
    final dio = DioFactory.getDio();
    final repo = _FakeLogInRepo(right(_response()));
    final session = AuthSessionCubit(AuthTokenStorage());
    final cubit = LogInCubit(repo, session);
    addTearDown(cubit.close);

    cubit.emailController.text = 'user@example.com';
    cubit.passwordController.text = 'password123';
    await cubit.submit();

    expect(cubit.state.status, LogInStatus.success);
    expect(dio.options.headers['Authorization'], 'Bearer test-access-token');
  });

  test('login fails when the token cannot be persisted', () async {
    final repo = _FakeLogInRepo(right(_response()));
    final session = AuthSessionCubit(_FailingAuthTokenStorage());
    final cubit = LogInCubit(repo, session);
    addTearDown(cubit.close);

    cubit.emailController.text = 'user@example.com';
    cubit.passwordController.text = 'password123';
    await cubit.submit();

    expect(cubit.state.status, LogInStatus.failure);
    expect(
      cubit.state.errorMessage,
      'Could not save your session. Please try again.',
    );
    expect(session.isLoggedInUser, isFalse);
  });

  test('login does not succeed with an empty token', () async {
    final repo = _FakeLogInRepo(right(_response(accessToken: '   ')));
    final session = AuthSessionCubit(AuthTokenStorage());
    final cubit = LogInCubit(repo, session);
    addTearDown(cubit.close);

    cubit.emailController.text = 'user@example.com';
    cubit.passwordController.text = 'password123';
    await cubit.submit();

    expect(cubit.state.status, LogInStatus.failure);
    expect(session.isLoggedInUser, isFalse);
    expect(
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken),
      isEmpty,
    );
  });

  test('submit emits loading until the API responds', () async {
    final repo = _PendingLogInRepo();
    final cubit = LogInCubit(repo, AuthSessionCubit(AuthTokenStorage()));
    addTearDown(cubit.close);

    cubit.emailController.text = 'user@example.com';
    cubit.passwordController.text = 'password123';
    final submission = cubit.submit();
    expect(cubit.state.status, LogInStatus.loading);

    repo.completer.complete(right(_response()));
    await submission;

    expect(cubit.state.status, LogInStatus.success);
  });

  test('remember me disabled login does not persist the token', () async {
    final repo = _FakeLogInRepo(right(_response()));
    final session = AuthSessionCubit(AuthTokenStorage());
    final cubit = LogInCubit(repo, session);
    addTearDown(cubit.close);
    cubit.toggleRememberMe(false);

    cubit.emailController.text = 'user@example.com';
    cubit.passwordController.text = 'password123';
    await cubit.submit();

    expect(cubit.state.status, LogInStatus.success);
    expect(repo.lastRequest?.rememberMe, isFalse);
    expect(session.isLoggedInUser, isTrue);
    expect(await AuthTokenStorage().readToken(), isNull);
    expect(
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken),
      isEmpty,
    );
  });

  test('failed login emits the backend message', () async {
    final repo = _FakeLogInRepo(
      left(ErrorHandler.local('Invalid email or password')),
    );
    final session = AuthSessionCubit(AuthTokenStorage());
    final cubit = LogInCubit(repo, session);
    addTearDown(cubit.close);

    cubit.emailController.text = 'user@example.com';
    cubit.passwordController.text = 'wrong-password';
    await cubit.submit();

    expect(cubit.state.status, LogInStatus.failure);
    expect(cubit.state.errorMessage, 'Invalid email or password');
    expect(session.isLoggedInUser, isFalse);
  });
}
