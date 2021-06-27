import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sd_quiz/model/quiz.dart';
import 'package:sd_quiz/screens/quiz/podium_screen.dart';
import 'package:sd_quiz/screens/quiz_overview/quiz_overview_screen.dart';
import 'package:sd_quiz/screens/shared/constants.dart';
import 'package:sd_quiz/screens/shared/loading.dart';
import 'package:sd_quiz/screens/shared/text_button_app_bar.dart';
import '../../database/database_helper.dart';
import 'package:flutter/rendering.dart';

import 'end_screen.dart';

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
  int len, totalQuizScore, topicID, idCurrentUser;

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
    len = quizList.length;
    totalQuizScore = len * 3;
    return quizList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      //disabel the back button, otherwise user could go back to questions to increase their score
      child: Center(
        child: Scaffold(
          //*******   AppBar (Leiste oben)   *******
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: mainColorSD,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Quiz',
              style: textStyleAppBar,
            ),
            actions: [
              TextButtonAppBar(
                  iconAppBar: Icons.home,
                  title: 'Home',                                      //NEUER TEXT
                  nextPage: QuizOverviewScreen(idCurrentUser: idCurrentUser)),
            ],
          ),
          //*******   Body (Restlicher Screen)   *******
          body:
          //*******   Hintergrundbild Karteikarte   *******
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/qbackground.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            //*******   SingleChildScrollView & FutureBuilder   *******
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: futureList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    //*******   Zeile oben (Frage 1/8, Score:...  *******
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(5.0)),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Frage ${questionNumber + 1} von $len ",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  "Punkte: $quizScore",
                                  style: TextStyle(fontSize: 20.0),
                                )
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(7.0)),

                          //*******   Frage   *******
                          Container(
                            height:
                            MediaQuery.of(context).copyWith().size.height /
                                3,
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

                          //*******   Antwort 1   *******
                          Container(
                            height:
                            MediaQuery.of(context).copyWith().size.height /
                                10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (1 ==
                                    snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor1 = Colors.green[600];
                                  });
                                  quizScore += 3;
                                } else {
                                  setState(() {
                                    buttonColor1 = Colors.red[800];
                                  });
                                }
                                updateQuestion(
                                    idCurrentUser, quizScore, topicID);
                              },
                              child: Text(
                                snapshot.data[questionNumber].answerOne,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: buttonColor1,
                                padding: quizButtonPadding,
                                shape: quizButtonShape,
                                textStyle: quizButtonTextStyle,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),

                          //*******   Antwort 2   *******
                          Container(
                            height:
                            MediaQuery.of(context).copyWith().size.height /
                                10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (2 ==
                                    snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor2 = Colors.green[600];
                                  });
                                  quizScore += 3;
                                } else {
                                  setState(() {
                                    buttonColor2 = Colors.red[800];
                                  });
                                }
                                updateQuestion(
                                    idCurrentUser, quizScore, topicID);
                              },
                              child: Text(
                                snapshot.data[questionNumber].answerTwo,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: buttonColor2,
                                padding: quizButtonPadding,
                                shape: quizButtonShape,
                                textStyle: quizButtonTextStyle,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),

                          //*******   Antwort 3   *******
                          Container(
                            height:
                            MediaQuery.of(context).copyWith().size.height /
                                10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (3 ==
                                    snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor3 = Colors.green[600];
                                  });
                                  quizScore += 3;
                                } else {
                                  setState(() {
                                    buttonColor3 = Colors.red[800];
                                  });
                                }
                                updateQuestion(
                                    idCurrentUser, quizScore, topicID);
                              },
                              child: Text(
                                snapshot.data[questionNumber].answerThree,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: buttonColor3,
                                padding: quizButtonPadding,
                                shape: quizButtonShape,
                                textStyle: quizButtonTextStyle,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),

                          //*******   Antwort 4   *******
                          Container(
                            height:
                            MediaQuery.of(context).copyWith().size.height /
                                10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (4 ==
                                    snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor4 = Colors.green[600];
                                  });
                                  quizScore += 3;
                                } else {
                                  setState(() {
                                    buttonColor4 = Colors.red[800];
                                  });
                                }
                                updateQuestion(
                                    idCurrentUser, quizScore, topicID);
                              },
                              child: Text(
                                snapshot.data[questionNumber].answerFour,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: buttonColor4,
                                padding: quizButtonPadding,
                                shape: quizButtonShape,
                                textStyle: quizButtonTextStyle,
                              ),
                            ),
                          ),
                        ]);
                  } else {
                    return Loading();
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
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        buttonColor1 = Colors.teal[800];
        buttonColor2 = Colors.teal[800];
        buttonColor3 = Colors.teal[800];
        buttonColor4 = Colors.teal[800];
        if (questionNumber == len - 1 && quizScore >= (totalQuizScore * 0.7)) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => QuizPodiumScreen(
                      idCurrentUser: idCurrentUser,
                      quizScore: quizScore,
                      totalQuizScore: totalQuizScore,
                      topicID: topicID)));
          questionNumber = 0;
        } else if (questionNumber == len - 1 &&
            quizScore < (totalQuizScore * 0.7)) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => QuizEndScreen(
                      idCurrentUser: idCurrentUser,
                      quizScore: quizScore,
                      totalQuizScore: totalQuizScore,
                      topicID: topicID)));
          questionNumber = 0;
        } else {
          questionNumber++;
        }
      });
    });
  }
}