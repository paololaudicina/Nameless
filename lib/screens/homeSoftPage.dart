import 'package:Nameless/screens/activity.dart';
import 'package:Nameless/screens/calendarPage.dart';
import 'package:Nameless/screens/chartPage.dart';
import 'package:flutter/material.dart';
import 'package:Nameless/models/info.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/profilePage.dart';
import 'package:provider/provider.dart';

class HomeSoftPage extends StatefulWidget {
  const HomeSoftPage({super.key});

  @override
  State<HomeSoftPage> createState() => _HomeSoftPage();
}

class _HomeSoftPage extends State<HomeSoftPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SOFT LEVEL',
                  style: TextStyle(fontSize: 40, color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () {
                goToProfile();
              },
              icon: const Icon(Icons.person),
            ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CalendarPage())),
                      child: Card(
                        color: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), 
                          side: const BorderSide(
                              color: Colors.black,
                              width:
                                  2.0), 
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_drink),
                            Text('ADD DRINKS')
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Activity())),
                      child: Card(
                        color: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), 
                          side: const BorderSide(
                              color: Colors.black,
                              width:
                                  2.0), 
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: InkWell(
                      onTap: () {
                        fecthHRData();
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
                          children: [Icon(Icons.insert_chart), Text('CHARTS')],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<HomeProvider>(builder: (context, data, child) {
                if (data.drive) {
                  return Container(
                    width: 350,
                    height: 250,
                    child: Card(
                      color: Colors.green[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/rate.png',
                                  height: 60, width: 60),
                              SizedBox(width: 25),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Your blood Alchool Level',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    '${((data.totalBAC * 100).roundToDouble()) / 100} g/L',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/safeDriver.png',
                                  height: 60, width: 60),
                              SizedBox(width: 20),
                              Text(
                                'You are a safe driver',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: 350,
                    height: 250,
                    child: Card(
                      color: Colors.red[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/rate.png',
                                  height: 60, width: 60),
                              SizedBox(width: 25),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Your blood Alchool Level',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    '${((data.totalBAC * 100).roundToDouble()) / 100} g/L',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/noSafeDriver.png',
                                  height: 60, width: 60),
                              SizedBox(width: 20),
                              Text(
                                'You are not a safe driver',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        
                        ],
                      ),
                    ),
                  );
                }
              }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToProfile() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProfilePage()));
    Provider.of<HomeProvider>(context, listen: false).updateBAL();
  }

  void fecthHRData() {
    DateTime giorno = DateTime.now().subtract(const Duration(days: 1));
    Provider.of<HomeProvider>(context, listen: false).fetchHRData(giorno);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ChartPage()));
  }
}
