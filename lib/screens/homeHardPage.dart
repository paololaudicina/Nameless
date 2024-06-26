import 'package:flutter/material.dart';
import 'package:Nameless/models/info.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/profilePage.dart';
import 'package:Nameless/widget/lineplot.dart';
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
                  hardLevelExplanation(context);
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
                        children: [Icon(Icons.local_drink), Text('ADD DRINKS')],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    height: 180,
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
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
                        children: [Icon(Icons.car_crash), Text('DRIVE')],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    fecthHRData();
                  },
                  child: const Text('showPlot')),
              const SizedBox(
                height: 20,
              ),
              Consumer<HomeProvider>(builder: (context, data, child) {
                if (data.heartrateData.isEmpty) {
                  return  const Text('nothing to display ');
                } else {
                  return HRDataPlot(heartrateData: data.heartrateData);
                }
              }),
              const SizedBox(height: 20,),
              IconButton(onPressed: () {
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));},
                 icon: const Icon(Icons.person))
            ],
          ),
        ),
      ),
    );
  }
  void fecthHRData() {
    DateTime giorno = DateTime.now();
    Provider.of<HomeProvider>(context, listen: false).fetchHRData(giorno);
  }

  
}