import 'package:flutter/material.dart';
import 'package:sd_quiz/screens/quiz/quiz_screen.dart';

// general settings
const mainColorSD = Color(0xFF00796B);
const colorOne = Color(0xFF004445);
const colorRight = Color(0xFF43A047);
const colorWrong = Color(0xFFB71C1C);
//const fontStyleSD = ;

const textStyle1 = TextStyle(
  fontSize: 20,
  color: mainColorSD,
  fontWeight: FontWeight.w800,
);

const textStyleAppBar = TextStyle(
  color: Colors.white,
);

const textStyleBody = TextStyle(
  color: mainColorSD,
);


const quizButtonPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);
const quizButtonShape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)));
const quizButtonTextStyle = TextStyle(fontFamily: "alex");
