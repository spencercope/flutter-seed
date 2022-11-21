import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/chart/chart_bloc.dart';
import 'package:flutter_testing/settings/settings_bloc.dart';
import 'package:flutter_testing/shared_ui/app_unknown_error.dart';
import 'package:flutter_testing/util/logging/logger.dart';
import 'package:flutter_testing/util/navigation/app_back_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartView extends StatefulWidget {
  bool showError;

  ChartView(this.showError, {super.key});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
      ),
      body: SafeArea(
          child: BlocBuilder<ChartBloc, ChartState>(builder: (context, state) {
        appLogger('settings state: $state');
        if (state is ChartInitial) {
          BlocProvider.of<ChartBloc>(context)
              .add(ChartViewReadyForBuild(widget.showError));
        } else if (state is ChartViewDataState) {
          appLogger('settings view: settings data state detected');
          return _buildChartDataState(state);
        }
        return const AppUnknownErrorDisplay();
      })),
    );
  }

  Widget _buildChartDataState(ChartViewDataState state) {
    appLogger('show error: ${state.showError}');
    if (state.showError) {
      return const AppUnknownErrorDisplay();
    }

    List<_SalesData> data = [
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 34),
      _SalesData('Apr', 32),
      _SalesData('May', 40)
    ];
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        // Chart title
        title: ChartTitle(
            text: 'Half yearly sales analysis',
            textStyle: Theme.of(context).textTheme.headline4),
        // Enable legend
        legend: Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_SalesData, String>>[
          LineSeries<_SalesData, String>(
              dataSource: data,
              xValueMapper: (_SalesData sales, _) => sales.year,
              yValueMapper: (_SalesData sales, _) => sales.sales,
              name: 'Sales',
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ]);
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
