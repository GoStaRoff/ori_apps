import 'package:flutter/material.dart';

class BottomRoundedContainer extends StatelessWidget {
  final double height;
  final Widget child;

  BottomRoundedContainer({required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: child,
    );
  }
}
