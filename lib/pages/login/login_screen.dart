import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sd_quiz/pages/login/widget/login_button.dart';
import 'package:sd_quiz/pages/login/widget/login_form.dart';
import 'package:sd_quiz/pages/login/widget/welcome_back.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeBack(),
          LoginForm(),
          // Passwort Vergessen
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: Text('Passwort Vergessen?',
              style: TextStyle(color: Colors.teal[800]),
            ),
          ),
          //Login Button
          SizedBox(height: 60,),
          LoginButton(),
          //Keinen Account/ Register
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan( text: 'Keinen Account?  '),
                  TextSpan(
                    text: 'Neu Anmelden', style: TextStyle(
                    color: Colors.teal[900],
                  ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.pop(context);
                    }
                  ),
              ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber[50],
      elevation: 0,
      centerTitle: true,
      title: Text('Login', style: TextStyle(
        color: Colors.teal[900],
      ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.teal[900],
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

