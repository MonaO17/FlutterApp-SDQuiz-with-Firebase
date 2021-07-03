import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sd_quiz/model/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/screens/login/widget/input_text_field.dart';
import 'package:sd_quiz/screens/quiz_overview/quiz_overview_screen.dart';
import 'package:sd_quiz/screens/register/register_screen.dart';
import 'package:sd_quiz/screens/shared/constants.dart';
import 'package:sd_quiz/screens/shared/leading_text_button_app_bar.dart';
import 'package:sd_quiz/screens/shared/text_button_app_bar.dart';
import '../../database/database_helper.dart';

/// LoginScreen is the screen the user sees when logging in
class LoginScreen extends StatefulWidget {

  /// calls _LoginScreenState
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

/// private class called by LoginScreen, can change state
class _LoginScreenState extends State<LoginScreen> {
  /// instance of  [DatabaseHelper]
  DatabaseHelper helper = DatabaseHelper();
  /// variables [name] for user name and [pw] for user passowrd
  var name, pw;
  /// identifies current user
  int idCurrentUser;
  /// user-object, later initialized with current user
  User user;

  /// builds screen with Scaffold-Widget, contains AppBar, two input-fields, login-button, link to register-screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: mainColorSD,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'login',
          style: textStyleAppBar,
        ).tr(),
        leading: LeadingTextButtonAppBar(),
        actions: [
          TextButtonAppBar(
              iconAppBar: Icons.person,
              title: 'Register',
              nextPage: RegisterScreen()),
        ],
      ),


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                'Willkommen',
                style: textStyle3,
              ).tr(),
            ),

            //Input fields for name & password
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
                      style: textStyleBody,
                    ).tr(),
                  ),
                  //Login Button
                  SizedBox(
                    height: 60,
                  ),

                  //Button to login
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: FlatButton(
                      shape: quizButtonShape,
                      color: mainColorSD,
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

            //switch to register
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
                          color: mainColorSD,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RegisterScreen();
                                },
                              ),
                            );
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

  /// checks whether user data is correct. If not it gives back an error-message, if yes the user gets logged in
  Future _loginCheck(String name, String pw) async {
    idCurrentUser = await helper.userExistsCheck(name, pw);

    if (idCurrentUser == null) {
      _showAlertDialog('fehler'.tr(), 'fehler_nachricht'.tr());
      name = null;
      pw = null;
    } else {
      _showAlertDialog('willkommen_title'.tr(), 'willkommen_nachricht'.tr());
      print(idCurrentUser);
      await helper.getTopicFromGoogleSheet();
      await helper.getDataFromGoogleSheet();
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

  /// prints out error messages
  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
