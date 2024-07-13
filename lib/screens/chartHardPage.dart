import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/widget/linePlotHard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartHardPage extends StatelessWidget {
  const ChartHardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Chart Page',
            style: TextStyle(color: Colors.white, fontSize: 35)),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Consumer<HomeProvider>(builder: (context, data, child) {
          if (data.soberTime == null) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Nothing to display',style: TextStyle(fontSize: 20)),
                Text(' Start counter to see the chart',style:TextStyle(fontSize: 20))
              ],
            );
          } else {
            if (!data.checkHRHard) {
              return CircularProgressIndicator();
            } else {
              return Column(
                children: [
                  const SizedBox(height: 20,),
                  Container(
                      height: 300,
                      child: LinePlotHard(
                        meanHRHard: data.meanHRHard,
                        lowerRange: (data.age < 60) ? 60 : 80,
                        upperRange: (data.age < 60) ? 80 : 100,
                      )),
                      const SizedBox(height: 40,),
                      const Padding(
                        padding:  EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('The chart monitors your average daily heart rate since you started your journey. Within the first 72 hours your heart rate may increase, due to alcohol withdrawal. Do not be afraid. The first improvements will be visible after about a month.'
                            ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            SizedBox(height: 20,),
                            Text('*it is assumed that the subject is not use to do sport ')
                          ],
                        ),
                      ),
                      const SizedBox(height: 130,),
                  ElevatedButton(
                      onPressed: () {
                        data.populateListDate(data.soberTime);
                        data.fecthHRDataHard(data.listDate);
                      },
                      style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),

                          ),
                      child: const Text('ADD DAY',style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),))
                ],
              );
            }
          }
        }),
      ),
    ));
  }
}
