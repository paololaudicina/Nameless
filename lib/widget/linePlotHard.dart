import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LinePlotHard extends StatelessWidget {
  final Map<String,int> meanHRHard;
  final int lowerRange;
  final int upperRange;
  const LinePlotHard({super.key, required this.meanHRHard, required this.lowerRange, required this.upperRange});

  List<double> range(Map<String,int> meanHRHard){
    List<double> listRange=[];
    List<int> listValue = meanHRHard.values.toList();
    double minValue = (listValue.reduce((value, element) => value < element ? value: element)-20);
    double maxValue = (listValue.reduce((value, element) => value > element ? value: element)+20);
    listRange.add(minValue);
    listRange.add(maxValue);
    return listRange;
    
  }

  

  @override
  Widget build(BuildContext context) {
    
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: 'History of your mean HR',
      ),
      primaryXAxis:
          const CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis:  NumericAxis(
        minimum: range(meanHRHard)[0],
        maximum: range(meanHRHard)[1],
          labelFormat: '{value} bpm',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent),
          plotBands: _getPlotBand(),),
      series: _getMeanHRSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
  
  List<ScatterSeries<MapEntry<String, int>,String>> _getMeanHRSeries() {
    return <ScatterSeries<MapEntry<String, int>,String>> [
                      
                      ScatterSeries<MapEntry<String, int>, String>(
                        dataSource: meanHRHard.entries.toList(),
                        xValueMapper: (entry, _) => entry.key,
                        yValueMapper: (entry, _) => entry.value,
                        name: 'Mean HR',
                      ),
                    ];
  }
  
  List<PlotBand> _getPlotBand() {
    return <PlotBand>[
      PlotBand(
        color : Colors.transparent,
        start: lowerRange,
        end: upperRange,
        borderColor: Colors.green,
        borderWidth: 2,
        
      )
    ];
  }  
}