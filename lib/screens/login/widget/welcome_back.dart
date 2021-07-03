import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/screens/shared/constants.dart';

/// Welcome text
class WelcomeBack extends StatelessWidget {
  const WelcomeBack({
    Key key,
  }) : super(key: key);

  // builds welcome text
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Text(
        'willkommen',
        style: textStyle3,
      ).tr(),
    );
  }
}
