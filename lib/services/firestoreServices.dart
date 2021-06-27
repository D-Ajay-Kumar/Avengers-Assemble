import 'package:avg_media/models/appUser.dart';
import 'package:avg_media/models/post.dart';
import 'package:avg_media/providers/postsProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

import 'package:provider/provider.dart';

class FirestoreServices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final Reference _storageReference = FirebaseStorage.instance.ref();

  Future<void> uploadPost(
      {@required Post post, @required BuildContext context}) async {
    // get ID from firestore
    String id = firebaseFirestore.collection('POSTS').doc().id;
    post.id = id;

    firebaseFirestore.collection('POSTS').doc(id).set(
          post.toJson(),
        );

    PostsProvider postsProvider =
        Provider.of<PostsProvider>(context, listen: false);
    postsProvider.addPost(post);
  }

  Future<String> uploadPicture(File image) async {
    // uploads picture(s) to storage and return it's URL
    final Reference ref =
        _storageReference.child('${Path.basename(image.path)}}');

    final UploadTask uploadTask = ref.putFile(image);
    // final TaskSnapshot storageTaskSnapshot =
    String pictureUrl;
    await uploadTask.then((taskSnapshot) async {
      pictureUrl = await taskSnapshot.ref.getDownloadURL();
    });

    return pictureUrl;
  }

  Future<void> downloadPosts(BuildContext context) async {
    QuerySnapshot postsQS =
        await firebaseFirestore.collection('POSTS').orderBy('date').get();

    PostsProvider postsProvider =
        Provider.of<PostsProvider>(context, listen: false);
    List<Post> postsList = [];

    postsQS.docs.forEach(
      (postQDS) {
        final postMapData = postQDS.data();
        if (postMapData != null) {
          Post post = Post.fromJson(postMapData);

          postsList.add(post);
        } else {
          return;
        }
      },
    );

    postsProvider.setPostsList = postsList;
  }

  Future<void> uploadUserData(
      {@required AppUser oldAppUser, @required AppUser updatedAppUser}) async {
    FirebaseFirestore.instance.collection('USERS').doc(oldAppUser.uid).set(
          updatedAppUser.toJson(),
        );

    FirebaseFirestore.instance
        .collection('POSTS')
        .where('username', isEqualTo: oldAppUser.name)
        .get()
        .then(
      (querySnapshot) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          doc.reference.update(
            {
              'username': updatedAppUser.name,
              'userPicture': updatedAppUser.pictureUrl,
            },
          );
        }
      },
    );
  }

  Future<void> uploadComment({
    @required String postId,
    @required String username,
    @required Map comments,
  }) async {
    final postDS =
        await firebaseFirestore.collection('COMMENTS').doc(postId).get();
    final data = postDS.data();
    data.addEntries(
      [
        // {username: comments},
      ],
    );
    firebaseFirestore.collection('COMMENTS').doc(postId).update({
      'comments': comments,
    });
  }

  Future<Map> downloadComment({@required String postId}) async {
    DocumentSnapshot commentsDS =
        await firebaseFirestore.collection('COMMENTS').doc(postId).get();

    final Map data = commentsDS.data();
    final Map comments = data['commentsss'];
    print(comments);
    return comments;
  }
}
