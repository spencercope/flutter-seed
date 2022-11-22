part of 'food_bloc.dart';

@immutable
abstract class FoodEvent {}

class FoodViewReadyForBuild extends FoodEvent {

  FoodViewReadyForBuild();
}

class FoodSelectionOneChange extends FoodEvent {
  final String selection;

  FoodSelectionOneChange(this.selection);
}

class FoodSelectionTwoChange extends FoodEvent {
  final String selection;

  FoodSelectionTwoChange(this.selection);
}