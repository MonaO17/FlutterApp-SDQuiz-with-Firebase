import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('sprache', style: TextStyle(
          color: Colors.teal[900],
        ),
        ).tr(),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.teal[900],
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
