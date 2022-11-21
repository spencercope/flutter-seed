part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

class SettingsViewReadyForBuild extends SettingsEvent {
  final SettingsConfig? settingsConfig;

  const SettingsViewReadyForBuild({this.settingsConfig});
}

class SettingsThemeChange extends SettingsEvent {
  final AppThemes theme;

  const SettingsThemeChange(this.theme);
}
