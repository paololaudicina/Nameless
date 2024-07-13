
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
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Creative activities can be very helpful for people looking to reduce or quit drinking alcohol. These activities not only help distract from the urge to drink but also promote mental well-being, improve mood, and build new healthy habits. Here are some creative activities and their benefits:',
                  style: TextStyle(fontSize: 16),
                  ),
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
                            barrierDismissible:false,
                            context: context, 
                            builder: (context) =>AlertDialog(
                              content: Container(
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(catalogue.list[index].title,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10),
                                    Text(catalogue.list[index].description,
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.left,),
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
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child:Image.asset(
                                      catalogue.list[index].imageUrl,
                                      height: 50,
                                       width: 50,
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(catalogue.list[index].title,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),)
                                ],
                              )),

                          ),
                        ),
                      ),
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

