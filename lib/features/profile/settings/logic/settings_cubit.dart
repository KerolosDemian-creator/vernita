import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleDarkMode(bool value) {
    emit(state.copyWith(settings: state.settings.copyWith(darkMode: value)));
    // TODO: apply the theme app-wide + persist the choice.
  }

  void setAiVoice(String voice) =>
      emit(state.copyWith(settings: state.settings.copyWith(aiVoice: voice)));

  void setLanguage(String language) => emit(
        state.copyWith(settings: state.settings.copyWith(language: language)),
      );
}
