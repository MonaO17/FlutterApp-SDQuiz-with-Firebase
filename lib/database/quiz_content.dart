import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'quiz_content_model.dart';

class QuizContent extends StatefulWidget {
  @override
  _QuizContentState createState() => _QuizContentState();
}

class _QuizContentState extends State<QuizContent> {

  List<QuizContentModel> content = List<QuizContentModel>();

  getDataFromSheet() async {
    var url = 'https://script.google.com/macros/s/AKfycbw_6uvHxG5QNXiOrGMCX-F1qFUF2v6xERPEucVQoI5nJeA7K_uN/exec';
    http.Response raw= await http.get(url);

    var jsonSDQuizAppContent = convert.jsonDecode(raw.body);

    jsonSDQuizAppContent.forEach((element){
      print('$element THIS IS NEXT!!');
      QuizContentModel quizContentHelper = new QuizContentModel();
      quizContentHelper.questionID = element['questionID'];
      quizContentHelper.quizID = element['quizID'];
      quizContentHelper.question = element['question'];
      quizContentHelper.ansOne = element['ans1'];
      quizContentHelper.ansTwo = element['ans2'];
      quizContentHelper.ansThree = element['ans3'];
      quizContentHelper.ansFour = element['ans4'];
      quizContentHelper.ansID = element['answerID'];

      content.add(quizContentHelper);
    });
  }

  void initState() {
    getDataFromSheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DB Test'),
        centerTitle: true,
        backgroundColor: Color(0xff004445),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: content.length,
          itemBuilder: (context, index){
            return QueAndans(
              questionID: content[index].ansOne,
              quizID: content[index].ansTwo,
              question: content[index].question,
              ansOne: content[index].ansOne,
              ansTwo: content[index].ansTwo,
              ansThree: content[index].ansThree,
              ansFour: content[index].ansFour,
              ansID: content[index].ansFour,
            );
          }),
        ),
      );
  }
}

class  QueAndans extends StatelessWidget {
  final String questionID, quizID, question, ansOne, ansTwo, ansThree, ansFour, ansID;

  QueAndans({this.questionID, this.quizID, this.question, this.ansOne, this.ansTwo, this.ansThree, this.ansFour, this.ansID});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      child: Text(question))),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ansOne),
                  Text(
                    'from $ansTwo',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          Text(ansThree)
        ],
      ),
    );
  }
}




