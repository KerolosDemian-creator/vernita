import 'package:shared_preferences/shared_preferences.dart';

/// Stable preference keys used by the application.
class SharedPrefKeys {
  const SharedPrefKeys._();

  /// The persisted JWT access token. The value is intentionally unchanged so
  /// existing installations keep their remembered session after this
  /// refactor.
  static const String userToken = 'auth_access_token';
}

/// Centralized access to [SharedPreferences].
///
/// Every read/write awaits [SharedPreferences.getInstance], so callers cannot
/// observe the storage before it is ready. Authentication-specific behavior
/// (remember-me semantics, token expiry, session state) lives in
/// `AuthTokenStorage` and `AuthSessionCubit`.
class SharedPrefHelper {
  const SharedPrefHelper._();

  /// Warms the SharedPreferences instance during application startup.
  static Future<void> init() async {
    await SharedPreferences.getInstance();
  }

  /// Removes a value from SharedPreferences with the given [key].
  static Future<bool> removeData(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }

  /// Removes all keys and values from SharedPreferences.
  static Future<bool> clearAllData() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.clear();
  }

  /// Saves [value] with the given [key] in SharedPreferences.
  static Future<bool> setData(String key, Object value) async {
    final preferences = await SharedPreferences.getInstance();

    return switch (value) {
      String stringValue => preferences.setString(key, stringValue),
      int intValue => preferences.setInt(key, intValue),
      bool boolValue => preferences.setBool(key, boolValue),
      double doubleValue => preferences.setDouble(key, doubleValue),
      List<String> listValue => preferences.setStringList(key, listValue),
      _ => throw ArgumentError.value(
        value,
        'value',
        'Unsupported SharedPreferences value type.',
      ),
    };
  }

  /// Gets a bool value for [key], falling back to [defaultValue].
  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? defaultValue;
  }

  /// Gets a double value for [key], falling back to [defaultValue].
  static Future<double> getDouble(
    String key, {
    double defaultValue = 0.0,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(key) ?? defaultValue;
  }

  /// Gets an int value for [key], falling back to [defaultValue].
  static Future<int> getInt(String key, {int defaultValue = 0}) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? defaultValue;
  }

  /// Gets a String value for [key], falling back to [defaultValue].
  static Future<String> getString(
    String key, {
    String defaultValue = '',
  }) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? defaultValue;
  }

  /// Gets a string list for [key], falling back to an empty list.
  static Future<List<String>> getStringList(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key) ?? const [];
  }
}
