import 'package:flutter/material.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';

// ignore: must_be_immutable
class TextedCheckBox extends StatelessWidget {
  var onTap;
  bool checked;
  String text;

  TextedCheckBox({this.onTap, this.text = "", this.checked = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: checked ? DARK_BROWN : LIGHT_GRAY_TEXT,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: MAIN_TEXT_STYLE_BLACK.copyWith(
              color: checked ? DARK_BROWN : LIGHT_GRAY_TEXT,
            ),
          ),
        ),
      ),
    );
  }
}
