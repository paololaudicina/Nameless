import 'package:flutter/material.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/advice.dart';
import 'package:Nameless/screens/homeHardPage.dart';
import 'package:Nameless/screens/homeSoftPage.dart';
import 'package:Nameless/screens/personalData.dart';
import 'package:Nameless/screens/questionnaire.dart';
import 'package:Nameless/services/Impact.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  static bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    int scoreQuiz = Provider.of<HomeProvider>(context, listen: false).scoreQuiz;
    int levelChoice =
        Provider.of<HomeProvider>(context, listen: false).levelChoice;
    bool personalData =
        Provider.of<HomeProvider>(context, listen: false).personalData;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            //backgroundColor: Colors.black,
            body: Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          color: Colors.white,
          /*decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.white,Color.fromARGB(255, 199, 209, 223)], begin: Alignment.topCenter, end: Alignment.bottomCenter)
          ),*/
        ),
        SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              /*Padding(
                    padding: EdgeInsets.only( top:15, right: 15),
                    child: Image.asset(
                                "images/senza_sfondo.png",height: 270,)
                  ),*/
              Container(
                  margin: EdgeInsets.only(top: 30, left: 10, right: 10),

                  //color:Colors.red,
                  child: Image.asset(
                    "images/Data_security_05.jpg",
                    height: 250,
                  )),
              // SizedBox(height: 20),

              Container(
                height: 350,
                width: 350,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color.fromARGB(255, 43, 96, 176),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          //textAlign: TextAlign.start,  //problema nel posizionare il testo sulla sinistra
                        ),
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Please Sign in to continue',
                          style: TextStyle(
                            color: Color.fromARGB(255, 43, 96, 176),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          //textAlign: TextAlign.start,  //problema nel posizionare il testo sulla sinistra
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.left,
                                    controller: userController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 85, 129, 196),
                                      //labelText: 'Username',
                                      hintText: 'Username',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      // border: ,
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter username';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.emailAddress,
                                    controller: passController,
                                    textAlign: TextAlign.left,
                                    obscureText: !_passwordVisible,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 85, 129, 196),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      /*enabledBorder: OutlineInputBorder(  come cambiare il colore del bordo prima dell'on tap
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.red,
                  
                ),
                                ),*/
                                      prefixIcon:
                                          Icon(Icons.lock, color: Colors.white),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          _showPassword();
                                        },
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Password';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 50,
                                  width: 100,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 85, 129, 196))),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final response = await Impact()
                                              .getAndStoreToken(
                                                  userController.text,
                                                  passController.text);
                                          if (response == 200) {
                                            final sp = await SharedPreferences
                                                .getInstance();
                                            sp.setString('username',
                                                userController.text);
                                            sp.setString('password',
                                                passController.text);
                                            //bool flag = true;
                                            //await sp.setBool('flag', flag);
                                            if (scoreQuiz != -1) {
                                              if (levelChoice != 0) {
                                                if (personalData != false) {
                                                  if (levelChoice == 1) {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomeSoftPage()));
                                                  } else {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomeHardPage()));
                                                  }
                                                } else {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PersonalData()));
                                                }
                                              } else {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SplashQuiz(
                                                                score:
                                                                    scoreQuiz)));
                                              }
                                            } else {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Questionnaire()));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                              ..removeCurrentSnackBar()
                                              ..showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Wrong username or password'),
                                              ));
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                )
                              ]))
                    ]),
              ),
            ],
          ),
        ))
      ],
    )));
  }
}
