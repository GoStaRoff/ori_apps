import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';

// ignore: must_be_immutable
class CPSPageWidget extends StatelessWidget {
  MainController mainController = Get.find();
  final int index;
  final bool ordered;
  final bool isActive;
  var cps;
  var transitions;
  // SetRouteController setRouteController = Get.find();

  CPSPageWidget({
    required this.index,
    required this.ordered,
    this.cps,
    this.transitions,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    bool isLast = index == cps.length - 1;

    return Column(
      children: [
        SizedBox(
          height: 30.0,
        ),
        Obx(
          () => Stack(
            children: [
              GestureDetector(
                onTap: () {
                  print((mainController.currentRoute["step"].value == index &&
                          (mainController.currentRoute["route_type"] ==
                                  "Orient" ||
                              mainController.currentRoute["route_type"] ==
                                  "Quest")) ||
                      mainController.currentRoute["next_cp"].value ==
                          cps[index]["name"]);
                  print(mainController.currentRoute["next_cp"].value);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    color: (mainController.currentRoute["step"].value ==
                                    index &&
                                (mainController.currentRoute["route_type"] ==
                                        "Orient" ||
                                    mainController.currentRoute["route_type"] ==
                                        "Quest")) ||
                            mainController.currentRoute["next_cp"].value ==
                                cps[index]["name"]
                        ? Colors.green.withOpacity(0.5)
                        : null,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Row(
                      children: [
                        mainController.currentRoute["route_type"] != "Rogaine"
                            ? isLast && ordered
                                ? SvgPicture.asset(
                                    "assets/icons/finish_icon.svg",
                                    color: LIGHT_RED,
                                  )
                                : CircleAvatar(
                                    backgroundColor: LIGHT_RED,
                                    radius: 18.0,
                                    child: CircleAvatar(
                                      backgroundColor: BG_COLOR,
                                      radius: 17.0,
                                      child: index == 0 &&
                                              mainController.currentRoute[
                                                      "route_type"] !=
                                                  "Rogaine"
                                          ? SvgPicture.asset(
                                              "assets/icons/start_icon.svg",
                                              height: 18.0,
                                            )
                                          : Text(
                                              "${index}",
                                              style: MAIN_TEXT_STYLE_BLACK
                                                  .copyWith(color: LIGHT_RED),
                                            ),
                                    ),
                                  )
                            : SizedBox(),
                        SizedBox(
                          width: 8.0,
                        ),
                        Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/marker_icon.svg",
                                  color: isLast && ordered
                                      ? ORIENT_COLOR
                                      : index == 0 &&
                                              mainController.currentRoute[
                                                      "route_type"] !=
                                                  "Rogaine"
                                          ? LIGHT_RED
                                          : GREEN,
                                ),
                                Positioned(
                                  top: 8.0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 4.5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 6.0,
                              child: CircleAvatar(
                                backgroundColor: isLast && ordered
                                    ? ORIENT_COLOR
                                    : index == 0 &&
                                            mainController.currentRoute[
                                                    "route_type"] !=
                                                "Rogaine"
                                        ? LIGHT_RED
                                        : GREEN,
                                radius: 3.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          mainController.currentRoute["route_type"] ==
                                  "Detective"
                              ? mainController.currentRoute["cps"].value
                                  .firstWhere((cp) =>
                                      cp["name"] ==
                                      cps[index]["name"])["cp_name"]
                              : cps[index]["name"],
                          style: MAIN_TEXT_STYLE_BLACK,
                        ),
                        !ordered &&
                                mainController.currentRoute["route_type"] !=
                                    "Detective"
                            ? Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 7,
                                                  offset: Offset(2,
                                                      2), // changes position of shadow
                                                ),
                                              ],
                                              shape: BoxShape.circle,
                                              // border: Border.all(color: ORIENT_COLOR),
                                              color: int.parse(cps[index]
                                                          ["rogaine_value"]) >
                                                      300
                                                  ? int.parse(cps[index][
                                                              "rogaine_value"]) >
                                                          650
                                                      ? LIGHT_RED
                                                      : GREEN
                                                  : ORIENT_COLOR,
                                            ),
                                          ),
                                          Text(
                                            cps[index]["rogaine_value"],
                                            style: MAIN_TEXT_STYLE_WHITE
                                                .copyWith(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: !isActive ? BG_COLOR.withOpacity(0.5) : null,
                width: Get.width,
                height: 60,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        mainController.currentRoute["route_type"] == "Detective"
            ? Obx(
                () => mainController.currentRoute["history"]
                            .value[index]["answer"].value !=
                        ""
                    ? Column(
                        children: [
                          Bubble(
                            alignment: Alignment.topLeft,
                            nip: BubbleNip.leftTop,
                            nipWidth: 8,
                            child: Text(
                              mainController.currentRoute["history"]
                                  .value[index]["question"],
                              style: MAIN_TEXT_STYLE_BLACK,
                            ),
                          ),
                          Bubble(
                            alignment: Alignment.topRight,
                            color: ORIENT_COLOR.withOpacity(0.2),
                            margin: BubbleEdges.only(top: 10),
                            nip: BubbleNip.rightTop,
                            nipWidth: 8,
                            child: Text(
                              mainController.currentRoute["history"]
                                  .value[index]["answer"].value,
                              style: MAIN_TEXT_STYLE_BLACK,
                            ),
                          ),
                        ],
                      )
                    : Container(),
              )
            : ordered && !isLast
                ? Row(
                    children: [
                      SizedBox(
                        width: 62.0,
                      ),
                      CircleAvatar(
                        backgroundColor: LIGHT_GRAY,
                        radius: 5.0,
                        child: CircleAvatar(
                          backgroundColor: BG_COLOR,
                          radius: 4.0,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            height: 1.0,
                            width: 54.0,
                            color: LIGHT_GRAY,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          InkWell(
                            onTap:
                                // checkedType.value ==
                                //     "Quest"
                                //     ? () {
                                //   Get.to(() => TransitionPage(index));
                                // }                     :
                                null,
                            child: RoundedContainer(
                              color: Colors.transparent,
                              borderColor: LIGHT_GRAY,
                              borderEnabled: true,
                              width: 200.0,
                              height: 30.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RoundedContainer(
                                    height: 30.0,
                                    width: 80.0,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          index == 0 &&
                                                  mainController.currentRoute[
                                                          "route_type"] !=
                                                      "Rogaine"
                                              ? SvgPicture.asset(
                                                  "assets/icons/start_icon.svg",
                                                  height: 16.0,
                                                )
                                              : Text(
                                                  "${index}",
                                                  style: MAIN_TEXT_STYLE_BLACK,
                                                ),
                                          Icon(Icons.arrow_right_alt),
                                          index == cps.length - 2
                                              ? CircleAvatar(
                                                  radius: 10.0,
                                                  backgroundColor: LIGHT_RED,
                                                  child: CircleAvatar(
                                                    radius: 8.0,
                                                    backgroundColor: BG_COLOR,
                                                    child: CircleAvatar(
                                                      radius: 6.0,
                                                      backgroundColor:
                                                          LIGHT_RED,
                                                      child: CircleAvatar(
                                                        radius: 4.0,
                                                        backgroundColor:
                                                            BG_COLOR,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Text(
                                                  "${index + 1}",
                                                  style: MAIN_TEXT_STYLE_BLACK,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  RoundedContainer(
                                    height: 30.0,
                                    color: FILL_GRAY,
                                    child: Obx(
                                      () => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        child: transitions[index]["show_info"]
                                                    .value ==
                                                "true"
                                            ? Row(
                                                children: [
                                                  Text(
                                                    transitions[index]
                                                            ["distance"]
                                                        .substring(
                                                            0,
                                                            transitions[index]
                                                                    ["distance"]
                                                                .indexOf(".")),
                                                    style:
                                                        MAIN_TEXT_STYLE_WHITE,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "m",
                                                        style:
                                                            MAIN_TEXT_STYLE_WHITE
                                                                .copyWith(
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15.0),
                                                child: Text(
                                                  "?",
                                                  style: MAIN_TEXT_STYLE_WHITE,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  RoundedContainer(
                                    color: Colors.transparent,
                                    height: 30.0,
                                    child: Obx(
                                      () => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        child: transitions[index]["show_info"]
                                                    .value ==
                                                "true"
                                            ? Row(
                                                children: [
                                                  Text(
                                                    transitions[index]["angle"]
                                                        .substring(
                                                            0,
                                                            transitions[index]
                                                                    ["angle"]
                                                                .indexOf(".")),
                                                    style:
                                                        MAIN_TEXT_STYLE_BLACK,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "o",
                                                        style:
                                                            MAIN_TEXT_STYLE_BLACK
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.0),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15.0),
                                                child: Text(
                                                  "?",
                                                  style: MAIN_TEXT_STYLE_BLACK,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : Container(),
      ],
    );
  }
}
