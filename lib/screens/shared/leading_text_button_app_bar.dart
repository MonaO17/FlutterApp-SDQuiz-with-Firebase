import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// defines "Back-Button" on the left side of AppBar
class LeadingTextButtonAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
