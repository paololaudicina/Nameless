import 'package:Nameless/screens/activity.dart';
import 'package:Nameless/screens/chartHardPage.dart';
import 'package:Nameless/screens/chartPage.dart';
import 'package:flutter/material.dart';
import 'package:Nameless/models/info.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/profilePage.dart';

import 'package:provider/provider.dart';


class HomeHardPage extends StatefulWidget {
  const HomeHardPage({super.key});

  @override
  State<HomeHardPage> createState() => _HomeHardPageState();
}

class _HomeHardPageState extends State<HomeHardPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('HARD LEVEL',
                  style: TextStyle(fontSize: 40, color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.blue,
          actions: [
             IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                            Provider.of<HomeProvider>(context, listen:false).populateListDate(Provider.of<HomeProvider>(context, listen:false).soberTime);
                  },
                  icon: const Icon(Icons.person)),
            IconButton(
                onPressed: () {
                  levelExplanation(context);
                },
                icon: const Icon(Icons.info))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
                         Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 380,
                    height: 300,

                    child: Card(
                     // color: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Imposta il raggio degli angoli del bordo
                        side: const BorderSide(
                            color: Colors.black,
                            width:
                                2.0), // Imposta il colore e lo spessore del bordo
                      ),

                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('You have been sober for', style: TextStyle(fontSize: 23),),
                            Consumer<HomeProvider>(
                                builder: (context, data, child) {
                              return Text(data.counterText, style: TextStyle(fontSize: 18),);
                            }),
                            SizedBox(height: 30),
                                    Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              SizedBox(
                      height: 150,
                      width: 150,
                      child: InkWell(
                        onTap: startCounter,
                        child: Card(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Start Counter',style: TextStyle(fontSize: 18),),
                              SizedBox(height: 10),
                              Image.asset('images/start.png',height: 40,width: 40,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  SizedBox(width: 20),
                SizedBox(
                      height: 150,
                      width: 150,
                      child: InkWell(
                        onTap: stopCounter,
                        child: Card(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Stop Counter',style: TextStyle(fontSize: 18),),
                              SizedBox(height: 10),
                              Image.asset('images/stop.png',height: 40,width: 40,),
                            ],
                          ),
                        ),
                      ),
                    ),
                ]
              ),
                          ]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: InkWell(
                      onTap: () =>fecthHRDataHard(),
                      child: Card(
                        color: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Imposta il raggio degli angoli del bordo
                          side: const BorderSide(
                              color: Colors.black,
                              width:
                                  2.0), // Imposta il colore e lo spessore del bordo
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.insert_chart), Text('CHARTS')],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: InkWell(
                      onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Activity()));
                      },
                      child: Card(
                        color: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Imposta il raggio degli angoli del bordo
                          side: const BorderSide(
                              color: Colors.black,
                              width:
                                  2.0), // Imposta il colore e lo spessore del bordo
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.local_activity), Text('HOBBY')],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fecthHRDataHard() {
    // DateTime giorno = DateTime.now();
    Provider.of<HomeProvider>(context, listen: false).populateListDate(Provider.of<HomeProvider>(context, listen: false).soberTime);
    Provider.of<HomeProvider>(context, listen: false).fecthHRDataHard(Provider.of<HomeProvider>(context, listen: false).listDate);
    Navigator.push(context,MaterialPageRoute(builder: (context) => const ChartHardPage()));
  }


  void startCounter() {
    Provider.of<HomeProvider>(context, listen: false).startCounter();
    
  }

  void stopCounter() {
    Provider.of<HomeProvider>(context, listen: false).stopCounter();
  }
}

