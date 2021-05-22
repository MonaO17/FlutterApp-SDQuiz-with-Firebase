import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sd_quiz/model/quiz.dart';
import 'package:sd_quiz/view/quiz/podium_screen.dart';
import 'package:sd_quiz/view/quiz/quiz_end.dart';
import '../../database/database_helper.dart';
import 'package:flutter/rendering.dart';

// variables
int quizScore = 0;
int questionNumber = 0;
int ans = 0;
Color buttonColor1 = Colors.teal[800];
Color buttonColor2 = Colors.teal[800];
Color buttonColor3 = Colors.teal[800];
Color buttonColor4 = Colors.teal[800];

class QuizScreen extends StatefulWidget {
  int topicID, idCurrentUser;

  //constructor
  QuizScreen({Key key, @required this.topicID, @required this.idCurrentUser})
      : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState(topicID, idCurrentUser);
}

class _QuizScreenState extends State<QuizScreen> {
  DatabaseHelper helper =
      DatabaseHelper(); // get singelton instance of Database-Helper class
  Future futureList;
  List<Quiz> quizList;
  int len = 8;
  int topicID, idCurrentUser;

  //constructor
  _QuizScreenState(this.topicID, this.idCurrentUser);

  @override
  void initState() {
    super.initState();
    quizScore = 0;
    futureList = _getQuiz(topicID);
  }

  _getQuiz(topicID) async {
    quizList = await helper.getQuizList(topicID);
    return quizList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      //disabel the back button, otherwise user could go back to questions to increase their score
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal[800],
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Quiz',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/qbackground.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: FutureBuilder(
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
                                  "Punkte: $quizScore",
                                  style: TextStyle(fontSize: 20.0),
                                )
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Container(
                            height:
                                MediaQuery.of(context).copyWith().size.height / 3,
                            child: Center(
                              child: Text(
                                snapshot.data[questionNumber].question,
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),
                          Container(
                            height:
                                MediaQuery.of(context).copyWith().size.height /
                                    10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (1 == snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor1 = Colors.green[600];
                                  });
                                  quizScore += 5;
                                } else {
                                  setState(() {
                                    buttonColor1 = Colors.red[800];
                                  });
                                }
                                updateQuestion(idCurrentUser, quizScore, topicID);
                              },
                              child: Text(
                                snapshot.data[questionNumber].answerOne,
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: buttonColor1,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  textStyle: TextStyle(
                                      //fontFamily: "alex",
                                      )),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),
                          Container(
                            height:
                                MediaQuery.of(context).copyWith().size.height /
                                    10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (2 == snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor2 = Colors.green[600];
                                  });
                                  quizScore += 5;
                                } else {
                                  setState(() {
                                    buttonColor2 =  Colors.red[800];
                                  });
                                }
                                updateQuestion(idCurrentUser, quizScore, topicID);
                              },
                              child: Text(
                                snapshot.data[questionNumber].answerTwo,
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: buttonColor2,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  textStyle: TextStyle(
                                      //fontSize: 13,
                                      )),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),
                          Container(
                            height:
                                MediaQuery.of(context).copyWith().size.height /
                                    10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (3 == snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor3 = Colors.green[600];
                                  });
                                  quizScore += 5;
                                } else {
                                  setState(() {
                                    buttonColor3 =  Colors.red[800];
                                  });
                                }
                                updateQuestion(idCurrentUser, quizScore, topicID);
                              },
                              child: Text(
                                snapshot.data[questionNumber].answerThree,
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: buttonColor3,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  textStyle: TextStyle(
                                      //fontSize: 13,
                                      )),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),
                          Container(
                            height:
                                MediaQuery.of(context).copyWith().size.height /
                                    10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (4 == snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor4 = Colors.green[600];
                                  });
                                  quizScore += 5;
                                } else {
                                  setState(() {
                                    buttonColor4 =  Colors.red[800];
                                  });
                                }
                                updateQuestion(idCurrentUser, quizScore, topicID);
                              },
                              child: Text(
                                snapshot.data[questionNumber].answerFour,
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: buttonColor4,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  textStyle: TextStyle(
                                      //fontSize: 13,
                                      )),
                            ),
                          ),
                        ]);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateQuestion(int idCurrentUser, int quizScore, int topicID) {
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        buttonColor1 = Colors.teal[800];
        buttonColor2 = Colors.teal[800];
        buttonColor3 = Colors.teal[800];
        buttonColor4 = Colors.teal[800];
        if (questionNumber == len - 1 && quizScore >= 30) {
          questionNumber = 0;
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => QuizPodiumScreen(
                      idCurrentUser: idCurrentUser,
                      quizScore: quizScore,
                      topicID: topicID)));
        } else if (questionNumber == len - 1 && quizScore < 30) {
          questionNumber = 0;
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => QuizEndScreen(
                      idCurrentUser: idCurrentUser,
                      quizScore: quizScore,
                      topicID: topicID)));
        } else {
          questionNumber++;
        }
      });
    });
  }
}
