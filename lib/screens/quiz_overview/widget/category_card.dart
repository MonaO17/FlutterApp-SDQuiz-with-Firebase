import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sd_quiz/screens/shared/constants.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final Function press;

  const CategoryCard({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Spacer(),
                  Expanded(
                    child: Image.network(image),
                    flex: 6,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: textStyle2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
