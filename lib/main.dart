import 'package:flutter/material.dart';
import 'package:sd_quiz/quiz/question_four.dart';
import 'package:sd_quiz/database/quiz_content.dart';

//Mona war hier
void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':(context) => QuizContent(),
   // '/home': (context) => Home(),
  //  '/location': (context) => ChooseLocation(),
  },
));