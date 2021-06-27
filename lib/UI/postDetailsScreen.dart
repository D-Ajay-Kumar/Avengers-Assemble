import 'package:avg_media/Widgets/titleFormField.dart';
import 'package:avg_media/models/appUser.dart';
import 'package:avg_media/models/comment.dart';
import 'package:avg_media/models/post.dart';
import 'package:avg_media/providers/authProvider.dart';
import 'package:avg_media/services/firestoreServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetailsScreen extends StatefulWidget {
  final Post post;

  PostDetailsScreen({@required this.post});

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppUser appUser =
        Provider.of<AuthProvider>(context, listen: false).getAppUser;

    List<dynamic> commentsList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(widget.post.username),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.post.url),
            FutureBuilder(
              future:
                  FirestoreServices().downloadComment(postId: widget.post.id),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  commentsList = snapshot.data;
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.comment_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              commentsList.length.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (Comment comment in commentsList)
                        ListTile(
                          title: Text(
                            comment.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            comment.comment,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.pinkAccent,
                  ),
                );
              },
            ),
            TitleFormField(
              title: 'Comment',
              textEditingController: commentController,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () async {
                    Comment comment = Comment(
                      name: appUser.name,
                      comment: commentController.text,
                      date: DateTime.now()
                          .toUtc()
                          .toString()
                          .replaceFirst('.000Z', '')
                          .split(' ')[0],
                    );

                    commentController.clear();
                    setState(() {
                      commentsList.add(comment);
                    });

                    await FirestoreServices().uploadComment(
                      username: appUser.name,
                      postId: widget.post.id,
                      commentsList: commentsList,
                      // comments: comments,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
