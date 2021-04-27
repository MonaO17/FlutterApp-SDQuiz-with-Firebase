import 'package:flutter/material.dart';
import 'package:sd_quiz/pages/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      debugShowCheckedModeBanner:false ,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.amber[50],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

