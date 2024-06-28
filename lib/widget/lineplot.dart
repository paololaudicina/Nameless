import 'package:flutter/material.dart';
import 'package:Nameless/models/heartratedata.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


/// Local import

///Renders default line series chart
class HRDataPlot extends StatelessWidget {
  ///Creates default line series chart
  HRDataPlot({Key? key, required this.heartrateData}) : super(key: key);

  final List<HeartRateData> heartrateData;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Yesterday heart rate'),
      primaryXAxis: const DateTimeAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: const NumericAxis(
          labelFormat: '{value} heart rate',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent)),
      series: _getHeartRateDataSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<HeartRateData, DateTime>> _getHeartRateDataSeries() {
    return <LineSeries<HeartRateData, DateTime>>[
      LineSeries<HeartRateData, DateTime>(
          dataSource: heartrateData,
          xValueMapper: (data, _) => data.time,
          yValueMapper: (data, _) => data.value,
          name: 'Heart rate',
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }//_getStepDataSeries

}//StepDataPlot