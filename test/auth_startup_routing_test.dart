import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vernita/core/di/dependency_injection.dart';
import 'package:vernita/core/helper/shared_pref_helper.dart';
import 'package:vernita/core/network/dio_factory.dart';
import 'package:vernita/core/routing/app_router.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/authentication/logic/auth_session_cubit.dart';
import 'package:vernita/vernita_app.dart';

class _RoutingTestAppRouter extends AppRouter {
  @override
  Route generateRoute(RouteSettings settings) {
    final label = settings.name == Routes.logIn ? 'Login route' : 'Home route';
    return MaterialPageRoute(builder: (_) => Scaffold(body: Text(label)));
  }
}

void main() {
  setUp(() async {
    await getIt.reset();
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
    DioFactory.reset();
    await getItSetup();
  });

  test('startup loads the secured token before API clients are used', () async {
    await getIt.reset();
    DioFactory.reset();
    FlutterSecureStorage.setMockInitialValues({
      SharedPrefKeys.userToken: 'startup-token',
    });

    await getItSetup();

    expect(
      DioFactory.getDio().options.headers['Authorization'],
      'Bearer startup-token',
    );
  });

  testWidgets('starts on Login when no token is stored', (tester) async {
    final session = getIt<AuthSessionCubit>();
    await session.restoreSession();

    await tester.pumpWidget(VernitaApp(appRouter: _RoutingTestAppRouter()));
    await tester.pump();

    expect(find.text('Login route'), findsOneWidget);
    expect(find.text('Home route'), findsNothing);
    expect(
      DioFactory.getDio().options.headers.containsKey('Authorization'),
      isFalse,
    );
  });

  testWidgets('starts on Home and never shows Login with a stored token', (
    tester,
  ) async {
    FlutterSecureStorage.setMockInitialValues({
      SharedPrefKeys.userToken: 'stored-access-token',
    });
    final session = getIt<AuthSessionCubit>();
    await session.restoreSession();
    expect(session.isLoggedInUser, isTrue);

    await tester.pumpWidget(VernitaApp(appRouter: _RoutingTestAppRouter()));
    await tester.pump();

    expect(find.text('Home route'), findsOneWidget);
    expect(find.text('Login route'), findsNothing);
    expect(
      DioFactory.getDio().options.headers['Authorization'],
      'Bearer stored-access-token',
    );
  });

  testWidgets('logout clears the session and returns to Login', (tester) async {
    FlutterSecureStorage.setMockInitialValues({
      SharedPrefKeys.userToken: 'stored-access-token',
    });
    final session = getIt<AuthSessionCubit>();
    await session.restoreSession();

    await tester.pumpWidget(VernitaApp(appRouter: _RoutingTestAppRouter()));
    await tester.pump();
    expect(find.text('Home route'), findsOneWidget);

    await session.logout();
    await tester.pumpAndSettle();

    expect(find.text('Login route'), findsOneWidget);
    expect(find.text('Home route'), findsNothing);
    expect(
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken),
      isEmpty,
    );
    expect(
      DioFactory.getDio().options.headers.containsKey('Authorization'),
      isFalse,
    );
  });
}
