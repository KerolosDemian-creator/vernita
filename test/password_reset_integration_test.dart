import 'dart:async';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/network/api_constants.dart';
import 'package:vernita/core/network/api_service.dart';
import 'package:vernita/core/network/models/message_response_model.dart';
import 'package:vernita/features/authentication/forget_password/data/models/forget_pass_request_model.dart';
import 'package:vernita/features/authentication/forget_password/data/repo/forget_pass_repo.dart';
import 'package:vernita/features/authentication/forget_password/logic/forget_pass_cubit.dart';
import 'package:vernita/features/authentication/forget_password/logic/forget_pass_state.dart';
import 'package:vernita/features/authentication/logic/auth_rules.dart';
import 'package:vernita/features/authentication/reset_password/data/models/reset_pass_request_model.dart';
import 'package:vernita/features/authentication/reset_password/data/repo/reset_pass_repo.dart';
import 'package:vernita/features/authentication/reset_password/logic/reset_pass_cubit.dart';
import 'package:vernita/features/authentication/reset_password/logic/reset_pass_state.dart';

class _CapturingHttpAdapter implements HttpClientAdapter {
  RequestOptions? lastRequest;
  String responseBody = '{"message":"ok"}';

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    return ResponseBody.fromString(
      responseBody,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FakeForgetPassRepo implements ForgetPassRepo {
  _FakeForgetPassRepo(this.result);

  final Either<ErrorHandler, MessageResponseModel> result;
  ForgetPassRequestModel? lastRequest;
  int calls = 0;

  @override
  Future<Either<ErrorHandler, MessageResponseModel>> forgotPassword(
    ForgetPassRequestModel forgetPassRequestBody,
  ) async {
    calls++;
    lastRequest = forgetPassRequestBody;
    return result;
  }
}

class _PendingForgetPassRepo implements ForgetPassRepo {
  _PendingForgetPassRepo(this.completer);

  final Completer<Either<ErrorHandler, MessageResponseModel>> completer;

  @override
  Future<Either<ErrorHandler, MessageResponseModel>> forgotPassword(
    ForgetPassRequestModel forgetPassRequestBody,
  ) {
    return completer.future;
  }
}

class _FakeResetPassRepo implements ResetPassRepo {
  _FakeResetPassRepo(this.result);

  final Either<ErrorHandler, MessageResponseModel> result;
  ResetPassRequestModel? lastRequest;
  int calls = 0;

  @override
  Future<Either<ErrorHandler, MessageResponseModel>> resetPassword(
    ResetPassRequestModel resetPassRequestBody,
  ) async {
    calls++;
    lastRequest = resetPassRequestBody;
    return result;
  }
}

void main() {
  group('password recovery API contract', () {
    late Dio dio;
    late _CapturingHttpAdapter adapter;
    late ApiService apiService;

    setUp(() {
      dio = Dio(BaseOptions(baseUrl: ApiEndPoints.apiBaseUrl));
      adapter = _CapturingHttpAdapter();
      dio.httpClientAdapter = adapter;
      apiService = ApiService(dio);
    });

    test('forgot password posts the email to the backend endpoint', () async {
      final response = await apiService.forgotPassword(
        const ForgetPassRequestModel(email: 'user@example.com'),
      );

      expect(response.message, 'ok');
      expect(adapter.lastRequest?.method, 'POST');
      expect(adapter.lastRequest?.path, ApiEndPoints.forgotPassword);
      expect(adapter.lastRequest?.data, {'email': 'user@example.com'});
    });

    test('reset password posts email, code, and newPassword', () async {
      final response = await apiService.resetPassword(
        const ResetPassRequestModel(
          email: 'user@example.com',
          code: '123456',
          newPassword: 'newPassword1',
        ),
      );

      expect(response.message, 'ok');
      expect(adapter.lastRequest?.method, 'POST');
      expect(adapter.lastRequest?.path, ApiEndPoints.resetPassword);
      expect(adapter.lastRequest?.data, {
        'email': 'user@example.com',
        'code': '123456',
        'newPassword': 'newPassword1',
      });
    });
  });

  group('ForgetPassCubit', () {
    test('trims the email and exposes the backend confirmation', () async {
      final repo = _FakeForgetPassRepo(
        right(
          const MessageResponseModel(
            message: 'If an account exists, a reset code has been sent.',
          ),
        ),
      );
      final cubit = ForgetPassCubit(repo);
      addTearDown(cubit.close);
      cubit.emailController.text = '  user@example.com  ';

      await cubit.sendResetCode();

      expect(repo.calls, 1);
      expect(repo.lastRequest?.email, 'user@example.com');
      expect(cubit.state.status, ForgetPassStatus.success);
      expect(cubit.state.email, 'user@example.com');
      expect(
        cubit.state.message,
        'If an account exists, a reset code has been sent.',
      );
    });

    test('emits loading while the request is in flight', () async {
      final completer = Completer<Either<ErrorHandler, MessageResponseModel>>();
      final cubit = ForgetPassCubit(_PendingForgetPassRepo(completer));
      addTearDown(cubit.close);
      cubit.emailController.text = 'user@example.com';

      final request = cubit.sendResetCode();
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.status, ForgetPassStatus.loading);

      completer.complete(
        right(const MessageResponseModel(message: 'Code sent')),
      );
      await request;

      expect(cubit.state.status, ForgetPassStatus.success);
    });

    test('maps repository failures to the failure state', () async {
      final repo = _FakeForgetPassRepo(
        left(ErrorHandler.local('Unable to send reset code')),
      );
      final cubit = ForgetPassCubit(repo);
      addTearDown(cubit.close);
      cubit.emailController.text = 'user@example.com';

      await cubit.sendResetCode();

      expect(cubit.state.status, ForgetPassStatus.failure);
      expect(cubit.state.message, 'Unable to send reset code');
    });
  });

  group('ResetPassCubit', () {
    test('sends trimmed credentials and emits success', () async {
      final repo = _FakeResetPassRepo(
        right(
          const MessageResponseModel(
            message: 'Password has been reset successfully.',
          ),
        ),
      );
      final cubit = ResetPassCubit(repo);
      addTearDown(cubit.close);
      cubit.emailController.text = '  user@example.com  ';
      cubit.codeController.text = ' 123456 ';
      cubit.passwordController.text = 'newPassword1';

      await cubit.resetPassword();

      expect(repo.calls, 1);
      expect(repo.lastRequest?.email, 'user@example.com');
      expect(repo.lastRequest?.code, '123456');
      expect(repo.lastRequest?.newPassword, 'newPassword1');
      expect(cubit.state.status, ResetPassStatus.success);
      expect(cubit.state.message, 'Password has been reset successfully.');
    });

    test('maps invalid or expired code responses to failure', () async {
      final repo = _FakeResetPassRepo(
        left(ErrorHandler.local('Invalid or expired reset code')),
      );
      final cubit = ResetPassCubit(repo);
      addTearDown(cubit.close);
      cubit.emailController.text = 'user@example.com';
      cubit.codeController.text = '123456';
      cubit.passwordController.text = 'newPassword1';

      await cubit.resetPassword();

      expect(cubit.state.status, ResetPassStatus.failure);
      expect(cubit.state.message, 'Invalid or expired reset code');
    });
  });

  group('password recovery validation', () {
    test('reset code must contain exactly six digits', () {
      expect(AuthRules.resetCode(''), 'Please enter the reset code');
      expect(AuthRules.resetCode('12345'), 'Reset code must be 6 digits');
      expect(AuthRules.resetCode('1234567'), 'Reset code must be 6 digits');
      expect(AuthRules.resetCode('12345a'), 'Reset code must be 6 digits');
      expect(AuthRules.resetCode('123456'), isNull);
      expect(AuthRules.resetCode(' 123456 '), isNull);
    });

    test('new password follows the backend 8-100 character rule', () {
      expect(
        AuthRules.resetPassword('1234567'),
        'Password must be at least 8 characters',
      );
      expect(AuthRules.resetPassword('12345678'), isNull);
      expect(AuthRules.resetPassword('a' * 100), isNull);
      expect(
        AuthRules.resetPassword('a' * 101),
        'Password must be 100 characters or fewer',
      );
    });

    test('confirmation is required and must match the new password', () {
      expect(
        AuthRules.confirmPassword('', 'newPassword1'),
        'Please confirm your password',
      );
      expect(
        AuthRules.confirmPassword('different', 'newPassword1'),
        'Passwords do not match',
      );
      expect(AuthRules.confirmPassword('newPassword1', 'newPassword1'), isNull);
    });
  });
}
