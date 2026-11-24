import '../data/models/app_settings_model.dart';

class SettingsState {
  const SettingsState({this.settings = const AppSettingsModel()});

  final AppSettingsModel settings;

  SettingsState copyWith({AppSettingsModel? settings}) =>
      SettingsState(settings: settings ?? this.settings);
}
