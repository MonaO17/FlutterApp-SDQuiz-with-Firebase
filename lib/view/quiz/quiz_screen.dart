import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sd_quiz/model/quiz.dart';
import 'package:sd_quiz/view/quiz/podium_screen.dart';
import 'package:sd_quiz/view/quiz/quiz_end.dart';
import '../../database/database_helper.dart';
import 'package:flutter/rendering.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

// Allgemeine Variablen
int counter = 0;
int finalScore = 0;
int questionNumber = 0;
int len;
int ans = 0;
Color buttonColor1 = Color(0xff004445);
Color buttonColor2 = Color(0xff004445);
Color buttonColor3 = Color(0xff004445);
Color buttonColor4 = Color(0xff004445);

class _QuizScreenState extends State<QuizScreen> {
  DatabaseHelper helper = DatabaseHelper(); // get singelton instance of Database-Helper class
  Future futureList;
  List<Quiz> quizList;
  int quizID = 1;
  int len = 8;

  @override
  void initState() {
    super.initState();
    futureList = _getQuiz(quizID);
  }

  _getQuiz(quizID) async {
    quizList = await helper.getQuizList(quizID);
    return quizList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false, //disabel the back button, otherwise user could go back to questions to increase their score
        child: Center(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Quiz'),
            ),
            body: FutureBuilder(
              future: futureList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Frage ${questionNumber + 1} von ${len} ",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Text(
                                "Punkte: $finalScore",
                                style: TextStyle(fontSize: 20.0),
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/Karteikarte.png'),
                                height: 200,
                              ),
                              Text(
                                snapshot.data[questionNumber].question,
                                style: new TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ]),
                        Padding(padding: EdgeInsets.all(5.0)),
                        ElevatedButton(
                          onPressed: () {
                            if (1 == snapshot.data[questionNumber].answerID) {
                              setState(() {
                                buttonColor1 = Colors.green;
                              });
                              finalScore += 5;
                            } else {
                              setState(() {
                                buttonColor1 = Colors.red;
                              });
                            }
                            updateQuestion();
                          },
                          child: Text(
                            snapshot.data[questionNumber].answerOne,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: buttonColor1,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                              ),
                              textStyle: TextStyle(
                                fontSize: 13,
                                //fontStyle: FontStyle.italic,
                                //fontFamily: "alex",
                              )),
                        ),
                        Padding(padding: EdgeInsets.all(5.0)),
                        ElevatedButton(
                          onPressed: () {
                            if (2 == snapshot.data[questionNumber].answerID) {
                              setState(() {
                                buttonColor2 = Colors.green;
                              });
                              finalScore += 5;
                            } else {
                              setState(() {
                                buttonColor2 = Colors.red;
                              });
                            }
                            updateQuestion();
                          },
                          child: Text(
                            snapshot.data[questionNumber].answerTwo,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: buttonColor2,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                              ),
                              textStyle: TextStyle(
                                fontSize: 13,
                                //fontStyle: FontStyle.italic,
                                //fontFamily: "alex",
                              )),
                        ),
                        Padding(padding: EdgeInsets.all(5.0)),
                        ElevatedButton(
                          onPressed: () {
                            if (3 == snapshot.data[questionNumber].answerID) {
                              setState(() {
                                buttonColor3 = Colors.green;
                              });
                              finalScore += 5;
                            } else {
                              setState(() {
                                buttonColor3 = Colors.red;
                              });
                            }
                            updateQuestion();
                          },
                          child: Text(
                            snapshot.data[questionNumber].answerThree,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: buttonColor3,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                              ),
                              textStyle: TextStyle(
                                fontSize: 13,
                                //fontStyle: FontStyle.italic,
                                //fontFamily: "alex",
                              )),
                        ),
                        Padding(padding: EdgeInsets.all(5.0)),
                        ElevatedButton(
                          onPressed: () {
                            if (4 == snapshot.data[questionNumber].answerID) {
                              setState(() {
                                buttonColor4 = Colors.green;
                              });
                              finalScore += 5;
                            } else {
                              setState(() {
                                buttonColor4 = Colors.red;
                              });
                            }
                            updateQuestion();
                          },
                          child: Text(
                            snapshot.data[questionNumber].answerFour,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: buttonColor4,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                              ),
                              textStyle: TextStyle(
                                fontSize: 13,
                                //fontStyle: FontStyle.italic,
                                //fontFamily: "alex",
                              )),
                        ),
                      ]);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ));
  }

  void updateQuestion() {
    Future.delayed(const Duration(seconds: 4), () {
      buttonColor1 = Color(0xff004445);
      buttonColor2 = Color(0xff004445);
      buttonColor3 = Color(0xff004445);
      buttonColor4 = Color(0xff004445);

      setState(() {
        if (questionNumber == len - 1 && finalScore >= 30) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => QuizPodiumScreen(finalScore: finalScore)));
        } else if (questionNumber == len - 1 && finalScore < 30) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => QuizEndScreen(finalScore: finalScore)));
        } else {
          questionNumber++;
        }
      });
    });
  }
}