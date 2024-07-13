import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/advice.dart';
import 'package:Nameless/screens/homeHardPage.dart';
import 'package:Nameless/screens/homeSoftPage.dart';
import 'package:Nameless/screens/login.dart';
import 'package:Nameless/screens/personalData.dart';
import 'package:Nameless/screens/questionnaire.dart';
import 'package:Nameless/services/Impact.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInitialization();
    });
  }

  void _checkInitialization() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    while (!homeProvider.isInitialized) {
      await Future.delayed(const Duration(seconds: 3));
    }
    _refreshControl(context);
  }

  Future<void> _refreshControl(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    var refresh = sp.getString("refreshToken");

   int scoreQuiz = Provider.of<HomeProvider>(context, listen: false).scoreQuiz;
  int levelChoice = Provider.of<HomeProvider>(context, listen: false).levelChoice;
   bool personalData = Provider.of<HomeProvider>(context, listen: false).personalData;

    if (refresh != null) {
      bool hasExpired = JwtDecoder.isExpired(refresh);
      if (hasExpired == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        await Impact().refreshToken();
        if (scoreQuiz != -1) {
          if (levelChoice != 0) {
            if (personalData != false) {
              if (levelChoice == 1) {
                Provider.of<HomeProvider>(context,listen: false).updateBAL(); // to updateBAL when we restart the app green arrow
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeSoftPage()));
              } else {
                if (mounted) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeHardPage()));
                }
              }
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => PersonalData()));
            }
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SplashQuiz(score: scoreQuiz)));
          }
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Questionnaire()));
        }
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        if (!homeProvider.isInitialized) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return SafeArea(
          child:Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ Colors.white, Colors.blue.shade300,Colors.blue.shade900],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            child:Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/wellness.png',
                  width: 150,
                  height: 150,),
                  const SizedBox(height: 20),
                  const Text('Welcome in your new life',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,)
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'We are glad to have you here',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),)
          ));

        }
      },
    );
  }
}
