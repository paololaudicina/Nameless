import 'package:flutter/material.dart';
import 'package:progetto_prova/provider/homeProvider.dart';
import 'package:progetto_prova/screens/splash.dart';
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
       const MaterialApp(
        home: Splash()
      ),
    );
  }
}


