import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/database/database_helper.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sd_quiz/view/login/login_screen.dart';
import 'package:sd_quiz/view/login/widget/input_text_field.dart';
import 'package:sd_quiz/view/quiz_overview/quiz_overview_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  DatabaseHelper helper = DatabaseHelper();
  int idCurrentUser;
  int counter = 0;
  User user;
  String name, pw, pw2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'neu_anmelden',
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
          children: [
            SizedBox(height: 20,),
           Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Text(
                  'bitte_daten_eingeben',
                  style: TextStyle(
                    color: Colors.teal[900],
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  InputTextField(
                    label: 'Spielername',
                    onChange: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(height: 16,),
                  InputTextField(
                    label: 'passwort'.tr(),
                    password: true,
                    onChange: (value) {
                      pw = value;
                    },
                  ),
                  SizedBox(height: 16,),
                  InputTextField(
                    label: 'passwort_wdh'.tr(),
                    password: true,
                    onChange: (value) {
                      pw2 = value;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 50,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
                color: Colors.teal[700],
                onPressed: () {
                  _checkPassword(name, pw, pw2, counter);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    'login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ).tr(),
                ),
              ),
            ),
            //Keinen Account/ Register
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(text: 'schon_einen_account'.tr()),
                    TextSpan(
                        text: 'hier_einloggen'.tr(),
                        style: TextStyle(
                          color: Colors.teal[900],
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen(); // Quizseite verlinken
                                },
                              ),
                            );
                          }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkPassword(String name, String pw, String pw2, int counter) {
    if (pw != pw2) {
      _showAlertDialog('Fehler!',
          'Ihre Passwörter stimmen nicht überein. Versuchen Sie es erneut.');
      pw = null;
      pw2 = null;
    } else {
      _addUserToDB(name, pw, counter);
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  Future _addUserToDB(String name, String pw, int counter) async {
    bool userExistsAlready = await helper.userExistsAlreadyCheck(name);

    if (userExistsAlready == true) {
      _showAlertDialog('Fehler!',
          'Ihr Spielername ist bereits vergeben. Wählen Sie bitte einen anderen!');
      name = null;
    } else {
      _showAlertDialog('Willkommen!',
          'Sie haben sich erfolgreich registriert. Viel Spaß beim spielen!');
      idCurrentUser = await helper.insertUser(name, pw, counter);
      print(idCurrentUser);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return QuizOverviewScreen(idCurrentUser: idCurrentUser);
          },
        ),
      );
    }
  }
}
