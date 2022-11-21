part of 'chart_bloc.dart';

@immutable
abstract class ChartEvent {}

class ChartViewReadyForBuild extends ChartEvent {
  final bool showError;
  ChartViewReadyForBuild(this.showError);
}
