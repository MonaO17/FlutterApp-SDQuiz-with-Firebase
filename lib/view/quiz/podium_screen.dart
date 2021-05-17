import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/view/quiz_overview/quiz_overview_screen.dart';

// Screen für die Anzeige der Pokale + 2 Buttons
// Funktion für die Ausgabe der Punkte noch implementieren

class QuizPodiumScreen extends StatelessWidget {
  int finalScore;

  //constructor
  QuizPodiumScreen({Key key, @required this.finalScore}) : super(key: key);

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
        body: Column(
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
                  '$finalScore Punkte!!!', // hier noch Variablen einsetzen
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
                        return QuizOverview();
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
                        return QuizOverview(); //
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
