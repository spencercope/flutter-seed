
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/food/food_bloc.dart';
import 'package:flutter_testing/shared_ui/app_unknown_error.dart';
import 'package:flutter_testing/util/logging/logger.dart';
import 'package:flutter_testing/util/navigation/app_back_button.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {

  List<String> list = <String>['', 'Fruit', 'Vegetable', 'Seafood'];
  late String dropDownValueOne;


  @override
  void initState() {
    dropDownValueOne = list.first;
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
      BlocBuilder<FoodBloc, FoodState>(builder: (context, state) {
        appLogger('food state: $state');
        if (state is FoodInitial) {
          BlocProvider.of<FoodBloc>(context)
              .add(FoodViewReadyForBuild());
        } else if (state is FoodDataState) {
          appLogger('settings view: settings data state detected');
          return _buildFoodDataState(state);
        }
        return const AppUnknownErrorDisplay();
      })),
    );
  }


  _buildFoodDataState(FoodDataState foodDataState) {
    appLogger('list length $list');
    debugPrint(list.first);
    return Center(
      child: Column(
        children: [
          DropdownButton<String>(
            value: foodDataState.foodVM.choiceOne,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            underline: Container(
              height: 2,
            ),
            onChanged: (String? value) {
              debugPrint(value);

              if (value != null) {
                BlocProvider.of<FoodBloc>(context)
                    .add(FoodSelectionOneChange(value));
              } else {
                debugPrint('value was null');
              }

            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              debugPrint('val below');
              debugPrint(value);
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: foodDataState.foodVM.choiceTwo,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            underline: Container(
              height: 2,
            ),
            onChanged: (String? value) {
              debugPrint(value);
              if (value != null) {
                BlocProvider.of<FoodBloc>(context)
                    .add(FoodSelectionTwoChange(value));
              } else {
                debugPrint('value was null');
              }
            },
            items: foodDataState.foodVM.secondList.map<DropdownMenuItem<String>>((String value) {
              debugPrint('val below');
              debugPrint(value);
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}