import 'package:avg_media/constants.dart';
import 'package:flutter/material.dart';

class TitleFormField extends StatelessWidget {
  final String title;
  final TextEditingController textEditingController;

  const TitleFormField({
    @required this.title,
    @required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: textEditingController,
            style: TextStyle(
              color: Colors.white,
            ),
            // initialValue: initialValue ?? '',
            decoration: inputDecoration.copyWith(),
          )
        ],
      ),
    );
  }
}
