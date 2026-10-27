import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vernita/core/helper/shared_pref_helper.dart';
import 'package:vernita/core/storage/auth_token_storage.dart';
import 'package:vernita/features/authentication/logic/auth_session_cubit.dart';
import 'package:vernita/features/authentication/logic/auth_session_state.dart';

String _jwtExpiringAt(DateTime expiration) {
  String encode(Map<String, dynamic> value) {
    return base64Url.encode(utf8.encode(jsonEncode(value))).replaceAll('=', '');
  }

  final header = encode({'alg': 'HS256', 'typ': 'JWT'});
  final payload = encode({
    'sub': 'user@example.com',
    'exp': expiration.millisecondsSinceEpoch ~/ 1000,
  });

  return '$header.$payload.signature';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('a new session starts in the initializing state', () {
    final cubit = AuthSessionCubit(AuthTokenStorage());
    addTearDown(cubit.close);

    expect(cubit.state.status, AuthSessionStatus.initializing);
    expect(cubit.state.isInitializing, isTrue);
    expect(cubit.isLoggedInUser, isFalse);
  });

  test('restoreSession without a stored token is logged out', () async {
    final cubit = AuthSessionCubit(AuthTokenStorage());
    addTearDown(cubit.close);

    await cubit.restoreSession();

    expect(cubit.state.status, AuthSessionStatus.unauthenticated);
    expect(cubit.isLoggedInUser, isFalse);
  });

  test('an empty stored token is logged out', () async {
    SharedPreferences.setMockInitialValues({SharedPrefKeys.userToken: '   '});
    final cubit = AuthSessionCubit(AuthTokenStorage());
    addTearDown(cubit.close);

    await cubit.restoreSession();

    expect(cubit.state.status, AuthSessionStatus.unauthenticated);
    expect(cubit.isLoggedInUser, isFalse);
    expect(
      (await SharedPreferences.getInstance()).containsKey(
        SharedPrefKeys.userToken,
      ),
      isFalse,
    );
  });

  test('restoreSession with a remembered token is logged in', () async {
    final tokenStorage = AuthTokenStorage();
    await tokenStorage.saveToken(
      accessToken: 'remembered-token',
      rememberMe: true,
    );

    final restoredCubit = AuthSessionCubit(AuthTokenStorage());
    addTearDown(restoredCubit.close);
    await restoredCubit.restoreSession();

    expect(restoredCubit.state.status, AuthSessionStatus.authenticated);
    expect(restoredCubit.isLoggedInUser, isTrue);
  });

  test('an expired stored JWT is cleared and does not log in', () async {
    final expiredToken = _jwtExpiringAt(
      DateTime.now().toUtc().subtract(const Duration(minutes: 1)),
    );
    SharedPreferences.setMockInitialValues({
      SharedPrefKeys.userToken: expiredToken,
    });

    final cubit = AuthSessionCubit(AuthTokenStorage());
    addTearDown(cubit.close);
    await cubit.restoreSession();

    expect(cubit.state.status, AuthSessionStatus.unauthenticated);
    expect(await AuthTokenStorage().readToken(), isNull);
  });

  test('a remembered non-expired JWT restores the session', () async {
    final futureToken = _jwtExpiringAt(
      DateTime.now().toUtc().add(const Duration(minutes: 10)),
    );
    SharedPreferences.setMockInitialValues({
      SharedPrefKeys.userToken: futureToken,
    });

    final cubit = AuthSessionCubit(AuthTokenStorage());
    addTearDown(cubit.close);
    await cubit.restoreSession();

    expect(cubit.state.status, AuthSessionStatus.authenticated);
    expect(cubit.isLoggedInUser, isTrue);
  });

  test('startSession with remember me persists the token', () async {
    final session = AuthSessionCubit(AuthTokenStorage());
    addTearDown(session.close);

    await session.startSession(
      accessToken: 'persisted-token',
      rememberMe: true,
    );

    expect(session.isLoggedInUser, isTrue);
    expect(await AuthTokenStorage().readToken(), 'persisted-token');
  });

  test('startSession without remember me keeps the token in memory', () async {
    final session = AuthSessionCubit(AuthTokenStorage());
    addTearDown(session.close);

    await session.startSession(
      accessToken: 'memory-only-token',
      rememberMe: false,
    );

    expect(session.isLoggedInUser, isTrue);
    expect(await AuthTokenStorage().readToken(), isNull);
  });

  test('logout clears the token and logs the user out', () async {
    final session = AuthSessionCubit(AuthTokenStorage());
    addTearDown(session.close);
    await session.startSession(
      accessToken: 'persisted-token',
      rememberMe: true,
    );

    await session.logout();

    expect(session.state.status, AuthSessionStatus.unauthenticated);
    expect(session.isLoggedInUser, isFalse);
    expect(await AuthTokenStorage().readToken(), isNull);
  });

  test('invalidateSession clears an authenticated session', () async {
    final session = AuthSessionCubit(AuthTokenStorage());
    addTearDown(session.close);
    await session.startSession(
      accessToken: 'persisted-token',
      rememberMe: true,
    );

    await session.invalidateSession();

    expect(session.isLoggedInUser, isFalse);
    expect(await AuthTokenStorage().readToken(), isNull);
  });

  test('invalidateSession is a no-op for a logged-out user', () async {
    final session = AuthSessionCubit(AuthTokenStorage());
    addTearDown(session.close);
    await session.restoreSession();

    await session.invalidateSession();

    expect(session.state.status, AuthSessionStatus.unauthenticated);
  });
}
