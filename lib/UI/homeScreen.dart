import 'package:avg_media/Widgets/postCard.dart';
import 'package:avg_media/models/post.dart';
import 'package:avg_media/providers/postsProvider.dart';
import 'package:avg_media/services/firestoreServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await FirestoreServices().downloadPosts(context);
      },
      child: FutureBuilder(
        future: FirestoreServices().downloadPosts(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Consumer<PostsProvider>(
                builder: (_, postsProvider, child) {
                  List<Post> postsList = postsProvider.getPostsList;
                  return Column(
                    children: List.generate(
                      postsList.length,
                      (index) {
                        return PostCard(post: postsList[index]);
                      },
                    ),
                  );
                },
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
