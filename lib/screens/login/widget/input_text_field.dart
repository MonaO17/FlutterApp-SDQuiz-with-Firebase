/* code partly inspired by
       - https://www.youtube.com/watch?v=RNQ1meh9k48
*/
import 'package:flutter/material.dart';
import 'package:sd_quiz/screens/shared/constants.dart';

/// defines input text fields for login screen
class InputTextField extends StatelessWidget {

  /// constructor InputTextField
  const InputTextField({
    Key key,
    this.label,
    this.onChange,
    this.password = false,
  }) : super(key: key);

  final String label;
  final Function onChange;
  final bool password;

  /// builds customized TextField
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      obscureText: password,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
          color: mainColorSD,
          width: 2,
        )),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: mainColorSD,
            width: 2,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}
