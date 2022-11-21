import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_testing/settings/settings_bloc.dart';
import 'package:flutter_testing/util/logging/logger.dart';

ThemeData themeDetermination(
    BuildContext context, SettingsState settingsState) {
  appLogger('themeDetermination: $settingsState');
  if (settingsState is SettingsDataState) {
    if (settingsState.settingsConfig.selectedTheme == AppThemes.primary) {
      return primary();
    } else if (settingsState.settingsConfig.selectedTheme ==
        AppThemes.secondary) {
      return secondary();
    } else if (settingsState.settingsConfig.selectedTheme ==
        AppThemes.tertiary) {
      return tertiary();
    }
  }
  return primary();
}

ThemeData primary() {
  return ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffeeeeee),
          toolbarTextStyle: TextStyle(fontFamily: 'Avenir'),
          titleTextStyle: TextStyle(fontFamily: 'Avenir'),
          elevation: 0),
      canvasColor: Color(0xff127369),
      textTheme: const TextTheme(
          headline4: TextStyle(
            color: Color(0xff4e4e4e),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          headline5: TextStyle(
            color: Color(0xff4e4e4e),
            fontSize: 16,
          )),
      scaffoldBackgroundColor: Color(0xffeeeeee),
      fontFamily: 'Avenir');
}

ThemeData secondary() {
  return ThemeData(
      appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff3b3b3b),
          toolbarTextStyle: TextStyle(fontFamily: 'Avenir'),
          titleTextStyle: TextStyle(fontFamily: 'Avenir'),
          elevation: 0),
      canvasColor: Color(0xff127369),
      textTheme: const TextTheme(
          headline4: TextStyle(
            color: Color(0xffffffff),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          headline5: TextStyle(
            color: Color(0xffffffff),
            fontSize: 16,
          )),
      cardColor: Color(0xff545454),
      scaffoldBackgroundColor: Color(0xff3b3b3b),
      fontFamily: 'Avenir');
}

ThemeData tertiary() {
  return ThemeData(
      appBarTheme:
          const AppBarTheme(backgroundColor: Color(0xffbcd2bc), elevation: 0),
      textTheme: const TextTheme(
          headline4: TextStyle(
            color: Color(0xff333333),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          headline5: TextStyle(
            color: Color(0xff333333),
            fontSize: 16,
          )),
      cardColor: Color(0xffeaefea),
      canvasColor: Color(0xff127369),
      scaffoldBackgroundColor: Color(0xffbcd2bc),
      fontFamily: 'Avenir');
}
//C9D5C8FF
