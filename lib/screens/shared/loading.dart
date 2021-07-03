import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'constants.dart';

/// defines loading screen
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColorSD,
      child: Center(
        child: SpinKitFadingCircle(
          color: colorThree,
          size: 50.0,
        ),
      ),
    );
  }
}
