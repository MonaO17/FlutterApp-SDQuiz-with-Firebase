import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/view/welcome/widget/login_and_register.dart';
import 'package:sd_quiz/view/welcome/widget/slider.dot.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/quiz.jpg'),
          SliderDot(),
          SizedBox(height: 20,),
           Text('willkommensText',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal[900],
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
            ),
           ).tr(),
          SizedBox(height: 190,),
          LoginAndRegister(),
            ],
          ),
    );
  }
}

