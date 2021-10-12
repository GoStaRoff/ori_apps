import 'package:flutter/material.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_radio_button.dart';

// ignore: must_be_immutable
class PriorityItem extends StatelessWidget {
  String text;
  bool isChecked;
  var onTap;

  PriorityItem({this.text = "TEXT", this.isChecked = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: text.length > 0 ? onTap : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            type: MaterialType.transparency,
            child: Text(
              text,
              style: MAIN_TEXT_STYLE_BLACK,
            ),
          ),
          text.length > 0
              ? CustomRadioButton(isChecked: isChecked)
              : Container(),
        ],
      ),
    );
  }
}
