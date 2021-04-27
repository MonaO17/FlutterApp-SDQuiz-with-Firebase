import 'package:flutter/material.dart';
import 'package:sd_quiz/pages/quiz_overview/quiz_overview_screen.dart';


class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    return QuizOverviewScreen(); // hier muss die Startseite mit den QuizKategorien rein
    },),);
    },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Text('Login',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

