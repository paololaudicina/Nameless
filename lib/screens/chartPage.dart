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
  Widget _listView(List<int> listKey) => ListView.builder(
      shrinkWrap: true,
      controller: ScrollController(),
      itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                  'Hour range: ${listKey[index]} - ${listKey[index] + 1}',
                  style: TextStyle(color: Colors.black, fontSize: 23)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mean HR: ${Provider.of<HomeProvider>(context).finalFlagHR || Provider.of<HomeProvider>(context).initFlagHR ? 'not possible to calculate mean' : Provider.of<HomeProvider>(context, listen: false).mapMeanHR[listKey[index]]}',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Text(
                      'Physiological value: ${Provider.of<HomeProvider>(context).finalFlagHR || Provider.of<HomeProvider>(context).age < 60 ? ' 60 - 80 ' : ' 80 - 100 '}',
                      style: TextStyle(color: Colors.white, fontSize: 17))
                ],
              ),
              tileColor: Color.fromARGB(255, 62, 180, 234),
            ),
          ),
      itemCount:
          Provider.of<HomeProvider>(context, listen: false).mapMeanHR.length);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text('Chart Page'),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                          content: Container(
                              height: 300,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Explanation',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'In this page you can see the chart of your specific heart rate. If you added drinks in Calendar Page, the app shows you: ',
                                      style: TextStyle(fontSize: 17),
                                      textAlign: TextAlign.left,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                        'Hour range : drink time - drink time + 1     '),
                                    const Text(
                                        'Mean HR : your HR\'s mean in these range'),
                                    const Text(
                                        'Physiological value: your physiological value'),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Ok'),
                                    )
                                  ]))));
                },
                icon: const Icon(Icons.info))
          ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Provider.of<HomeProvider>(context, listen: false)
                          .subtractDate();
                    },
                    icon: const Icon(Icons.navigate_before, size: 30)),
                const SizedBox(
                  width: 70,
                ),
                Text(
                  DateFormat('yyyy-MM-dd')
                      .format(Provider.of<HomeProvider>(context).showDate),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 70,
                ),
                IconButton(
                    onPressed: () {
                      Provider.of<HomeProvider>(context, listen: false)
                          .addDate();
                    },
                    icon: const Icon(Icons.navigate_next, size: 30))
              ],
            ),
            Consumer<HomeProvider>(builder: (context, data, child) {
              if (data.checkHRData) {
                if (data.heartrateData.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'nothing to display. The selected date is after the yesterday date'),
                  );
                } else {
                  return Column(
                    children: [
                      HRDataPlot(heartrateData: data.heartrateData),
                      _listView(data.listKey)
                    ],
                  );
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
          ],
        ),
      ),
    ));
  }
}
