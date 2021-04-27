import 'package:flutter/material.dart';
import 'package:sd_quiz/pages/login/widget/input_text_field.dart';


//Logik Textfelder hier DB Verknüpfung

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30,),
      child: Column(
        children: [
          InputTextField(
            label: 'Spielername',
            onChange: (value) {},
          ),
          SizedBox(height: 16,),
          InputTextField(
            label: 'Passwort',
            password: true,
            onChange: (value) {},
          ),
        ],
      ),
    );
  }
}
