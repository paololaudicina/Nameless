import 'package:flutter/material.dart';
import 'package:progetto_prova/provider/homeProvider.dart';
import 'package:progetto_prova/screens/login.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    void remove(){
    Provider.of<HomeProvider>(context,listen: false).removeAll();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  LoginPage()));
   }
    return  Scaffold(
      appBar: AppBar(
        title: Consumer<HomeProvider>(
              builder: (context, provider, child) {return Text('sono ${provider.Sex}');},),
        actions: [
          Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(onPressed: () async{
              final sp = await SharedPreferences.getInstance();
              await sp.remove('refreshToken');
              await sp.remove('accessToken');
              await sp.remove('flag');
              await sp.remove('scoreQuiz');
              await sp.remove('levelChoice');
              await sp.remove('personalData');
              remove();
    
            }, 
            icon: const Icon(Icons.logout)
            ),
            const Text('LOG-OUT')
          ],
          )
          ]
      
      ),
      body: const Center(child: Text('Profile Page'))
                );
    
       

  }
}