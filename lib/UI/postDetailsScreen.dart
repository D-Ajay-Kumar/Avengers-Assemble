import 'package:avg_media/Widgets/titleFormField.dart';
import 'package:avg_media/models/appUser.dart';
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
  Map<dynamic, dynamic> comments;

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppUser appUser =
        Provider.of<AuthProvider>(context, listen: false).getAppUser;

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
                  comments = snapshot.data;
                  return Column(
                    children: comments.entries.map(
                      (user) {
                        List<dynamic> userComments = user.value;
                        List.generate(
                          userComments.length,
                          (index) {
                            print(index.toString() + ' ' + userComments[index]);
                            return ListTile(
                              title: Text(
                                user.key.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                userComments[index].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            TitleFormField(
              title: 'Comments',
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
                    comments[appUser.name] = 'Hello';
                    print(comments);
                    // await FirestoreServices().uploadComment(
                    //   username: appUser.name,
                    //   postId: widget.post.id,
                    //   comments: comments,
                    // );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
