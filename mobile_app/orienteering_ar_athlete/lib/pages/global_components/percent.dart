import 'package:flutter/material.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';

// ignore: must_be_immutable
class Percent extends StatelessWidget {
  double fontSize;
  String count;
  Color color;

  Percent({this.count = "2", this.fontSize = 16.0, this.color = DARK_BROWN});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count.toString(),
          style: MAIN_TEXT_STYLE_BLACK.copyWith(
            fontSize: fontSize,
            color: color,
          ),
        ),
        Text(
          "%",
          style: MAIN_TEXT_STYLE_BLACK.copyWith(
            fontSize: fontSize / (4 / 3),
            color: color,
          ),
        )
      ],
    );
  }
}
