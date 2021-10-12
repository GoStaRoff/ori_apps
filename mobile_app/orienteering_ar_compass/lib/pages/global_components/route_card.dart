import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/cps.dart';
import 'package:orienteering_ar_compass/pages/global_components/distance.dart';
import 'package:orienteering_ar_compass/pages/global_components/money.dart';
import 'package:orienteering_ar_compass/pages/global_components/percent.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';

class RouteCard extends StatelessWidget {
  // "route_id": 15,\
  final item;

  RouteCard({required this.item});

  @override
  Widget build(BuildContext context) {
    Color color;
    String type;
    switch (item["route_type"]) {
      case "Orient":
        color = ORIENT_COLOR;
        type = "O";
        break;
      case "Quest":
        color = ORANGE;
        type = "Q";
        break;
      case "Detective":
        color = LIGHT_RED;
        type = "D";
        break;
      case "Rogaine":
      default:
        color = VIOLET;
        type = "R";
        break;
    }
    SvgPicture terra;
    switch (item["route_terra"]) {
      case "Forest":
        terra = SvgPicture.asset(
          "assets/icons/forest_icon.svg",
          color: DARK_BROWN,
          height: 16.0,
        );
        break;
      case "Park":
        terra = SvgPicture.asset(
          "assets/icons/park_icon.svg",
          color: DARK_BROWN,
          height: 16.0,
        );
        break;
      case "City":
      default:
        terra = SvgPicture.asset(
          "assets/icons/city_icon.svg",
          color: DARK_BROWN,
          height: 16.0,
        );
        break;
    }
    SvgPicture method;
    switch (item["route_method"]) {
      case "Runner":
        method = SvgPicture.asset(
          "assets/icons/runner_icon.svg",
          color: DARK_BROWN,
          height: 16.0,
        );
        break;
      case "Bike":
        method = SvgPicture.asset(
          "assets/icons/bike_icon.svg",
          color: DARK_BROWN,
          height: 16.0,
        );
        break;
      case "Ski":
      default:
        method = SvgPicture.asset(
          "assets/icons/ski_icon.svg",
          color: DARK_BROWN,
          height: 16.0,
        );
        break;
    }

    return RoundedContainer(
      height: 80.0,
      child: Row(
        children: [
          Container(
            width: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(item["route_avatar"]),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 10.0,
                  right: 10.0,
                  child: RoundedContainer(
                    height: 20.0,
                    color: color,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Text(
                            type,
                            style: MAIN_TEXT_STYLE_WHITE.copyWith(fontSize: 14),
                          ),
                          type == "Q" || type == "O"
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Center(
                                      child: Distance(
                                        distance:
                                            item["route_length"].toString(),
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item["route_generated_name"],
                        style: MAIN_TEXT_STYLE_BLACK,
                      ),
                      Money(count: item["route_price"]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      terra,
                      method,
                      RoundedContainer(
                        height: 20.0,
                        color: LIGHT_GRAY_BG,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Center(
                            child: CPS(
                              count: item["cps"].length.toString(),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: GREEN,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "${item["route_rate"] ?? "0"}",
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(color: GREEN),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    color: LIGHT_GRAY_TEXT,
                    height: 1.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                              "assets/icons/people_count_icon.svg"),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            "${item["route_passes_count"] ?? "0"}",
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                color: LIGHT_GRAY_TEXT),
                          )
                        ],
                      ),
                      Container(
                        color: LIGHT_GRAY_TEXT,
                        width: 1.0,
                        height: 12.0,
                      ),
                      Money(
                        color: LIGHT_GRAY_TEXT,
                        count: item["route_cash_count"] ?? "0",
                      ),
                      Container(
                        color: LIGHT_GRAY_TEXT,
                        width: 1.0,
                        height: 12.0,
                      ),
                      Percent(
                        count: item["route_percent"] ?? "0",
                        color: LIGHT_GRAY_TEXT,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
