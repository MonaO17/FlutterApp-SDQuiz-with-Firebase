import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/screens/login/widget/input_text_field.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  String name, pw, pw2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30,),
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
    );
  }


  void checkPassword(String pw, String pw2) {
    if (pw != pw2) {
      _showAlertDialog('Fehler!',
          'Ihre Passwörter stimmen nicht überein. Versuchen Sie es erneut.');

    } else {
      // Failure
      _showAlertDialog('Willkommen!',
          'Sie haben sich erfolgreich registriert. Viel Spaß beim spielen!');
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



