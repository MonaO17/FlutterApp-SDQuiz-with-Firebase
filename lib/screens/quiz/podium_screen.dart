import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/database/database_helper.dart';
import 'package:sd_quiz/screens/quiz/quiz_screen.dart';
import 'package:sd_quiz/screens/quiz_overview/quiz_overview_screen.dart';
import 'package:sd_quiz/screens/shared/constants.dart';
import 'package:sd_quiz/screens/shared/text_button_app_bar.dart';

/// Screen that is shown in the end of the quiz, when quiz was won
class QuizPodiumScreen extends StatefulWidget {
  /// [quizScore] is the score reached by the user, [totalQuizScore] is the total score, that could have been reached,
  /// [idCurrentUser] identifies current user, [topicID] defines the quiz-topic
  int quizScore, totalQuizScore, idCurrentUser, topicID;

  /// constructor QuizPodiumScreen
  QuizPodiumScreen(
      {Key key,
      @required this.idCurrentUser,
      @required this.quizScore,
      @required this.totalQuizScore,
      @required this.topicID})
      : super(key: key);

  /// calls _QuizPodiumScreenState, hands over variables
  @override
  _QuizPodiumScreenState createState() =>
      _QuizPodiumScreenState(idCurrentUser, quizScore, totalQuizScore, topicID);
}

/// private class called by QuizPodiumScreen, can change state
class _QuizPodiumScreenState extends State<QuizPodiumScreen> {
  /// [score] is the total score of user, [quizScore] is the score reached by the user, [totalQuizScore] is the total score, that could have been reached,
  /// [idCurrentUser] identifies current user, [topicID] defines the quiz-topic, [percent] defines percentage of correctly answered questions
  int score, quizScore, totalQuizScore, idCurrentUser, topicID, percent;
  /// instance of [DatabaseHelper]
  DatabaseHelper helper = DatabaseHelper();

  /// constructor _QuizPodiumScreenState
  _QuizPodiumScreenState(
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

  /// selects trophy-image based on score
  String getTrophyImage(int percentage) {
    if (percentage < 80) {
      return 'assets/bronze.png';
    } if (percentage >= 80 && percentage < 90) {
      return 'assets/silber.png';
    } else {
      return 'assets/gold.png';
    }
  }
}
