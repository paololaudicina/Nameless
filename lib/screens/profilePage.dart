import 'package:Nameless/screens/personalData.dart';
import 'package:flutter/material.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/splash.dart';
// import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // String data = DateFormat('yyyy-MM-dd').format(DateTime.now());
    void remove(){
      Provider.of<HomeProvider>(context, listen: false).removeAll();
      
      //Provider.of<HomeProvider>(context, listen: false).initPreferences();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Splash()), (Route<dynamic> route) => false,);
    }

    return Scaffold(
      appBar: AppBar(

          title: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return Text('sono ${provider.Sex}');
            },
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      remove();
                    },
                    icon: const Icon(Icons.logout)),
                const Text('LOG-OUT')
              ],
            )
          ]),
      body: Consumer<HomeProvider>(builder: (context, provider, child) {
        return Container(
          child: Stack(children: [
            Card(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ListTile(
                      leading: Text('Name: '),
                      title: Text(provider.nameUser),
                    ),
                    ListTile(
                      leading: Text('Surname: '),
                      title: Text('${provider.surnameUser}'),
                    ),
                    ListTile(
                      leading: Text('Age:'),
                      title: Text('${provider.age}'),
                    ),
                    ListTile(
                      leading: Text('Sex:'),
                      title: Text('${provider.Sex}'),
                    ),
                    ListTile(
                      leading: Text('Weight:'),
                      title: Text('${provider.weight} kg'),
                    )
                  ]),

            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => PersonalData()));
                },
                child: Text('EDIT'))
          ]),
        );
      }),
    );
  }
}
