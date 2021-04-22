import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'quiz_content_helper.dart';

class QuizContent extends StatefulWidget {
  @override
  _QuizContentState createState() => _QuizContentState();
}

class _QuizContentState extends State<QuizContent> {

  //variables
  List<QuizContentHelper> content = List<QuizContentHelper>();
  Uri url = Uri.parse('https://script.google.com/macros/s/AKfycbwEIGMy_DJc_WgFlu7c-7CgkyHLoffB8vHUGJLul5d2B8yYHC4/exec');

  getDataFromSheet() async {
    var raw = await http.get(url);
    print(raw.body);

    var jsonSDQuizAppContent = convert.jsonDecode(raw.body);
    print('this is  json content $jsonSDQuizAppContent');

    //content = jsonSDQuizAppContent.map((json) => ContentHelper.fromJson(json));
    jsonSDQuizAppContent.forEach((element){
      print('$element THIS IS NEXT!!');
    });

    print('${content[3]}');
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



