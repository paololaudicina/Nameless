

import 'package:Nameless/screens/advice.dart';
import 'package:Nameless/screens/personalData.dart';
import 'package:Nameless/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/login.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
    void remove()async{
      Provider.of<HomeProvider>(context, listen: false).removeAll();
      
      Provider.of<HomeProvider>(context, listen: false).initPreferences();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Splash()), (Route<dynamic> route) => false,);
          
    }

    int scoreQuiz = Provider.of<HomeProvider>(context, listen: false).scoreQuiz;

    String getProfileImage(String gender) {
      if (gender.toLowerCase() == 'female') {
        return "images/profilephotofemale.jpg";
      } else {
        return "images/profilephotomale.jpg";
      }
    }

    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Profile page',
                  style: TextStyle(fontSize: 35, color: Colors.black))
            ]
            ),

          backgroundColor: Colors.blue,
          actions: [
                IconButton(
                    onPressed: ()  async{
                      remove();
                    },
                    icon: const Icon(Icons.logout)),
                SizedBox(width: 10),
            
          ]),

      body: Consumer<HomeProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
             CircleAvatar(
            radius: 90,
            backgroundImage: AssetImage(getProfileImage(provider.Sex)),
          ),
          SizedBox(height:40),
          Card(
              color: Color.fromARGB(255, 43, 96, 176),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child:Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                      children: [
                     const Text(
                      'Your personal data :',
                    style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                    SizedBox(height:10),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10,left:20),
                    child:Row(
                            children: [
                            Text('Name: ',
                            style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text('${provider.nameUser}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,)
                          )]
                            ,)
                          ),

                    Padding(
                            padding: EdgeInsets.only(bottom: 10,left:20),
                            child:
                                  Row(
                            children: [
                            Text('Surname: ',
                            style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text('${provider.surnameUser}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,)
                          )]
                            ,)     
                           ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10,left:20),
                              child:
                                      Row(
                            children: [
                            Text('Age: ',
                            style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text('${provider.age}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,)
                          )]
                            ,) 
                                      ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10,left:20),
                              child:
                                    Row(
                            children: [
                            Text('Sex: ',
                            style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text('${provider.Sex}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,)
                          )]
                            ,)   
                                ),
                            Padding(
                              padding:EdgeInsets.only(bottom: 10,left:20),
                              child:
                                    Row(
                            children: [
                            Text('Weight: ',
                            style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text('${provider.weight}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,)
                          )]
                            ,) 
                    ),
                    SizedBox(height:20),
                    Center(
                      child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.white)),
                                                      onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => PersonalData(
                      name: provider.nameUser,
                      surname: provider.surnameUser,
                      age: provider.age,
                      weight: provider.weight,
                      sex: provider.Sex,)),(Route<dynamic> route) => false,);
                }, child: Text('EDIT',
           style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,)),
                    )

            ),
            ]
        ),
        )
            ),
          SizedBox(height:40),
          ElevatedButton(
            onPressed: () {
              
              Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SplashQuiz(score: scoreQuiz,)), (Route<dynamic> route) => false,);
            }, 
            child: Text('SWITCH LEVEL',
            style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),),
            style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            )
          ]
        ));
                
      }),
      
      ));
  }
}

