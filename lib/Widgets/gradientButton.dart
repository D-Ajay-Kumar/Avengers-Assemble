import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final Function onPressed;

  const GradientButton({
    @required this.child,
    this.gradient,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              onPressed();
            },
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
