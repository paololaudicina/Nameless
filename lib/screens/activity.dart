
/*import 'package:flutter/material.dart';
import 'package:nameless/utils/list.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final catalogue = CatalogueList();
  late final List<Map<String, dynamic>> _items = List.generate(
    10,
    (index) => {
      "id": index,
      "title": catalogue.list[index].title,
      "content": catalogue.list[index].description,
    },
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Creative activities'),
        ),
        body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return Column(
              children: [
                Card(
                  
                  color: Colors.blue,
                  elevation: 4,
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    childrenPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    expandedCrossAxisAlignment: CrossAxisAlignment.end,
                    title: Text(
                      item['title'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    children: [
                      Text(
                        item['content'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10)
              ],
            );
          },
        ),
      ),
    );
  }
}*/

//late final Keyword: This is used to declare a non-nullable variable that will be initialized later. 
//The variable _items is declared with late final to ensure it's only initialized once and guarantees it will be assigned before it's accessed.

//Non-nullable Variables: Using late ensures that the variable is non-nullable and will be assigned before use, 
//which helps in maintaining null safety.


import 'package:flutter/material.dart';
import 'package:Nameless/models/list.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final catalogue = CatalogueList();
  /*late final List<Map<String, dynamic>> _items = List.generate(
    10,
    (index) => {
      "id": index,
      "title": catalogue.list[index].title,
      "content": catalogue.list[index].description,
    },
  );*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Creative activities'),
          /*actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
          ]*/
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
                  //final item = _items[index];
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
                          width: 300,
                          child: Card(
                            child: Center(child: Text(catalogue.list[index].title)),
                            color: Colors.orange,
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

