import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/database/database_helper.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sd_quiz/screens/quiz/quiz_screen.dart';
import 'package:sd_quiz/screens/quiz_overview/quiz_overview_screen.dart';
import 'package:sd_quiz/screens/shared/constants.dart';
import 'package:sd_quiz/screens/shared/text_button_app_bar.dart';

class QuizPodiumScreen extends StatefulWidget {
  //variables
  int quizScore, totalQuizScore, idCurrentUser, topicID;

  //constructor
  QuizPodiumScreen(
      {Key key,
      @required this.idCurrentUser,
      @required this.quizScore,
      @required this.totalQuizScore,
      @required this.topicID})
      : super(key: key);

  @override
  _QuizPodiumScreenState createState() =>
      _QuizPodiumScreenState(idCurrentUser, quizScore, totalQuizScore, topicID);
}

class _QuizPodiumScreenState extends State<QuizPodiumScreen> {
  //variables
  int score, quizScore, totalQuizScore, idCurrentUser, topicID, percent;
  DatabaseHelper helper = DatabaseHelper();
  User user;
  Future userFuture;

  //constructor
  _QuizPodiumScreenState(
      this.idCurrentUser, this.quizScore, this.totalQuizScore, this.topicID);

  @override
  Widget build(BuildContext context) {
    percent = (quizScore * 100 ~/ totalQuizScore);
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColorSD,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'podium',
          style: textStyleAppBar,
        ).tr(),
        actions: [
          TextButtonAppBar(
              iconAppBar: Icons.home,
              title: 'Home',                                      //NEUER TEXT
              nextPage: QuizOverviewScreen(idCurrentUser: idCurrentUser)),
        ],
      ),


      body: SingleChildScrollView(
        child: Column(
          //gratulations
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

  //method to select trophy-image based on score
  String getTrophyImage(int percentage) {
    if (percentage < 80) {
      return 'assets/bronze.png';
    }
    if (percentage >= 80 && percentage < 90) {
      return 'assets/silber.png';
    } else {
      return 'assets/gold.png';
    }
  }
}
