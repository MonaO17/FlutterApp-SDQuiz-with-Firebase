import 'package:flutter/material.dart';



class RegisterText extends StatelessWidget {
  const RegisterText({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
      child: Text(
        'Bitte geben Sie Ihre Daten ein',
        style: TextStyle(
          color: Colors.teal[900],
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}