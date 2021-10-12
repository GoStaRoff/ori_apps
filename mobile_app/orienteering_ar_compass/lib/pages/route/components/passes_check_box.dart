import 'package:flutter/material.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';

// ignore: must_be_immutable
class PassesCheckBox extends StatelessWidget {
  var onTap;
  bool checked;
  var widget;
  String count;
  String text;

  PassesCheckBox({
    this.onTap,
    this.checked = false,
    this.widget,
    this.text = "",
    this.count = "",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 57.0,
        width: 69.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: checked ? DARK_BROWN : LIGHT_GRAY_TEXT,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            children: [
              Text(
                count,
                style: MAIN_TEXT_STYLE_BLACK.copyWith(
                  fontSize: 18.0,
                  color: checked ? DARK_BROWN : LIGHT_GRAY_TEXT,
                ),
              ),
              Text(
                text,
                style: MAIN_TEXT_STYLE_BLACK.copyWith(
                  fontSize: 14.0,
                  color: checked ? DARK_BROWN : LIGHT_GRAY_TEXT,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
