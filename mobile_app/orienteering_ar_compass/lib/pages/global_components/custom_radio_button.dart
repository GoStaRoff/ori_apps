import 'package:flutter/material.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';

// ignore: must_be_immutable
class CustomRadioButton extends StatelessWidget {
  final bool isChecked;
  var text;

  CustomRadioButton({
    required this.isChecked,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: isChecked ? DARK_BROWN : LIGHT_GRAY_TEXT,
            child: CircleAvatar(
              backgroundColor: BG_COLOR,
              child: CircleAvatar(
                radius: isChecked ? 8.0 : 0.1,
                backgroundColor: DARK_BROWN,
              ),
              radius: 12,
            ),
          ),
          text != null
              ? Row(
                  children: [
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      text,
                      style: MAIN_TEXT_STYLE_BLACK,
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
