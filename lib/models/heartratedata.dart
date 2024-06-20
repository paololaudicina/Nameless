import 'package:intl/intl.dart';

class HeartRateData{
  final DateTime time;
  final int value;
  final int confidence ;

  HeartRateData({required this.time, required this.value, required this.confidence});

  HeartRateData.fromJson(String date, Map<String, dynamic> json) :
      time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      value = json["value"],
      confidence = json["confidence"];

  @override
  String toString() {
    return 'StepData(time: $time, value: $value, confidence: $confidence)';
  }//toString
}//Steps