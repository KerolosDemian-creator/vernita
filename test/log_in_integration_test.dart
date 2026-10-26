import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/storage/auth_token_storage.dart';
import 'package:vernita/features/authentication/logic/auth_rules.dart';
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

LogInResponseModel _response() => LogInResponseModel(
  id: 1,
  fullName: 'Test User',
  email: 'user@example.com',
  message: 'Login successful',
  accessToken: 'test-access-token',
  tokenType: 'Bearer',
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
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
    final cubit = LogInCubit(repo, AuthTokenStorage());

    cubit.emailController.text = '  user@example.com  ';
    cubit.passwordController.text = 'password123';
    await cubit.submit();

    expect(cubit.state.status, LogInStatus.success);
    expect(cubit.state.response?.accessToken, 'test-access-token');
    expect(repo.lastRequest?.email, 'user@example.com');
    expect(repo.lastRequest?.rememberMe, isTrue);
    expect(await AuthTokenStorage().readToken(), 'test-access-token');
  });

  test('submit emits loading until the API responds', () async {
    final repo = _PendingLogInRepo();
    final cubit = LogInCubit(repo, AuthTokenStorage());

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
    final cubit = LogInCubit(repo, AuthTokenStorage());
    cubit.toggleRememberMe(false);

    cubit.emailController.text = 'user@example.com';
    cubit.passwordController.text = 'password123';
    await cubit.submit();

    expect(cubit.state.status, LogInStatus.success);
    expect(repo.lastRequest?.rememberMe, isFalse);
    expect(await AuthTokenStorage().readToken(), isNull);
  });

  test('failed login emits the backend message', () async {
    final repo = _FakeLogInRepo(
      left(ErrorHandler.local('Invalid email or password')),
    );
    final cubit = LogInCubit(repo, AuthTokenStorage());

    cubit.emailController.text = 'user@example.com';
    cubit.passwordController.text = 'wrong-password';
    await cubit.submit();

    expect(cubit.state.status, LogInStatus.failure);
    expect(cubit.state.errorMessage, 'Invalid email or password');
  });
}
