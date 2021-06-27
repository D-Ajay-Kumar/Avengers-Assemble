import 'package:avg_media/UI/authenticationScreen.dart';
import 'package:avg_media/UI/createPostScreen.dart';
import 'package:avg_media/UI/editProfileScreen.dart';
import 'package:avg_media/UI/index.dart';
import 'package:avg_media/UI/navigatorScreen.dart';
import 'package:avg_media/UI/profileScreen.dart';
import 'package:avg_media/providers/authProvider.dart';
import 'package:avg_media/providers/postsProvider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Restricts rotation of screen
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    DevicePreview(
      // to check the UI on different devices make enabled true
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PostsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
        ),
        home: NavigatorScreen(),
        routes: {
          CreatePostScreen.routeName: (context) => CreatePostScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          EditProfileScreen.routeName: (context) => EditProfileScreen(),
        },
      ),
    );
  }
}
