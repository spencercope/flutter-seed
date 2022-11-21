import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_testing/settings/settings_bloc.dart';
import 'package:flutter_testing/util/auth.dart';
import 'package:flutter_testing/util/logging/logger.dart';
import 'package:get_it/get_it.dart';

class AppUnknownErrorDisplay extends StatefulWidget {
  final String displayText;
  final String displaySubtext;

  const AppUnknownErrorDisplay(
      {super.key,
      this.displayText = 'An unknown error has occurred.',
      this.displaySubtext = 'Please try again when you are ready.'});

  @override
  State<AppUnknownErrorDisplay> createState() => _AppUnknownErrorDisplayState();
}

class _AppUnknownErrorDisplayState extends State<AppUnknownErrorDisplay> {
  @override
  Widget build(BuildContext context) {
    String errorAssetPath = 'assets/ferris-wheel_lightmode.png';
    appLogger('theme choice: ${GetIt.I<Auth>().themeChoice.toString()}');
    if (GetIt.I<Auth>().themeChoice == AppThemes.secondary) {
      errorAssetPath = 'assets/ferris-wheel_darkmode.png';
    } else if (GetIt.I<Auth>().themeChoice == AppThemes.tertiary) {
      errorAssetPath = 'assets/ferris-wheel_green.png';
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 128),
        child: Column(
          children: [
            SizedBox(
                height: 196,
                child: Center(
                  child: Image.asset(errorAssetPath),
                )),
            const SizedBox(height: 24),
            Center(
                child: Text(widget.displayText,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 20))),
            const SizedBox(height: 36),
            Center(
              child: Text(widget.displaySubtext,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontSize: 16)),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                appLogger('back to home tapped');
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Theme.of(context).splashColor;
                  }
                  return Theme.of(context).cardColor;
                }),
              ),
              child: Text(
                'Back to Home',
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
