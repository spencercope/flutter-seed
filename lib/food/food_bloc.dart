import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodVM foodVM = FoodVM('', '', List.empty(growable: true));
  List<String> fruitValues = <String>['', 'Apple', 'Orange', 'Banana'];
  List<String> veggieValues = <String>['', 'Pepper', 'Onion'];
  List<String> seaValues = <String>['', 'Seabass', 'Shrimp', 'Lobster'];

  FoodBloc() : super(FoodInitial()) {
    on<FoodViewReadyForBuild>((event, emit) {
      emit(FoodDataState(foodVM));
    });
    on<FoodSelectionOneChange>((event, emit) {
      print('*****');
      print(foodVM.choiceOne);
      print(event.selection);
      print('*****');
      if (foodVM.choiceOne == event.selection) {
        emit(FoodDataState(foodVM));
      } else {
        _emitData(event);
      }

    });
    on<FoodSelectionTwoChange>((event, emit) {
      foodVM.choiceTwo = event.selection;
      emit(FoodDataState(foodVM));
    });
  }

  _emitData(FoodSelectionOneChange event) {
    foodVM.choiceOne = event.selection;
    foodVM.choiceTwo = '';
    foodVM.secondList.clear();
    if (foodVM.choiceOne == 'Fruit') {
      foodVM.secondList.addAll(fruitValues);
    } else if (foodVM.choiceOne == 'Vegetable') {
      foodVM.secondList.addAll(veggieValues);
    } else if (foodVM.choiceOne == 'Seafood') {
      foodVM.secondList.addAll(seaValues);
    }
    emit(FoodDataState(foodVM));
  }

  _getData() {

  }
}

class FoodVM {
  String choiceOne;
  String choiceTwo;
  List<String> secondList;

  FoodVM(this.choiceOne, this.choiceTwo, this.secondList);
}