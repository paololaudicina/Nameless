import 'package:Nameless/models/cataloguehealth.dart';
import 'package:Nameless/screens/activity.dart';
import 'package:Nameless/screens/calendarPage.dart';
import 'package:Nameless/screens/chartPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Nameless/models/info.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/profilePage.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
              Text('Soft Level',
                  style: TextStyle(fontSize: 35, color: Colors.white)),
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
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side:
                              const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_bar),
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
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side:
                              const BorderSide(color: Colors.black, width: 2.0),
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
                        color: Colors.blue,
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
                          children: [Icon(Icons.favorite), Text('CHART HR')],
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
                  return Column(
                    children: [
                      Container(
                        width: 350,
                        height: 300,
                        child: Card(
                          color: Colors.green[200],
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                             
                              children: [
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset('images/safeDriver.png',
                                        height: 60, width: 60),
                                    SizedBox(width: 30),
                                    Text(
                                      'You are a safe driver',
                                      style: TextStyle(fontSize: 20),
                                      textAlign:  TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('images/healthSoft.png',
                                        height: 60, width: 60),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        healthStatus(),
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                         Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){data.updateBALfake();},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            
                          ), child: const Text('ADD HOUR',style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),),
                  ElevatedButton(onPressed: (){data.updateBAL();},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            
                          ), child: const Text('RESET',style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),),
                ],
              )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        width: 350,
                        height: 300,
                        child: Card(
                          color: Colors.red[200],
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset('images/healthHard.png',
                                        height: 60, width: 60),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        healthStatus(),
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                        Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){data.updateBALfake();},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          
                          ), child: const Text('ADD HOUR',style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),),
                  ElevatedButton(onPressed: (){data.updateBAL();},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            
                          ), child: const Text('RESET',style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),),
                ],
              )
                    ],
                  );
                }
              }),
              
             
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

  String healthStatus() {
    final CatalogueEffect catalogue = CatalogueEffect();
    double BAL = Provider.of<HomeProvider>(context, listen: false).totalBAC;
    for (var i = 0; i < catalogue.list.length; i++) {
      if (BAL >= catalogue.list[i].rangeAlchool[0] &&
          BAL <= catalogue.list[i].rangeAlchool[1]) {
        return catalogue.list[i].description;
      }
    }
    return 'A problem occured';
  }
}
