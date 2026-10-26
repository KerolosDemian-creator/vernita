import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/network/models/message_response_model.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/authentication/forget_password/data/models/forget_pass_request_model.dart';
import 'package:vernita/features/authentication/forget_password/data/repo/forget_pass_repo.dart';
import 'package:vernita/features/authentication/forget_password/logic/forget_pass_cubit.dart';
import 'package:vernita/features/authentication/forget_password/ui/forget_pass_screen.dart';
import 'package:vernita/features/authentication/reset_password/data/models/reset_pass_request_model.dart';
import 'package:vernita/features/authentication/reset_password/data/repo/reset_pass_repo.dart';
import 'package:vernita/features/authentication/reset_password/logic/reset_pass_cubit.dart';
import 'package:vernita/features/authentication/reset_password/ui/reset_pass_screen.dart';

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

class _FakeResetPassRepo implements ResetPassRepo {
  _FakeResetPassRepo(this.result);

  final Either<ErrorHandler, MessageResponseModel> result;
  int calls = 0;

  @override
  Future<Either<ErrorHandler, MessageResponseModel>> resetPassword(
    ResetPassRequestModel resetPassRequestBody,
  ) async {
    calls++;
    return result;
  }
}

Widget _resetTestApp(
  ResetPassCubit cubit, {
  Map<String, WidgetBuilder>? routes,
}) {
  return ScreenUtilPlusInit(
    designSize: const Size(375, 812),
    splitScreenMode: true,
    ensureScreenSize: true,
    builder: (context, _) => MaterialApp(
      home: BlocProvider.value(
        value: cubit,
        child: const ResetPasswordScreen(),
      ),
      routes: routes ?? const {},
    ),
  );
}

Widget _forgotTestApp(
  ForgetPassCubit cubit, {
  Map<String, WidgetBuilder>? routes,
}) {
  return ScreenUtilPlusInit(
    designSize: const Size(375, 812),
    splitScreenMode: true,
    ensureScreenSize: true,
    builder: (context, _) => MaterialApp(
      home: BlocProvider.value(
        value: cubit,
        child: const ForgotPasswordScreen(),
      ),
      routes: routes ?? const {},
    ),
  );
}

ResetPassCubit _cubitWithValidInput(
  Either<ErrorHandler, MessageResponseModel> result,
) {
  final cubit = ResetPassCubit(_FakeResetPassRepo(result));
  cubit.emailController.text = 'user@example.com';
  cubit.codeController.text = '123456';
  cubit.passwordController.text = 'newPassword1';
  cubit.confirmPasswordController.text = 'newPassword1';
  return cubit;
}

void _setPhoneSizedView(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('shows inline validation for empty reset fields', (tester) async {
    _setPhoneSizedView(tester);
    final repo = _FakeResetPassRepo(
      left(ErrorHandler.local('Invalid or expired reset code')),
    );
    final cubit = ResetPassCubit(repo)
      ..emailController.text = 'user@example.com';
    addTearDown(cubit.close);

    await tester.pumpWidget(_resetTestApp(cubit));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Reset Password'));
    await tester.tap(find.text('Reset Password'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter the reset code'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
    expect(find.text('Please confirm your password'), findsOneWidget);
    expect(repo.calls, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows the backend error dialog when reset fails', (
    tester,
  ) async {
    _setPhoneSizedView(tester);
    final cubit = _cubitWithValidInput(
      left(ErrorHandler.local('Invalid or expired reset code')),
    );
    addTearDown(cubit.close);

    await tester.pumpWidget(_resetTestApp(cubit));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Reset Password'));
    await tester.tap(find.text('Reset Password'));
    await tester.pumpAndSettle();

    expect(find.text('Reset Failed'), findsOneWidget);
    expect(find.text('Invalid or expired reset code'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    expect(find.text('Reset Failed'), findsNothing);
    expect(find.text('Reset Password'), findsOneWidget);
  });

  testWidgets('navigates back to Login after a successful reset', (
    tester,
  ) async {
    _setPhoneSizedView(tester);
    final cubit = _cubitWithValidInput(
      right(
        const MessageResponseModel(
          message: 'Password has been reset successfully.',
        ),
      ),
    );
    addTearDown(cubit.close);

    await tester.pumpWidget(
      _resetTestApp(
        cubit,
        routes: {
          Routes.logIn: (_) => const Scaffold(body: Text('Login Screen')),
        },
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Reset Password'));
    await tester.tap(find.text('Reset Password'));
    await tester.pumpAndSettle();

    expect(find.text('Login Screen'), findsOneWidget);
    expect(find.text('Password has been reset successfully.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('forgot password validates the email before calling the API', (
    tester,
  ) async {
    _setPhoneSizedView(tester);
    final repo = _FakeForgetPassRepo(
      left(ErrorHandler.local('Unable to send reset code')),
    );
    final cubit = ForgetPassCubit(repo);
    addTearDown(cubit.close);

    await tester.pumpWidget(_forgotTestApp(cubit));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Send Reset Code'));
    await tester.tap(find.text('Send Reset Code'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your email'), findsOneWidget);
    expect(repo.calls, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('forgot password opens reset with the submitted email', (
    tester,
  ) async {
    _setPhoneSizedView(tester);
    final repo = _FakeForgetPassRepo(
      right(
        const MessageResponseModel(
          message: 'If an account exists, a reset code has been sent.',
        ),
      ),
    );
    final cubit = ForgetPassCubit(repo)
      ..emailController.text = '  user@example.com  ';
    addTearDown(cubit.close);

    await tester.pumpWidget(
      _forgotTestApp(
        cubit,
        routes: {
          Routes.resetPassword: (context) {
            final email = ModalRoute.of(context)!.settings.arguments;
            return Scaffold(body: Text('Reset for $email'));
          },
        },
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Send Reset Code'));
    await tester.tap(find.text('Send Reset Code'));
    await tester.pumpAndSettle();

    expect(find.text('Reset for user@example.com'), findsOneWidget);
    expect(repo.lastRequest?.email, 'user@example.com');
    expect(tester.takeException(), isNull);
  });
}
