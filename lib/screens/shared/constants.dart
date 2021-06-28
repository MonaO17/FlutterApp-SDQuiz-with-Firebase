import 'package:flutter/material.dart';

// general settings
const mainColorSD = Color(0xFF00796B);
const colorTwo = Color(0xFF006264);
const colorThree = Color(0xFFB2DFDB);
const colorRight = Color(0xFF43A047);
const colorWrong = Color(0xFFB71C1C);
const fontStyleSD = "AvenirFont";

const textStyleAppBar = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600,
  fontFamily: fontStyleSD,
);

const textStyleBody = TextStyle(
  color: mainColorSD,
  fontFamily: fontStyleSD,
);

const textStyle1 = TextStyle(
  fontSize: 20,
  color: mainColorSD,
  fontWeight: FontWeight.w300,
  fontFamily: fontStyleSD,
);

const textStyle2 = TextStyle(
  fontSize: 18,
  color: mainColorSD,
  fontWeight: FontWeight.w500,
  fontFamily: fontStyleSD,
);

const textStyle3 = TextStyle(
  fontSize: 32,
  color: mainColorSD,
  fontWeight: FontWeight.w500,
  fontFamily: fontStyleSD,
);

const textStyle4 = TextStyle(
  color: mainColorSD,
  fontSize: 28,
  fontWeight: FontWeight.w600,
  fontFamily: fontStyleSD,
);

const quizButtonPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);
const quizButtonShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)));
const quizButtonTextStyle =
    TextStyle(fontWeight: FontWeight.w300, fontFamily: fontStyleSD);
