import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/database/database_helper.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sd_quiz/view/quiz/quiz_screen.dart';
import 'package:sd_quiz/view/quiz_overview/quiz_overview_screen.dart';

// Screen für jedes Quiz am Ende zeigt die Punkteanzahl an und 2 Buttons
// Funktion für die Ausgabe der Punkte noch implementieren

class QuizEndScreen extends StatefulWidget {
  //variables
  int quizScore, idCurrentUser, topicID;

  //constructor
  QuizEndScreen(
      {Key key, @required this.idCurrentUser, @required this.quizScore, @required this.topicID}) : super(key: key);

  @override
  _QuizEndScreenState createState() => _QuizEndScreenState(idCurrentUser, quizScore, topicID);
}

class _QuizEndScreenState extends State<QuizEndScreen> {
  //variables
  int score, quizScore, idCurrentUser, topicID;
  DatabaseHelper helper = DatabaseHelper();
  User user;
  Future userFuture;

  //constructor
  _QuizEndScreenState(this.idCurrentUser, this.quizScore, this.topicID);

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'meine_Seite',
          style: TextStyle(
            color: Colors.white,
          ),
        ).tr(),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                    padding: const EdgeInsets.all(60.0),
                    child: Center(
                      child: Text(
                        'danke_spiel',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.red[900],
                          fontWeight: FontWeight.w800,
                        ),
                      ).tr(),
                    ),
                  ),
                  SizedBox(height: 80),
                  Center(
                    child: Text(
                      'Quizpunkte: $quizScore',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ).tr(),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Gesamtpunkte: ${snapshot.data.counter}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ).tr(),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Center(
                      child: Text(
                        '5 von 10 Richtig', // hier noch Variablen einsetzen
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
    );
  }
}
