import 'dart:io';

import 'package:avg_media/Widgets/fillButton.dart';
import 'package:avg_media/Widgets/lineButton.dart';
import 'package:avg_media/Widgets/titleFormField.dart';
import 'package:avg_media/constants.dart';
import 'package:avg_media/models/appUser.dart';
import 'package:avg_media/providers/authProvider.dart';
import 'package:avg_media/services/firestoreServices.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/editProfileScreen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController;
  TextEditingController phoneController;

  AppUser appUser;

  File image;

  Future<PickedFile> getImage() async {
    ImagePicker imagePicker = ImagePicker();

    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedFile.path);
    });

    return pickedFile;
  }

  @override
  void initState() {
    super.initState();

    appUser = Provider.of<AuthProvider>(context, listen: false).getAppUser;

    nameController = TextEditingController(text: appUser.name);
    phoneController = TextEditingController(text: appUser.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: getImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.black,
                    backgroundImage: image == null
                        ? (appUser.pictureUrl == null
                            ? AssetImage('assets/deafultImage.png')
                            : NetworkImage(appUser.pictureUrl))
                        : FileImage(image),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TitleFormField(
                title: 'Name',
                textEditingController: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              TitleFormField(
                title: 'Phone',
                textEditingController: phoneController,
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: LineButton(
                        title: 'Cancel',
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FillButton(
                        title: 'Save',
                        onTap: () async {
                          String pictureUrl =
                              await FirestoreServices().uploadPicture(image);

                          AppUser updateAppUser = AppUser(
                            uid: appUser.uid,
                            name: nameController.text,
                            email: appUser.email,
                            phone: phoneController.text,
                            pictureUrl: pictureUrl,
                          );

                          await FirestoreServices().uploadUserData(
                              oldAppUser: appUser,
                              updatedAppUser: updateAppUser);

                          Provider.of<AuthProvider>(context, listen: false)
                              .setAppUser = updateAppUser;

                          Navigator.of(context).pop();
                        },
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
