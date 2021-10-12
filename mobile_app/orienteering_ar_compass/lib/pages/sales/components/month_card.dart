import 'package:flutter/material.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';

// ignore: must_be_immutable
class MonthCard extends StatelessWidget {
  final String month;
  final String year;
  bool selected;

  MonthCard({required this.month, required this.year, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      borderEnabled: true,
      borderColor: selected ? DARK_BROWN : LIGHT_GRAY_TEXT,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              month,
              style: MAIN_TEXT_STYLE_BLACK.copyWith(
                color: selected ? null : LIGHT_GRAY_TEXT,
              ),
            ),
            Text(
              year,
              style: MAIN_TEXT_STYLE_BLACK.copyWith(
                  fontSize: 12.0, color: selected ? null : LIGHT_GRAY_TEXT),
            ),
          ],
        ),
      ),
    );
  }
}
