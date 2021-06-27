import 'package:avg_media/models/post.dart';
import 'package:flutter/foundation.dart';

class PostsProvider with ChangeNotifier {
  List<Post> _postsList = [];

  set setPostsList(List<Post> posts) {
    _postsList = posts;

    notifyListeners();
  }

  void addPost(Post post) {
    _postsList.insert(0, post);

    notifyListeners();
  }

  get getPostsList {
    return _postsList;
  }
}
