import 'package:avg_media/models/appUser.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier {
  AppUser _appUser;

  set setAppUser(AppUser appUser) {
    _appUser = appUser;

    notifyListeners();
  }

  get getAppUser {
    return _appUser;
  }

  void removeAppUser() {
    _appUser = null;

    notifyListeners();
  }
}
