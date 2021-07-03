/* code partly inspired by
       - https://www.youtube.com/watch?v=a3W_TQ5G7JA
*/
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

/// quiz score
int quizScore = 0;
/// question number
int questionNumber = 0;
/// color of buttons
Color buttonColor1 = mainColorSD;
Color buttonColor2 = mainColorSD;
Color buttonColor3 = mainColorSD;
Color buttonColor4 = mainColorSD;

/// QuizScreen is the screen seen during the quiz
class QuizScreen extends StatefulWidget {
  ///[topicID] is the id that identifies the quiz topic, [idCurrentUser] is the id that identifies the current user
  int topicID, idCurrentUser;

  /// constructor _QuizScreenState
  QuizScreen({Key key, @required this.topicID, @required this.idCurrentUser})
      : super(key: key);

  /// calls _QuizScreenState, hands over variables
  @override
  _QuizScreenState createState() => _QuizScreenState(topicID, idCurrentUser);
}

/// private class called by QuizScreen, can change state
class _QuizScreenState extends State<QuizScreen> {
  /// instance of [DatabaseHelper]
  DatabaseHelper helper =  DatabaseHelper(); // get singelton instance of Database-Helper class
  /// future-object, needed for future-builder
  Future futureList;
  /// list with quizzes for regarding topicID
  List<Quiz> quizList;
  /// [len] is the length of the quiz, [totalQuizScore] is the total amount of points that can be reached,
  /// [topicID] identifies the topic, [idCurentUser] identfies current user
  int len, totalQuizScore, topicID, idCurrentUser;

  /// constructor _QuizScreenState
  _QuizScreenState(this.topicID, this.idCurrentUser);

  /// initState is called first, initializes [quizScore] with 0 and [futureList] with return-value of method [_getQuiz]
  @override
  void initState() {
    super.initState();
    quizScore = 0;
    futureList = _getQuiz(topicID);
  }

  /// requests list of all quizzes with corresponding [topicID], initalizes [len] and [totalQuizScore], returns list with quizzes [quizList]
  _getQuiz(topicID) async {
    quizList = await helper.getQuizList(topicID);
    len = quizList.length;
    totalQuizScore = len * 3;
    return quizList;
  }

  /// builds screen with Scaffold-Widget, with text, question and four answer-buttons
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(

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
                  title: 'Home',
                  nextPage: QuizOverviewScreen(idCurrentUser: idCurrentUser)),
            ],
          ),


          body:
          //Background
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
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: futureList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {

                    //Top row with score and question number
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
                                  style: textStyle1,
                                ),
                                Text(
                                  "Punkte: $quizScore",
                                  style: textStyle1,
                                )
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(7.0)),

                          //Question
                          Container(
                            height:
                            MediaQuery.of(context).copyWith().size.height / 3,
                            child: Center(
                              child: Text(
                                snapshot.data[questionNumber].question,
                                textAlign: TextAlign.center,
                                style: textStyle1,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5.0)),

                          //Answer 1
                          Container(
                            height:
                            MediaQuery.of(context).copyWith().size.height /
                                10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (1 ==
                                    snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor1 = colorRight;
                                  });
                                  quizScore += 3;
                                } else {
                                  setState(() {
                                    buttonColor1 = colorWrong;
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

                          //Answer 2
                          Container(
                            height:
                            MediaQuery.of(context).copyWith().size.height /
                                10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (2 ==
                                    snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor2 = colorRight;
                                  });
                                  quizScore += 3;
                                } else {
                                  setState(() {
                                    buttonColor2 = colorWrong;
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

                          //Answer 3
                          Container(
                            height:
                            MediaQuery.of(context).copyWith().size.height /
                                10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (3 ==
                                    snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor3 = colorRight;
                                  });
                                  quizScore += 3;
                                } else {
                                  setState(() {
                                    buttonColor3 = colorWrong;
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

                          //Answer 4
                          Container(
                            height:
                            MediaQuery.of(context).copyWith().size.height /
                                10,
                            child: ElevatedButton(
                              onPressed: () {
                                if (4 ==
                                    snapshot.data[questionNumber].answerID) {
                                  setState(() {
                                    buttonColor4 = colorRight;
                                  });
                                  quizScore += 3;
                                } else {
                                  setState(() {
                                    buttonColor4 = colorWrong;
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
    );
  }

  /// receives [idCurrentUser], [quizScore] and [topicID], updates question or leads to next screen, when quiz is finished
  void updateQuestion(int idCurrentUser, int quizScore, int topicID) {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        buttonColor1 = mainColorSD;
        buttonColor2 = mainColorSD;
        buttonColor3 = mainColorSD;
        buttonColor4 = mainColorSD;
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