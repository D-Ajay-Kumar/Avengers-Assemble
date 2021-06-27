import 'package:avg_media/globals.dart';
import 'package:flutter/material.dart';

class FillButton extends StatelessWidget {
  final String title;
  final Function onTap;

  FillButton({@required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            title,
          ),
        ),
        height: deviceHeight * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
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
