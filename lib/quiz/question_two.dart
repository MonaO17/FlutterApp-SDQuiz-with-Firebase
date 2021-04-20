import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Question_two extends StatefulWidget {
  @override
  _Question_twoState createState() => _Question_twoState();
}

class _Question_twoState extends State<Question_two> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(),
      appBar: AppBar(
        title: Text('Quiz Social Media'),
        centerTitle: true,
        backgroundColor: Color(0xff004445),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage('assets/Frage1.JPG'),
                    //width: 350,
                    height:250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height:20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Wahr'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff004445),
                      padding: EdgeInsets.symmetric(horizontal:50, vertical:20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  ),
                  SizedBox(width:20.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Falsch'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff004445),
                      padding: EdgeInsets.symmetric(horizontal:50, vertical:20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

