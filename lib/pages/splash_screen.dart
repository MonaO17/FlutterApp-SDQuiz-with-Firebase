import 'package:flutter/material.dart';
import 'package:sd_quiz/pages/welcome/welcome_screen.dart';



//Logo Screen, zeigt ein Logo ein paar Sekunden lang, leitet dann zum HomeScreen (WillkomenScreen) weiter

class SplashScreen extends StatefulWidget {
  @override
  __SplashScreenState createState() => __SplashScreenState();
}

class __SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var d = Duration(seconds:2);
    //delayed 2 seconds to do next page
    Future.delayed(d,(){
      //to next page and close this page
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context){
            return WelcomeScreen();
            },
          ),
              (route) => false,
      );
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('https://cdn.pixabay.com/photo/2020/03/21/14/45/rocket-4954229_1280.jpg'),
          ),
        ),
      ),
    );
  }
}



