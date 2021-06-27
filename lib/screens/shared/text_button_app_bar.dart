import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextButtonAppBar extends StatelessWidget {
  final iconAppBar;
  final String title;
  final nextPage;

  const TextButtonAppBar({Key key, this.iconAppBar, this.title, this.nextPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(iconAppBar, color: Colors.white),
      label: Text(
        '$title',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => nextPage));
      },
    );
  }
}
