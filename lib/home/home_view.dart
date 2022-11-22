import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/chart/chart_bloc.dart';
import 'package:flutter_testing/chart/chart_view.dart';
import 'package:flutter_testing/food/food_bloc.dart';
import 'package:flutter_testing/food/food_view.dart';
import 'package:flutter_testing/settings/settings_bloc.dart';
import 'package:flutter_testing/settings/settings_view.dart';
import 'package:flutter_testing/util/logging/logger.dart';
import 'package:flutter_testing/util/navigation/app_back_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    appLogger('home view build: ${widget.key}');
    return Scaffold(
      // appBar: const CupertinoNavigationBar(
      //   middle: Text('Welcome'),
      // ),
      appBar: AppBar(
          centerTitle: true,
          title: Text('Welcome', style: Theme.of(context).textTheme.headline4)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: OpenContainer(
                closedBuilder: (context, action) {
                  return ListTile(
                    tileColor: Theme.of(context).cardColor,
                    title: Text('Settings',
                        style: Theme.of(context).textTheme.headline5),
                    trailing: Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Theme.of(context).textTheme.headline5?.color,
                    ),
                    onTap: () {
                      appLogger('settings tap');
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return const SettingsView();
                      }));
                    },
                  );
                },
                openBuilder: (BuildContext context,
                    void Function({Object? returnValue}) action) {
                  return BlocProvider(
                    create: (context) => ChartBloc(),
                    child: ChartView(false),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OpenContainer(
                closedBuilder: (context, action) {
                  return ListTile(
                    tileColor: Theme.of(context).cardColor,
                    title: Text('Chart',
                        style: Theme.of(context).textTheme.headline5),
                    trailing: Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Theme.of(context).textTheme.headline5?.color,
                    ),
                  );
                },
                openBuilder: (BuildContext context,
                    void Function({Object? returnValue}) action) {
                  return BlocProvider(
                    create: (context) => ChartBloc(),
                    child: ChartView(false),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: OpenContainer(
                closedBuilder: (context, action) {
                  return ListTile(
                    tileColor: Theme.of(context).cardColor,
                    title: Text('Unknown Error',
                        style: Theme.of(context).textTheme.headline5),
                    trailing: Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Theme.of(context).textTheme.headline5?.color,
                    ),
                  );
                },
                openBuilder: (BuildContext context,
                    void Function({Object? returnValue}) action) {
                  return BlocProvider(
                    create: (context) => ChartBloc(),
                    child: ChartView(true),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: OpenContainer(
                closedBuilder: (context, action) {
                  return ListTile(
                    tileColor: Theme.of(context).cardColor,
                    title: Text('Testing',
                        style: Theme.of(context).textTheme.headline5),
                    trailing: Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Theme.of(context).textTheme.headline5?.color,
                    ),
                  );
                },
                openBuilder: (BuildContext context,
                    void Function({Object? returnValue}) action) {
                  return BlocProvider(
                    create: (context) => FoodBloc(),
                    child: const FoodView(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
