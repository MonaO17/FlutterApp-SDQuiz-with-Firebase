import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/screens/welcome/widget/login_and_register.dart';
import 'package:sd_quiz/screens/welcome/widget/slider.dot.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/quiz.jpg'),
            ),
            SliderDot(),
            SizedBox(height: 10,),
             Text('willkommensText',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.teal[900],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
              ),
             ).tr(),
            SizedBox(height: 10,),
            LoginAndRegister(),
              ],
            ),
      ),
    );
  }
}

