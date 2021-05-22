import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/database/database_helper.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sd_quiz/screens/quiz/quiz_screen.dart';
import 'package:sd_quiz/screens/quiz_overview/quiz_overview_screen.dart';

class QuizPodiumScreen extends StatefulWidget {
  //variables
  int quizScore, idCurrentUser, topicID;

  //constructor
  QuizPodiumScreen(
      {Key key, @required this.idCurrentUser, @required this.quizScore, @required this.topicID}): super(key: key);

  @override
  _QuizPodiumScreenState createState() => _QuizPodiumScreenState(idCurrentUser, quizScore, topicID);
}

class _QuizPodiumScreenState extends State<QuizPodiumScreen> {
  //variables
  int score, quizScore, idCurrentUser, topicID;
  DatabaseHelper helper = DatabaseHelper();
  User user;
  Future userFuture;

  //constructor
  _QuizPodiumScreenState(this.idCurrentUser, this.quizScore, this.topicID);

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
    return WillPopScope(
      onWillPop: () async => false,
      //disabel the back button, otherwise user could go back to questions to increase their score
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[800],
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Podium',
            style: TextStyle(
              color: Colors.white,
            ),
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
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.red[900],
                            fontWeight: FontWeight.w800,
                          ),
                        ).tr(),
                      ),
                    ),
                    Image(image: AssetImage('assets/gold.png')),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(
                        child: Text(
                          '${snapshot.data.counter} Punkte!!!',
                          // hier noch Variablen einsetzen
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red[900],
                            fontWeight: FontWeight.w800,
                          ),
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
}
