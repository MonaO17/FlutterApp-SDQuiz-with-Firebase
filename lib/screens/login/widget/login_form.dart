import 'package:flutter/material.dart';
import 'input_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 30,
      ),
      child: Column(
        children: [
          InputTextField(
            label: 'spielername',
            onChange: (value) {},
          ),
          SizedBox(
            height: 16,
          ),
          InputTextField(
            label: 'passwort',
            password: true,
            onChange: (value) {},
          ),
        ],
      ),
    );
  }
}
