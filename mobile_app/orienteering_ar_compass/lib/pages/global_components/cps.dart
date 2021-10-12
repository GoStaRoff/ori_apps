import 'package:flutter/material.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';

// ignore: must_be_immutable
class CPS extends StatelessWidget {
  double fontSize;
  String count;

  CPS({this.count = "2", this.fontSize = 16.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: fontSize),
        ),
        Text(
          "CP",
          style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: fontSize / (4 / 3)),
        )
      ],
    );
  }
}
