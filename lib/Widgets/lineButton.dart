import 'package:avg_media/globals.dart';
import 'package:flutter/material.dart';

class LineButton extends StatelessWidget {
  final String title;
  final Function onTap;

  LineButton({@required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        height: deviceHeight * 0.07,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            const Radius.circular(5.0),
          ),
          border: Border.all(
            width: 1.5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
