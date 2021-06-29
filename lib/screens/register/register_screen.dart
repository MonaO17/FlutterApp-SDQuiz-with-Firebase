import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/database/database_helper.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:sd_quiz/screens/login/login_screen.dart';
import 'package:sd_quiz/screens/login/widget/input_text_field.dart';
import 'package:sd_quiz/screens/quiz_overview/quiz_overview_screen.dart';
import 'package:sd_quiz/screens/shared/constants.dart';
import 'package:sd_quiz/screens/shared/leading_text_button_app_bar.dart';
import 'package:sd_quiz/screens/shared/text_button_app_bar.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //variables
  DatabaseHelper helper = DatabaseHelper();
  int idCurrentUser;
  int counter = 0;
  User user;
  String name, pw, pw2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: mainColorSD,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'neu_anmelden',
          style: textStyleAppBar,
        ).tr(),
        leading: LeadingTextButtonAppBar(),
        actions: [
          TextButtonAppBar(
              iconAppBar: Icons.person,
              title: 'Login',
              nextPage: LoginScreen()),
        ],
      ),


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                'bitte_daten_eingeben',
                style: textStyle1,
              ).tr(),
            ),


            //input fields for name, pw & pw2
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
                  SizedBox(
                    height: 16,
                  ),
                  InputTextField(
                    label: 'passwort'.tr(),
                    password: true,
                    onChange: (value) {
                      pw = value;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
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
            SizedBox(
              height: 50,
            ),

            //Button to register
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FlatButton(
                shape: quizButtonShape,
                color: mainColorSD,
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

            //switch to login
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
                          color: mainColorSD,
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

  //method checks if password are longer then 4 digits and equal
  void _checkPassword(String name, String pw, String pw2, int counter) {
    if (pw != pw2) {
      _showAlertDialog('fehler'.tr(), 'fehler_pw'.tr());
      pw = null;
      pw2 = null;
    }
    if (pw.length < 4) {
      _showAlertDialog(
          'fehler'.tr(), 'fehler_zeichenlänge'.tr());
      pw = null;
      pw2 = null;
    } else {
      _addUserToDB(name, pw, counter);
    }
  }

  //method checks if user name already exists in db, if not it registers new user
  Future _addUserToDB(String name, String pw, int counter) async {
    bool userExistsAlready = await helper.userExistsAlreadyCheck(name);

    if (userExistsAlready == true) {
      _showAlertDialog('fehler'.tr(), 'fehler_name'.tr());
      name = null;
    } else {
      _showAlertDialog('willkommen_title'.tr(), 'willkommen_register'.tr());
      idCurrentUser = await helper.insertUser(name, pw, counter);
      await helper.getTopicFromGoogleSheet();
      await helper.getDataFromGoogleSheet();
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

  //method to print out error messages
  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
