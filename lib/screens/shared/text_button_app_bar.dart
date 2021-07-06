import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

/// defines Buttons on right side of AppBar
class TextButtonAppBar extends StatelessWidget {
  final iconAppBar;
  final String title;
  final nextPage;

  /// constructor TextButtonAppBar
  const TextButtonAppBar({Key key, this.iconAppBar, this.title, this.nextPage})
      : super(key: key);

  /// builds TextButton.icon with received variables
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(iconAppBar, color: Colors.white),
      label: Text(
        '$title',
        style: TextStyle(
          color: Colors.white,
          fontFamily: fontStyleSD,
        ),
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => nextPage));
      },
    );
  }
}
