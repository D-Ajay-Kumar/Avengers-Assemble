import 'package:avg_media/UI/postDetailsScreen.dart';
import 'package:avg_media/Widgets/gradientButton.dart';
import 'package:avg_media/models/post.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({@required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return PostDetailsScreen(post: post);
            },
          ),
        );
      },
      child: Card(
        color: Colors.black38,
        margin: EdgeInsets.only(top: 20),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
                backgroundImage: post.userPicture == null
                    ? AssetImage('assets/google_logo.png')
                    : NetworkImage(post.userPicture),
              ),
              tileColor: Colors.black,
              contentPadding: EdgeInsets.only(left: 15),
              title: Text(
                post.username,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                post.date,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.network(post.url),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 15),
              title: Text(
                post.username,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                post.caption,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
