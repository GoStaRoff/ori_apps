import 'package:flutter/material.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';

// ignore: must_be_immutable
class RoundedContainer extends StatelessWidget {
  double height;
  double width;
  final Widget child;
  Color color;
  bool borderEnabled;
  Color borderColor;
  var onTap;

  RoundedContainer({
    required this.child,
    this.height = 0,
    this.width = 0,
    this.color = Colors.white,
    this.borderEnabled = false,
    this.onTap,
    this.borderColor = DARK_BROWN,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap == null
            ? null
            : () {
                onTap();
              },
        child: Container(
          height: height == 0 ? null : height,
          width: width == 0 ? null : width,
          decoration: BoxDecoration(
            color: color,
            border:
                borderEnabled ? Border.all(color: borderColor, width: 1) : null,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
