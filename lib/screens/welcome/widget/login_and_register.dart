import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sd_quiz/screens/login/login_screen.dart';
import 'package:sd_quiz/screens/register/register_screen.dart';

class LoginAndRegister extends StatelessWidget {
  const LoginAndRegister({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              color: Colors.teal[600],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  'login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ).tr(),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
                //side: BorderSide(color: Colors.teal[600] ),
              ),
              color: Colors.teal[600],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterScreen();
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(
                  'neu_anmelden',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ).tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
