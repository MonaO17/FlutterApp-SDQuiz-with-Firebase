import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/view/login/widget/input_text_field.dart';
import 'package:sd_quiz/view/quiz_overview/quiz_overview_screen.dart';
import '../../database/database_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DatabaseHelper helper = DatabaseHelper();
  var name, pw;
  int idCurrentUser;
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'login',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                'Willkommen',
                style: TextStyle(
                  color: Colors.teal[900],
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ).tr(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              child: Column(
                children: [
                  InputTextField(
                    label: 'Spielername',
                    onChange: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InputTextField(
                    label: 'Passwort',
                    password: true,
                    onChange: (value) {
                      pw = value;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'passwort_vergessen',
                      style: TextStyle(color: Colors.teal[800]),
                    ).tr(),
                  ),
                  //Login Button
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                      color: Colors.teal[700],
                      onPressed: () async {
                        await _loginCheck(name, pw);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Passwort Vergessen
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(text: 'keinen_account'.tr()),
                    TextSpan(
                        text: 'neu_anmelden'.tr(),
                        style: TextStyle(
                          color: Colors.teal[900],
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _loginCheck(String name, String pw) async{
    int idCurrentUser = await helper.userExistsCheck(name, pw);

    if (idCurrentUser == null) {
      _showAlertDialog('Fehler!',
          'Spielername oder Passwort ist falsch!');
          name = null;
          pw = null;
    } else {
      _showAlertDialog('Willkommen!',
          'Sie haben sich erfolgreich eingeloggt. Viel Spaß beim spielen!');
      print(idCurrentUser);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return QuizOverview(idCurrentUser: idCurrentUser);
          },
        ),
      );
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

}
