import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/home/home_bloc.dart';
import 'package:flutter_testing/home/home_view.dart';
import 'package:flutter_testing/settings/settings_bloc.dart';
import 'package:flutter_testing/util/theme/theme_provider.dart';
import 'package:flutter_testing/util/service_locator.dart';

import 'util/logging/logger.dart';

void main() {
  setupLocator('local');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeDetermination(context, state),
            home: MyHomePage(title: 'Flutter Demo Home Page'),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            GestureDetector(
              onTap: () {
                appLogger('demo counter tap');
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) {
                  return BlocProvider(
                    create: (context) => HomeBloc(),
                    child: const HomeView(),
                  );
                }));
              },
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
