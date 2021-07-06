import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/database/database_helper.dart';
import 'package:sd_quiz/screens/quiz/quiz_screen.dart';
import 'package:sd_quiz/screens/quiz_overview/quiz_overview_screen.dart';
import 'package:sd_quiz/screens/shared/constants.dart';
import 'package:sd_quiz/screens/shared/text_button_app_bar.dart';

/// Screen that is shown in the end of the quiz
class QuizEndScreen extends StatefulWidget {
  int quizScore, totalQuizScore, idCurrentUser, topicID;

  /// constructor QuizPodiumScreen
  QuizEndScreen(
      {Key key,
      @required this.idCurrentUser,
      @required this.quizScore,
      @required this.totalQuizScore,
      @required this.topicID})
      : super(key: key);

  /// calls _QuizPodiumScreenState, hands over variables
  @override
  _QuizEndScreenState createState() =>
      _QuizEndScreenState(idCurrentUser, quizScore, totalQuizScore, topicID);
}

/// private class called by QuizPodiumScreen, can change state
class _QuizEndScreenState extends State<QuizEndScreen> {
  int score, quizScore, totalQuizScore, idCurrentUser, topicID, percent;
  DatabaseHelper helper = DatabaseHelper();

  /// constructor _QuizPodiumScreenState
  _QuizEndScreenState(
      this.idCurrentUser, this.quizScore, this.totalQuizScore, this.topicID);

  /// initState is called first, calls method [_update Score]
  @override
  void initState() {
    super.initState();
    _updateScore(idCurrentUser, quizScore);
  }

  /// updates score of user in database
  _updateScore(idCurrentUser, quizScore) async {
    await helper.updateScore(idCurrentUser, quizScore);
  }

  /// builds screen with Scaffold-Widget, contains appBar, text, picture, score, 2 buttons
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
          'Quiz Ende',
          style: textStyleAppBar,
        ),
        actions: [
          TextButtonAppBar(
              iconAppBar: Icons.home,
              title: 'Home',
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
                child: Text(getText(percent),
                  style: textStyle1,
                ),
              ),
            ),
            Image(image: AssetImage(getTrophyImage(percent)), width: 210.0, height: 210.0),
            SizedBox(height: 10),

            //score
            Padding(
              padding: const EdgeInsets.all(20.0),
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

  /// selects trophy-image based on score
  String getTrophyImage(int percentage) {
    if(percentage < 70) {
      return 'assets/thumbsUp.jpg';
    } else if (percentage > 70 && percentage < 80) {
      return 'assets/bronze.png';
    } else if (percentage >= 80 && percentage < 90) {
      return 'assets/silber.png';
    } else {
      return 'assets/gold.png';
    }
  }

  String getText(int percentage) {
    if(percentage < 70) {
      return 'Vielen Dank fürs Spielen';
    } else if (percentage > 70 && percentage < 80) {
      return 'Herzlichen Glückwunsch! Sie haben eine Bronze-Medaille gewonnen!!!';
    } else if (percentage >= 80 && percentage < 90) {
      return 'Herzlichen Glückwunsch! Sie haben eine Silber-Medaille gewonnen!!!';
    } else {
      return 'Herzlichen Glückwunsch! Sie haben eine Gold-Medaille gewonnen!!!';
    }
  }
}
