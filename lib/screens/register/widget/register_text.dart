import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/screens/shared/constants.dart';

class RegisterText extends StatelessWidget {
  const RegisterText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Text(
        'bitte_daten_eingeben',
        style: textStyle1,
      ).tr(),
    );
  }
}
