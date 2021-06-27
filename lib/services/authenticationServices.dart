import 'package:avg_media/models/appUser.dart';
import 'package:avg_media/providers/authProvider.dart';
import 'package:avg_media/services/firestoreServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthenticationServices {
  // used to sign in and sign out user
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // gives current user and the user after logging in
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> silentSignIn(BuildContext context) async {
    // gives true if user is signed in
    if (await _googleSignIn.isSignedIn()) {
      final User user = _firebaseAuth.currentUser;

      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('USERS')
          .doc(user.uid)
          .get();

      AppUser appUser = AppUser.fromJson(documentSnapshot.data());

      final AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      authProvider.setAppUser = appUser;
      return;
    }

    // if the user is not logged in then send them to Login Screen
    return;
  }

  Future<void> googleSignIn({@required BuildContext context}) async {
    // logging user in

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    // google account user after successfully logging in
    final User firebaseUser =
        (await _firebaseAuth.signInWithCredential(authCredential)).user;

    // check whether it's the first time logging in or not

    AppUser appUser;

    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(firebaseUser.uid)
        .get();

    if (documentSnapshot.exists) {
      appUser = AppUser.fromJson(documentSnapshot.data());
    } else {
      appUser = AppUser(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName,
        email: firebaseUser.email,
      );

      FirebaseFirestore.instance
          .collection('USERS')
          .doc(appUser.uid)
          .update(appUser.toJson());
    }

    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    authProvider.setAppUser = appUser;
  }

  Future<void> googleSignOut({@required BuildContext context}) async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();

    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    authProvider.removeAppUser();
  }
}
