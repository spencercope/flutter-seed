part of 'chart_bloc.dart';

@immutable
abstract class ChartState {}

class ChartInitial extends ChartState {}

class ChartViewDataState extends ChartState {
  final bool showError;
  ChartViewDataState(this.showError);
}
