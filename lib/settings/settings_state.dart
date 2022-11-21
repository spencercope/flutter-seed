part of 'settings_bloc.dart';

abstract class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {}

class SettingsDataState extends SettingsState {
  final SettingsConfig settingsConfig;

  const SettingsDataState(this.settingsConfig);
}
