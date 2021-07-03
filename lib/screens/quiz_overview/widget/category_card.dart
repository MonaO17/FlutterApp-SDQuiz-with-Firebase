/* code partly inspired by
       - https://www.youtube.com/watch?v=NEiy6-XWO8o
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sd_quiz/screens/shared/constants.dart';

/// CategoryCard is the template, that is used to display the single topics
class CategoryCard extends StatelessWidget {
  /// image above the topic
  final String image;
  /// topic name
  final String title;
  /// function press, reacts to being pressed
  final Function press;

  /// constructor CategoryCard
  const CategoryCard({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  /// builds customized CategoryCard
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
