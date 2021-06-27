import 'package:avg_media/Widgets/lineButton.dart';
import 'package:avg_media/globals.dart';
import 'package:avg_media/services/authenticationServices.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: deviceWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/assemble.jpg'),
            SizedBox(
              height: 20,
            ),
            TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/google_logo.png',
                    height: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                AuthenticationServices().googleSignIn(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
