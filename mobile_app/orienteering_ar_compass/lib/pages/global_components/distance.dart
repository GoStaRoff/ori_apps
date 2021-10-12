import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';

// ignore: must_be_immutable
class Distance extends StatelessWidget {
  MainController mainController = Get.find();
  double fontSize;
  String distance;
  Color color;

  Distance(
      {this.distance = "20", this.fontSize = 16.0, this.color = DARK_BROWN});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          distance,
          style: MAIN_TEXT_STYLE_BLACK.copyWith(
            fontSize: fontSize,
            color: color,
          ),
        ),
        Text(
          mainController.distance.value,
          style: MAIN_TEXT_STYLE_BLACK.copyWith(
            fontSize: fontSize / (4 / 3),
            color: color,
          ),
        )
      ],
    );
  }
}
