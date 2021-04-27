import 'package:flutter/material.dart';



class WelcomeBack extends StatelessWidget {

  const WelcomeBack({
    Key key,
  }) : super(key: key);


@override
Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
    child: Text(
      'Willkommen',
      style: TextStyle(
        color: Colors.teal[900],
        fontSize: 32,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
}
