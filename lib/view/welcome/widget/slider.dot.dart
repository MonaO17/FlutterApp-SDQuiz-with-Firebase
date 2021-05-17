import 'package:flutter/material.dart';

//vielleicht raus nehmen?


class SliderDot extends StatelessWidget {
  const SliderDot({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 6,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.teal[900],
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 6,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.teal[900].withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 6,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.teal[900].withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }
}
