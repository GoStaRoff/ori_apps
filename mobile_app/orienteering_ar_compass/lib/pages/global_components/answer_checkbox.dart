import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';

class AnswerCheckbox extends StatelessWidget {
  final void Function()? onTap;
  final bool checked;
  final String answerText;

  AnswerCheckbox(
      {required this.checked, required this.onTap, required this.answerText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  answerText,
                  style: MAIN_TEXT_STYLE_BLACK,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 13,
                      backgroundColor: checked ? GREEN : LIGHT_RED,
                      child: checked
                          ? SvgPicture.asset("assets/icons/check_icon.svg")
                          : Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 1.0,
            child: Container(
              color: BG_COLOR,
            ),
          ),
        ],
      ),
    );
  }
}
