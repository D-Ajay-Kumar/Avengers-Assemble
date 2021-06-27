import 'package:avg_media/UI/authenticationScreen.dart';
import 'package:avg_media/UI/editProfileScreen.dart';
import 'package:avg_media/UI/index.dart';
import 'package:avg_media/globals.dart';
import 'package:avg_media/models/appUser.dart';
import 'package:avg_media/providers/authProvider.dart';
import 'package:avg_media/services/authenticationServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  Future signIn;

  @override
  void initState() {
    super.initState();

    signIn = AuthenticationServices().silentSignIn(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    deviceHeight = size.height;
    deviceWidth = size.width;

    return FutureBuilder(
      future: signIn,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<AuthProvider>(
            builder: (_, authProvider, child) {
              AppUser appUser = authProvider.getAppUser;
              if (appUser == null) {
                return AuthenticationScreen();
              }
              return Index();
            },
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.pinkAccent,
            ),
          ),
        );
      },
    );
  }
}
