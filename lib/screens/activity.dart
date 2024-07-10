
import 'package:flutter/material.dart';
import 'package:Nameless/models/list.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final CatalogueList catalogue = CatalogueList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Creative activities'),
          backgroundColor: Colors.lightBlue,
        ),
        body: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Creative activities can be very helpful for people looking to reduce or quit drinking alcohol. These activities not only help distract from the urge to drink but also promote mental well-being, improve mood, and build new healthy habits. Here are some creative activities and their benefits:'),
              ),
              SizedBox (height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: catalogue.list.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context, 
                            builder: (context) =>AlertDialog(
                              content: Container(
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(catalogue.list[index].title),
                                    SizedBox(height: 10),
                                    Text(catalogue.list[index].description),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(
                                                          context), 
                                      child: Text('OK')),
                                  ],
                                ),
                              ),
                              
                            )
                           
                          );
                        },
                        child: Container(
                          height: 100,
                          width: 400,
                          child: Card(
                            child: Center(
                              child: Row(
                                children: [
                                  Text(catalogue.list[index].title),
                                ],
                              )),
                            //color: const Color.fromARGB(255, 106, 0, 255),
                           /* child: Stack(
                              children:[
                              Image.asset('images/spaghetti.jpg', width: 400,),
                               Center(child: Text(catalogue.list[index].title)),
                    ]
                  )*/
                          ),
                        ),
                      ),
                      SizedBox(height: 10)
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Added shrinkWrap: true and physics: NeverScrollableScrollPhysics() to the ListView.builder to ensure it fits within
// the SingleChildScrollView without causing any scroll conflicts.

