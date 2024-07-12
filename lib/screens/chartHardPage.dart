import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/widget/linePlotHard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChartHardPage extends StatelessWidget {
  const ChartHardPage({super.key});

  @override
  Widget build(BuildContext context) {
    int age = Provider.of<HomeProvider>(context,listen: false).age;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text('ChartHardPage')),
            body: Center(
              child: Consumer<HomeProvider>(builder: (context, data, child) {
                if (data.soberTime == null) {
                  return Text('Nothing to display');
                } else {
                  if (!data.checkHRHard) {
                    return CircularProgressIndicator();
                  } else {
                    return Container(
                        height: 300,
                        child: LinePlotHard(
                          meanHRHard: data.meanHRHard,
                          lowerRange: (age<60) ? 60 : 80,
                          upperRange: (age<60) ? 80 : 100,
                        )
                        );
                  }
                }
              }),
            )));
  }
}
