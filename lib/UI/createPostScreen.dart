import 'dart:io';
import 'package:avg_media/Widgets/fillButton.dart';
import 'package:avg_media/Widgets/lineButton.dart';
import 'package:avg_media/constants.dart';
import 'package:avg_media/globals.dart';
import 'package:avg_media/models/appUser.dart';
import 'package:avg_media/models/post.dart';
import 'package:avg_media/providers/authProvider.dart';
import 'package:avg_media/services/firestoreServices.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  static const routeName = '/createPostScreen';
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File image;
  TextEditingController captionController = TextEditingController();

  Future<PickedFile> getImage() async {
    ImagePicker imagePicker = ImagePicker();

    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedFile.path);
    });

    return pickedFile;
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  Future<void> post() async {
    String caption = captionController.text;
    String url = await FirestoreServices().uploadPicture(image);

    AppUser appUser =
        Provider.of<AuthProvider>(context, listen: false).getAppUser;

    Post post = Post(
      caption: caption,
      url: url,
      date: DateTime.now()
          .toUtc()
          .toString()
          .replaceFirst('.000Z', '')
          .split(' ')[0],
      username: appUser.name,
      userId: appUser.uid,
      userPicture: appUser.pictureUrl,
    );

    await FirestoreServices().uploadPost(
      post: post,
      context: context,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          width: deviceWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await getImage();
                },
                child: Container(
                  height: deviceHeight * 0.5,
                  width: deviceWidth * 0.9,
                  color: Colors.grey,
                  child: image != null
                      ? Image.file(image)
                      : Center(
                          child: Icon(
                            Icons.add,
                            size: 50,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: deviceWidth * 0.9,
                child: TextFormField(
                  controller: captionController,
                  maxLines: 5,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Caption',
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: deviceWidth * 0.9,
                child: Row(
                  children: [
                    Expanded(
                      child: LineButton(
                        title: 'Cancel',
                        onTap: cancel,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FillButton(
                        title: 'Post',
                        onTap: post,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
