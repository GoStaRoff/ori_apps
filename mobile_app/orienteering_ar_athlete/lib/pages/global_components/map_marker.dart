import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';

// ignore: must_be_immutable
class MapMarker extends StatelessWidget {
  final String id;
  var number;
  var lastMarker;

  MapMarker({required this.id, this.number, this.lastMarker});

  @override
  Widget build(BuildContext context) {
    if (lastMarker == null) lastMarker = false;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/marker_icon.svg",
              height: 36.0,
              color: number == 0
                  ? LIGHT_RED.withOpacity(0.8)
                  : lastMarker
                      ? ORIENT_COLOR.withOpacity(0.8)
                      : GREEN.withOpacity(0.8),
            ),
            number == null
                ? Positioned(
                    top: 12.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 4.5,
                    ))
                : number == 0 || lastMarker
                    ? Positioned(
                        top: 12.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 4.5,
                        ))
                    : Positioned(
                        top: 6.0,
                        child: Text(
                          number.toString(),
                          style: MAIN_TEXT_STYLE_WHITE.copyWith(fontSize: 12.0),
                        ),
                      ),
          ],
        ),
        SizedBox(
          height: 3.0,
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 6.0,
          child: CircleAvatar(
            backgroundColor: number == 0
                ? LIGHT_RED
                : lastMarker
                    ? ORIENT_COLOR
                    : GREEN,
            radius: 3.0,
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        RoundedContainer(
          color: Colors.white.withOpacity(0.7),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
            child: Text(
              id,
              style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }
}
