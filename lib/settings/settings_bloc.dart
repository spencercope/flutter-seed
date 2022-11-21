import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_testing/util/logging/logger.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsConfig settingsConfig = SettingsConfig();

  SettingsBloc() : super(SettingsInitial()) {
    appLogger('from the settings bloc constructor');
    on<SettingsViewReadyForBuild>((event, emit) {
      appLogger('bloc on settings event');
      emit(SettingsDataState(settingsConfig));
    });
    on<SettingsThemeChange>((event, emit) {
      settingsConfig.selectedTheme = event.theme;
      appLogger('settings bloc: settings theme change -> ${event.theme}');
      try {
        emit(SettingsDataState(settingsConfig));
      } catch (e) {
        appLogger(e.toString());
      }
    });
  }
}

class SettingsConfig {
  AppThemes selectedTheme = AppThemes.primary;
}

enum AppThemes { primary, secondary, tertiary }
