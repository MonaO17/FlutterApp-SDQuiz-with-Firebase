import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Question_four extends StatefulWidget {
  @override
  _Question_fourState createState() => _Question_fourState();
}

class _Question_fourState extends State<Question_four> {
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
                  child: Image(
                    //borderRadius: BorderRadius.circular(20),
                    image: AssetImage('assets/Frage1.JPG'),
                    width: 350,
                    height:250,
                    //fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height:20.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Answer 1'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff004445),
                  padding: EdgeInsets.symmetric(horizontal:50, vertical:20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              SizedBox(height:6.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Answer 2'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff004445),
                  padding: EdgeInsets.symmetric(horizontal:50, vertical:20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              SizedBox(height:6.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Answer 3'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff004445),
                  padding: EdgeInsets.symmetric(horizontal:50, vertical:20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              SizedBox(height:6.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Answer 4'),
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
        ),
      ),
    );
  }
}

