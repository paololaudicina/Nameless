import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/widget/lineplot.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chart Page'),
          backgroundColor: Colors.blue,
          ),
        
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            Row(
              
            children: [
              const SizedBox(width: 25,),
              IconButton(onPressed: () {Provider.of<HomeProvider>(context,listen: false).subtractDate();}, icon: const Icon(Icons.navigate_before,size:30)),
              
              const SizedBox(width: 80,),
               Text(DateFormat('yyyy-MM-dd').format(Provider.of<HomeProvider>(context).showDate),style: const TextStyle(fontSize: 20),),
              const SizedBox(width: 80,),

              IconButton(onPressed: (){Provider.of<HomeProvider>(context,listen: false).addDate();}, icon: const Icon(Icons.navigate_next,size:30))
              
            ],),
            Consumer<HomeProvider>(builder: (context, data, child) {
              if(data.checkHRData){
                if (data.heartrateData.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'nothing to display. The selected date is after the yesterday date'),
                  );
                } else {
                  return HRDataPlot(heartrateData: data.heartrateData);
                }
              }else {
                return CircularProgressIndicator();
              }
                
              }),
        ],),

    ));
  }
}