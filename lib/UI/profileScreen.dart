import 'package:avg_media/UI/editProfileScreen.dart';
import 'package:avg_media/UI/postDetailsScreen.dart';
import 'package:avg_media/Widgets/lineButton.dart';
import 'package:avg_media/globals.dart';
import 'package:avg_media/models/appUser.dart';
import 'package:avg_media/models/post.dart';
import 'package:avg_media/providers/authProvider.dart';
import 'package:avg_media/providers/postsProvider.dart';
import 'package:avg_media/services/authenticationServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profileScreen';

  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
            ),
            child: Consumer<AuthProvider>(
              builder: (_, authProvider, child) {
                AppUser appUser = authProvider.getAppUser;
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.black,
                      backgroundImage: appUser.pictureUrl == null
                          ? AssetImage('assets/defaultImage.png')
                          : NetworkImage(appUser.pictureUrl),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appUser.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          appUser.email,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: LineButton(
                  title: 'Edit',
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(EditProfileScreen.routeName);
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: LineButton(
                  title: 'Logout',
                  onTap: () {
                    AuthenticationServices().googleSignOut(context: context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Consumer<PostsProvider>(
              builder: (_, postsProvider, child) {
                List<Post> postsList = postsProvider.getPostsList;
                return GridView(
                  children: List.generate(
                    postsList.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return PostDetailsScreen(post: postsList[index]);
                            }),
                          );
                        },
                        child: Container(
                          height: deviceHeight * 0.29,
                          width: deviceHeight * 0.29,
                          child: Image.network(
                            postsList[index].url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
