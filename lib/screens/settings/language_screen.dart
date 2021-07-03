/* Inspiration & Tutorials für dieses File:
       - https://www.youtube.com/watch?v=7CHeU1DstoQ

*/


import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// LanguageScreen is the screen where the user can change the language
class LanguageScreen extends StatelessWidget {

  /// builds screen with Scaffold-Widget, contains AppBar, text, two icons with language
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        elevation: 0,
        centerTitle: true,
        title: Text('sprache', style: TextStyle(
          color: Colors.white,
        ),
        ).tr(),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'bitte_sprache',
                style: TextStyle(fontSize: 20),
              ).tr(),
            ),
          ),
          SizedBox(height: 80),
          Center(
            child: Text(
              'deutsch',
              style: TextStyle(fontSize: 20),
            ).tr(),
          ),
          SizedBox(height: 20),

          IconButton(
          icon: new Image.asset('assets/icons/de.png'),
          iconSize: 50,
          onPressed: () {
            context.locale = Locale('de', 'DE');
          },
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'englisch',
              style: TextStyle(fontSize: 20),
            ).tr(),
          ),
          SizedBox(height: 20),
          IconButton(
            icon: new Image.asset('assets/icons/en.png'),
            iconSize: 50,
            onPressed: () {
              context.locale = Locale('en', 'US');
            },
          ),

        ],
      ),
    );





  }
}
