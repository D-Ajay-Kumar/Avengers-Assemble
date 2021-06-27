import 'package:avg_media/UI/createPostScreen.dart';
import 'package:avg_media/UI/discoverScreen.dart';
import 'package:avg_media/UI/homeScreen.dart';
import 'package:avg_media/UI/profileScreen.dart';
import 'package:avg_media/UI/searchScreen.dart';
import 'package:avg_media/Widgets/gradientButton.dart';
import 'package:avg_media/services/firestoreServices.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  static const routeName = '/index';
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;

  List<Widget> _screensList;

  @override
  void initState() {
    super.initState();

    _screensList = [
      HomeScreen(),
      DiscoverScreen(),
      SearchScreen(),
      ProfileScreen(),
    ];
  }

  void changeScreen(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Avengers Assemble'),
      ),
      floatingActionButton: GradientButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CreatePostScreen.routeName);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        gradient: LinearGradient(
          colors: <Color>[
            Colors.pink[300],
            Colors.purple[300],
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        index: _currentIndex,
        children: _screensList,
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 55,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                DateTime dateTime = DateTime.now();

                changeScreen(0);
              },
              child: Icon(
                Icons.home,
                size: 30,
                color: _currentIndex == 0 ? Colors.pink[300] : Colors.grey[300],
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     changeScreen(1);
            //   },
            //   child: Icon(
            //     Icons.search,
            //     size: 30,
            //     color: _currentIndex == 1 ? Colors.green : Colors.grey[300],
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     changeScreen(2);
            //   },
            //   child: Icon(
            //     Icons.settings,
            //     size: 30,
            //     color: _currentIndex == 2 ? Colors.green : Colors.grey[300],
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                changeScreen(3);
              },
              child: Icon(
                Icons.person,
                size: 30,
                color:
                    _currentIndex == 3 ? Colors.purple[300] : Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
