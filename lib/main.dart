import 'package:flutter/material.dart';
import 'package:sd_quiz/quiz/question_four.dart';

//Mona war hier
void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':(context) => Question_four(),
   // '/home': (context) => Home(),
  //  '/location': (context) => ChooseLocation(),
  },
));