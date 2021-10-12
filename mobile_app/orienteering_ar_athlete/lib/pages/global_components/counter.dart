import 'package:flutter/material.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';

class Counter extends StatelessWidget {
  final int count;

  Counter(this.count);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: GREEN,
      radius: 11,
      child: Text(
        count < 10 ? count.toString() : "9+",
        style: MAIN_TEXT_STYLE_WHITE,
      ),
    );
  }
}
