import 'package:flutter/material.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';

// ignore: must_be_immutable
class MainButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isActive;
  double width;

  MainButton(
      {required this.text,
      required this.onPressed,
      required this.isActive,
      this.width = 0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        onPressed();
      },
      child: Container(
        width: width == 0 ? null : width,
        height: 45.0,
        child: Center(
          child: Text(
            text,
            style: isActive
                ? MAIN_TEXT_STYLE_WHITE
                : MAIN_TEXT_STYLE_WHITE.copyWith(color: LIGHT_GRAY_TEXT),
          ),
        ),
        decoration: BoxDecoration(
          color: isActive ? ORIENT_COLOR : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
