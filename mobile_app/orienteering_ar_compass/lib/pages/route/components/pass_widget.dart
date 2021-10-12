import 'package:flutter/material.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/distance.dart';

class PassWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        AssetImage("assets/images/example_card.jpg"),
                  ),
                  SizedBox(
                    width: 14.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "VasGen",
                        style: MAIN_TEXT_STYLE_BLACK,
                      ),
                      Text(
                        "16.04.2021",
                        style: MAIN_TEXT_STYLE_BLACK.copyWith(
                          color: LIGHT_GRAY_TEXT,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    "3:21",
                    style: MAIN_TEXT_STYLE_BLACK,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Distance(
                    distance: "20",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.0,
              child: Container(
                color: LIGHT_GRAY,
              ),
            ),
          ],
        ),
        Positioned(
          right: 0,
          child: Image.asset("assets/images/medal_example.png"),
        ),
      ],
    );
  }
}
