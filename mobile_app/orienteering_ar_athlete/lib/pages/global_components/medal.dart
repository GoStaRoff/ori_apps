import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/pages/global_components/dMedal.dart';

const GOLD_MEDAL_TEXT = Color(0xFFFFE07D);
const SILVER_MEDAL_TEXT = Color(0xFFEFF3F9);
const BRONZE_MEDAL_TEXT = Color(0xFFF2DBD6);
const GREY_MEDAL_TEXT = Color(0xFFE5E5E5);

class Medal extends StatelessWidget {
  final double kof;
  var medal;

  Medal({this.kof = 1, this.medal});

  @override
  Widget build(BuildContext context) {
    String ribbonColor = "dark";
    String medalColor = "gold";
    String terraImage = "assets/medals/forest_icon.svg";
    Color medalTextColor = GOLD_MEDAL_TEXT;
    if (medal["route_terra"] == "City")
      terraImage = "assets/medals/city_icon.svg";
    else if (medal["route_terra"] == "Park")
      terraImage = "assets/medals/park_icon.svg";
    if (medal["athlete_passes"] == "1")
      ribbonColor = "red";
    else if (medal["athlete_passes"] == "2") ribbonColor = "blue";
    switch (medal["medal"]) {
      case "10":
        medalColor = "silver";
        medalTextColor = SILVER_MEDAL_TEXT;
        break;
      case "20":
        medalColor = "bronze";
        medalTextColor = BRONZE_MEDAL_TEXT;
        break;
      case "50":
        medalColor = "grey";
        medalTextColor = GREY_MEDAL_TEXT;
        break;
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        CustomPaint(
          size: Size(125 * kof, (125 * kof * 2.3307086614173227).toDouble()),
          painter: DMedal(
            rColor: ribbonColor,
            mColor: medalColor,
            withCup: medal["medal"] == "0",
          ),
        ),
        Positioned(
          top: 55 * kof,
          child: Text(
            medal["medal_passes"],
            style: AUTH_TITLE_TEXT_STYLE.copyWith(
                color: Colors.white70, fontSize: 20 * kof),
          ),
        ),
        Positioned(
          top: 100 * kof,
          child: SvgPicture.asset(
            terraImage,
            color: Colors.white70,
            height: 30 * kof,
          ),
        ),
        Positioned(
          top: 20 * kof,
          child: SvgPicture.asset(
            medal["route_best"] == "CPS"
                ? "assets/medals/route_icon.svg"
                : "assets/medals/speed_icon.svg",
            color: Colors.white70,
            height: 27 * kof,
          ),
        ),
        Positioned(
          top: 50 * kof,
          right: 57 * kof,
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(270 / 360),
            child: Container(
              width: 100 * kof,
              child: Center(
                child: Text(
                  medal["athlete_login"].toString().toUpperCase(),
                  style: AUTH_TITLE_TEXT_STYLE.copyWith(
                      color: Colors.white70, fontSize: 11 * kof),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10 * kof,
          left: 93 * kof,
          child: Text(
            "PASS",
            style: AUTH_TITLE_TEXT_STYLE.copyWith(
                color: Colors.white70, fontSize: 10 * kof),
          ),
        ),
        Positioned(
          top: 25 * kof,
          left: 95 * kof,
          child: Container(
            width: 25 * kof,
            child: Center(
              child: Text(
                int.parse(medal["athlete_passes"]) >= 3
                    ? "3+"
                    : medal["athlete_passes"],
                style: AUTH_TITLE_TEXT_STYLE.copyWith(
                  color: Colors.white70,
                  fontSize: 19 * kof,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 180 * kof,
          child: Text(
            medalColor != "gold" ? medal["medal"] : "",
            style: MEDAL_TEXT_STYLE.copyWith(
              color: medalTextColor,
              fontSize: 50 * kof,
              fontWeight: FontWeight.w900,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.4 * kof, 0.4 * kof),
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 195 * kof,
          right: 22 * kof,
          child: Text(
            medalColor != "gold" ? "%" : "",
            style: MEDAL_TEXT_STYLE.copyWith(
              color: medalTextColor,
              fontSize: 18 * kof,
              fontWeight: FontWeight.w900,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.4 * kof, 0.4 * kof),
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 180 * kof,
          right: 13 * kof,
          child: CircularText(
            children: [
              TextItem(
                text: Text(
                  medal["route_type"] == "Orient" ||
                          medal["route_type"] == "Quest"
                      ? medal["cp_count"] + " CP"
                      : "",
                  style: MEDAL_TEXT_STYLE.copyWith(
                    color: medalTextColor,
                    fontSize: 9 * kof,
                    fontWeight: FontWeight.w900,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.4 * kof, 0.4 * kof),
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                space: 6,
                startAngle: -190,
                direction: CircularTextDirection.anticlockwise,
                startAngleAlignment: StartAngleAlignment.center,
              ),
              TextItem(
                text: Text(
                  medal["route_name"].length > 12
                      ? medal["route_name"].substring(0, 15)
                      : medal["route_name"],
                  style: MEDAL_TEXT_STYLE.copyWith(
                    color: medalTextColor,
                    fontSize: 12 * kof,
                    fontWeight: FontWeight.w900,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.5 * kof, 0.6 * kof),
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                space: 7,
                startAngle: 90,
                direction: CircularTextDirection.anticlockwise,
                startAngleAlignment: StartAngleAlignment.center,
              ),
              TextItem(
                text: Text(
                  medal["route_type"] == "Orient" ||
                          medal["route_type"] == "Quest"
                      ? medal["route_length"] + " KM"
                      : "",
                  style: MEDAL_TEXT_STYLE.copyWith(
                    color: medalTextColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 9 * kof,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.4 * kof, 0.4 * kof),
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                space: 6,
                startAngle: 10,
                direction: CircularTextDirection.anticlockwise,
                startAngleAlignment: StartAngleAlignment.center,
              ),
            ],
            radius: 50 * kof,
            position: CircularTextPosition.inside,
          ),
        ),
        Container(
          width: 127 * kof,
          height: 295 * kof,
          color: medal["beated"] == "true" ? BG_COLOR.withOpacity(0.7) : null,
          child: medal["beated"] == "true"
              ? Column(
                  children: [
                    SizedBox(
                      height: 215 * kof,
                    ),
                    Text(
                      "BEATED",
                      style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 13),
                    )
                  ],
                )
              : null,
        ),
      ],
    );
  }
}
