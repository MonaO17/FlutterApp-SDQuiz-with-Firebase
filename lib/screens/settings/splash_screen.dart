/* code partly inspired by
       - https://www.youtube.com/watch?v=RNQ1meh9k48
*/
import 'package:flutter/material.dart';
import 'package:sd_quiz/screens/welcome/welcome_screen.dart';

/// SplashScreen shows the logo while starting the app
class SplashScreen extends StatefulWidget {

  /// calls __SplashScreenState
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// private class called by _SplashScreenState, can change state
class _SplashScreenState extends State<SplashScreen> {

  //is called first, sets duration the logo is shown and sets next page
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

  /// builds screen with Scaffold-Widget, contains logo
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



