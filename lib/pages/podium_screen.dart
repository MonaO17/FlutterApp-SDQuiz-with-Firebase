import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/pages/quiz_overview/quiz_overview_screen.dart';

// Screen für die Anzeige der Pokale + 2 Buttons
// Funktion für die Ausgabe der Punkte noch implementieren

class QuizPodiumScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        elevation: 0,
        centerTitle: true,
        title: Text('podium', style: TextStyle(
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
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: Center(
              child: Text(
                'herzlichen' ,
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.red[900],
                  fontWeight: FontWeight.w800,),
              ).tr(),
            ),
          ),

          Image(image: AssetImage('assets/gold.png')),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: Center(
              child: Text(
                '5 von 10 Richtig' , // hier noch Variablen einsetzen
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red[900],
                  fontWeight: FontWeight.w800,),
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
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context){
                    return QuizOverviewScreen(); // Quizseite verlinken
                  },),);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                child: Text('nochmal_spielen',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ).tr(),
              ),
            ),
          ),Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              color: Colors.teal[700],
              onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context){
                    return QuizOverviewScreen(); //
                  },),);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                child: Text('quiz_uebersicht',
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
  }
}
