import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/screens/login_screen.dart';
import 'package:flutter_login_register_ui/screens/register_screen.dart';

class AppHomeButtons extends StatefulWidget {
  const AppHomeButtons({Key? key}) : super(key: key);

  @override
  State<AppHomeButtons> createState() => _AppHomeButtonsState();
}

class _AppHomeButtonsState extends State<AppHomeButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 18),
                side: const BorderSide(color: Colors.transparent),
              ),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              ),
              child: const Text(
                'Sign in',
                style: TextStyle(
                  fontFamily: 'GeneralSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
