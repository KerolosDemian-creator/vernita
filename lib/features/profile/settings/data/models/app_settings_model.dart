class AppSettingsModel {
  const AppSettingsModel({
    this.aiVoice = 'Sarah (US)',
    this.language = 'English',
    this.darkMode = false,
  });

  final String aiVoice;
  final String language;
  final bool darkMode;

  AppSettingsModel copyWith({
    String? aiVoice,
    String? language,
    bool? darkMode,
  }) =>
      AppSettingsModel(
        aiVoice: aiVoice ?? this.aiVoice,
        language: language ?? this.language,
        darkMode: darkMode ?? this.darkMode,
      );
}
