import 'package:avg_media/models/appUser.dart';
import 'package:flutter/foundation.dart';

class Post {
  String id;
  String username;
  String userId;
  String date;
  String caption;
  String url;
  String userPicture;

  Post({
    this.id,
    @required this.caption,
    @required this.url,
    @required this.date,
    @required this.username,
    @required this.userId,
    this.userPicture,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caption = json['caption'];
    url = json['url'];
    date = json['date'];
    username = json['username'];
    userId = json['userId'];
    userPicture = json['userPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['caption'] = this.caption;
    data['url'] = this.url;
    data['date'] = this.date;
    data['username'] = this.username;
    data['userId'] = this.userId;
    data['userPicture'] = this.userPicture;
    return data;
  }
}
