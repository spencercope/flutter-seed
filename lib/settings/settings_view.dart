import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/settings/settings_bloc.dart';
import 'package:flutter_testing/shared_ui/app_unknown_error.dart';
import 'package:flutter_testing/util/auth.dart';
import 'package:flutter_testing/util/logging/logger.dart';
import 'package:flutter_testing/util/navigation/app_back_button.dart';
import 'package:get_it/get_it.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: const AppBarBackButton(),
          title:
              Text('Settings', style: Theme.of(context).textTheme.headline4)),
      body: SafeArea(child:
          BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        appLogger('settings state: $state');
        if (state is SettingsInitial) {
          BlocProvider.of<SettingsBloc>(context)
              .add(const SettingsViewReadyForBuild());
        } else if (state is SettingsDataState) {
          appLogger('settings view: settings data state detected');
          return _buildSettingsDataState(state);
        }
        return const AppUnknownErrorDisplay();
      })),
    );
  }

  Widget _buildSettingsDataState(SettingsDataState state) {
    return Column(
      children: [
        Row(
          children: [
            Radio(
                value: AppThemes.primary,
                groupValue: state.settingsConfig.selectedTheme,
                activeColor: Theme.of(context).canvasColor,
                onChanged: (val) {
                  state.settingsConfig.selectedTheme = AppThemes.primary;
                  appLogger(val.toString());
                  GetIt.I<Auth>().themeChoice = AppThemes.primary;
                  BlocProvider.of<SettingsBloc>(context).add(
                      SettingsThemeChange(state.settingsConfig.selectedTheme));
                }),
            Text(
              'Primary',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
        Row(
          children: [
            Radio(
                value: AppThemes.secondary,
                groupValue: state.settingsConfig.selectedTheme,
                activeColor: Theme.of(context).canvasColor,
                onChanged: (val) {
                  state.settingsConfig.selectedTheme = AppThemes.secondary;
                  appLogger(val.toString());
                  GetIt.I<Auth>().themeChoice = AppThemes.secondary;
                  BlocProvider.of<SettingsBloc>(context).add(
                      SettingsThemeChange(state.settingsConfig.selectedTheme));
                }),
            Text(
              'Secondary',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
        Row(
          children: [
            Radio(
                value: AppThemes.tertiary,
                groupValue: state.settingsConfig.selectedTheme,
                activeColor: Theme.of(context).canvasColor,
                onChanged: (val) {
                  state.settingsConfig.selectedTheme = AppThemes.tertiary;
                  appLogger(val.toString());
                  GetIt.I<Auth>().themeChoice = AppThemes.tertiary;
                  BlocProvider.of<SettingsBloc>(context).add(
                      SettingsThemeChange(state.settingsConfig.selectedTheme));
                }),
            Text(
              'Tertiary',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        )
      ],
    );
  }
}
