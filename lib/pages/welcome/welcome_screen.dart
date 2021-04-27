import 'package:flutter/material.dart';
import 'package:sd_quiz/pages/welcome/widget/login_and_register.dart';
import 'package:sd_quiz/pages/welcome/widget/slider.dot.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/quiz.jpg'),
          SliderDot(),
          SizedBox(height: 20,),
           Text('Willkommen bei der It Quiz App\ndie Spaß macht\n& kostenfrei für Sie nutzbar ist! ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal[900],
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
            ),
           ),
          SizedBox(height: 190,),
          LoginAndRegister(),
            ],
          ),
    );
  }
}

