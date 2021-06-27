import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/database/database_helper.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sd_quiz/screens/quiz/quiz_screen.dart';
import 'package:sd_quiz/screens/quiz_overview/quiz_overview_screen.dart';
import 'package:sd_quiz/screens/shared/constants.dart';

class QuizPodiumScreen extends StatefulWidget {
  //variables
  int quizScore, totalQuizScore, idCurrentUser, topicID;

  //constructor
  QuizPodiumScreen(
      {Key key, @required this.idCurrentUser, @required this.quizScore, @required this.totalQuizScore, @required this.topicID}): super(key: key);

  @override
  _QuizPodiumScreenState createState() => _QuizPodiumScreenState(idCurrentUser, quizScore, totalQuizScore, topicID);
}

class _QuizPodiumScreenState extends State<QuizPodiumScreen> {
  //variables
  int score, quizScore, totalQuizScore, idCurrentUser, topicID, percent;
  DatabaseHelper helper = DatabaseHelper();
  User user;
  Future userFuture;

  //constructor
  _QuizPodiumScreenState(this.idCurrentUser, this.quizScore, this.totalQuizScore, this.topicID);

  @override
  void initState() {
    super.initState();
    userFuture = _updateScore(idCurrentUser, quizScore);
  }

  _updateScore(idCurrentUser, quizScore) async {
    score = await helper.updateScore(idCurrentUser, quizScore);
    print(score);
    user = await _getUser(idCurrentUser);
    return user;
  }

  _getUser(idCurrentUser) async {
    print('user $idCurrentUser');
    user = await helper.getCurrentUser(idCurrentUser);
    print(user.name);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    percent = ( quizScore *100/ totalQuizScore ).toInt();

    return WillPopScope(
      onWillPop: () async => false,
      //disabel the back button, otherwise user could go back to questions to increase their score
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[800],
          elevation: 0,
          centerTitle: true,
          title: Text(
            'podium',
            style: textAppBar,
          ).tr(),
        ),
        body: FutureBuilder(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(
                        child: Text(
                          'herzlichen',
                          style: textStyle1,
                        ).tr(),
                      ),
                    ),
                    Image(image: AssetImage(getTrophyImage(percent))),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(
                        child: Text(
                          '${(quizScore/3).toInt()} von ${(totalQuizScore/3).toInt()} Richtige! \n\n'
                              '      ${quizScore} Punkte!!!',
                          style: textStyle1
                        ).tr(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        color: Colors.teal[700],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return QuizScreen(topicID: topicID, idCurrentUser: idCurrentUser); // Quizseite verlinken
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          child: Text(
                            'nochmal_spielen',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ).tr(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        color: Colors.teal[700],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return QuizOverviewScreen(
                                    idCurrentUser: idCurrentUser); //
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          child: Text(
                            'quiz_uebersicht',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ).tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  String getTrophyImage(int percentage){
    if(percentage<80){
      return 'assets/bronze.png';
    }
    if(percentage>=80 && percentage<90){
      return 'assets/silber.png';
    }
    else {
      return 'assets/gold.png';
    }
  }
}
