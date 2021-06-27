import 'package:flutter/foundation.dart';

class AppUser {
  String name;
  String email;
  String uid;
  String phone;
  String pictureUrl;

  AppUser({
    @required this.uid,
    @required this.name,
    @required this.email,
    this.phone,
    this.pictureUrl,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    pictureUrl = json['pictureUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['pictureUrl'] = this.pictureUrl;
    return data;
  }
}
