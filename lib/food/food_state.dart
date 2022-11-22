part of 'food_bloc.dart';

@immutable
abstract class FoodState {}

class FoodInitial extends FoodState {}

class FoodDataState extends FoodState {
  final FoodVM foodVM;

  FoodDataState(this.foodVM);
}