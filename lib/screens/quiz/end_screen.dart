import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/database/database_helper.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sd_quiz/screens/quiz/quiz_screen.dart';
import 'package:sd_quiz/screens/quiz_overview/quiz_overview_screen.dart';
import 'package:sd_quiz/screens/shared/constants.dart';
import 'package:sd_quiz/screens/shared/text_button_app_bar.dart';

class QuizEndScreen extends StatefulWidget {
  //variables
  int quizScore, totalQuizScore, idCurrentUser, topicID;

  //constructor
  QuizEndScreen(
      {Key key,
      @required this.idCurrentUser,
      @required this.quizScore,
      @required this.totalQuizScore,
      @required this.topicID})
      : super(key: key);

  @override
  _QuizEndScreenState createState() =>
      _QuizEndScreenState(idCurrentUser, quizScore, totalQuizScore, topicID);
}

class _QuizEndScreenState extends State<QuizEndScreen> {
  //variables
  int score, quizScore, totalQuizScore, idCurrentUser, topicID, percent;
  DatabaseHelper helper = DatabaseHelper();
  User user;
  Future userFuture;

  //constructor
  _QuizEndScreenState(
      this.idCurrentUser, this.quizScore, this.totalQuizScore, this.topicID);

  @override
  void initState() {
    super.initState();
    _updateScore(idCurrentUser, quizScore);
  }

  //updates score in db
  _updateScore(idCurrentUser, quizScore) async {
    await helper.updateScore(idCurrentUser, quizScore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColorSD,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'meine_Seite',
          style: textStyleAppBar,
        ).tr(),
        actions: [
          TextButtonAppBar(
              iconAppBar: Icons.home,
              title: 'Home',
              nextPage: QuizOverviewScreen(idCurrentUser: idCurrentUser)),
        ],
      ),


      body: SingleChildScrollView(
        child: Column(

          //congratulations
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Text(
                  'danke_spiel',
                  style: textStyle1,
                ).tr(),
              ),
            ),
            Image(image: AssetImage('assets/thumbsUp.jpg'), width: 200.0, height: 200.0,),
            SizedBox(height: 10),

            //score
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Text(
                        '${quizScore ~/ 3} von ${totalQuizScore ~/ 3} Richtige! \n\n'
                        '      $quizScore Punkte!!!',
                        style: textStyle1)
                    .tr(),
              ),
            ),

            //button to play again
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FlatButton(
                shape: quizButtonShape,
                color: mainColorSD,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return QuizScreen(
                            topicID: topicID,
                            idCurrentUser:
                                idCurrentUser); // Quizseite verlinken
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

            //button to go back to quiz overview screen
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FlatButton(
                shape: quizButtonShape,
                color: mainColorSD,
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
      ),
    );
  }
}
