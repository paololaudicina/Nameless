import 'package:flutter/material.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/splash.dart';
import 'package:provider/provider.dart';

void main() {
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   ChangeNotifierProvider(
      create: (context) => HomeProvider(),
       builder: (context, child) =>
        MaterialApp(
          debugShowCheckedModeBanner: false,
        home: Splash()
      ),
    );
  }
}

