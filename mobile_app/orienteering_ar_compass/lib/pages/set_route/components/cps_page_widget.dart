import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/set_route/controllers/set_route_controller.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/cp_info_page.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/transition_page.dart';

// ignore: must_be_immutable
class CPSPageWidget extends StatelessWidget {
  final int index;
  final bool ordered;
  SetRouteController setRouteController = Get.find();

  CPSPageWidget({
    required this.index,
    required this.ordered,
  });

  @override
  Widget build(BuildContext context) {
    bool isLast = index == setRouteController.cps.length - 1;
    bool showInfo = true;
    if (!isLast && setRouteController.transitions[index]["show_info"] != null) {
      showInfo = setRouteController.transitions[index]["show_info"];
    }
    return Column(
      children: [
        SizedBox(
          height: 30.0,
        ),
        InkWell(
          onTap: ordered
              ? () {
                  Get.to(CPInfoPage(
                    cp: setRouteController.cps[index],
                  ));
                }
              : null,
          child: Row(
            children: [
              isLast && ordered
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
                        child: index == 0
                            ? SvgPicture.asset(
                                "assets/icons/start_icon.svg",
                                height: 18.0,
                              )
                            : Text(
                                "$index",
                                style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                    color: LIGHT_RED),
                              ),
                      ),
                    ),
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
                            : index == 0
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
                      backgroundColor: isLast
                          ? ORIENT_COLOR
                          : index == 0
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
                setRouteController.cps[index]["name"],
                style: MAIN_TEXT_STYLE_BLACK,
              ),
              !ordered
                  ? Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Container(
                              child: Obx(
                                () => CustomInput(
                                  initialValue: setRouteController.cps[index]
                                          ["rogaine_value"] ??
                                      "",
                                  hintText: "Rogaine value",
                                  onChanged: (value) {
                                    setRouteController.cps[index]
                                        ["rogaine_value"] = value;
                                    print(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]{0,3}$')),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        !isLast
            ? Row(
                children: [
                  SizedBox(
                    width: 52.0,
                  ),
                  CircleAvatar(
                    backgroundColor: LIGHT_GRAY,
                    radius: 5.0,
                    child: CircleAvatar(
                      backgroundColor: BG_COLOR,
                      radius: 4.0,
                    ),
                  ),
                  ordered && !isLast
                      ? Row(
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
                              onTap: setRouteController.checkedType.value ==
                                      "Quest"
                                  ? () {
                                      Get.to(() => TransitionPage(index));
                                    }
                                  : null,
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            index == 0
                                                ? SvgPicture.asset(
                                                    "assets/icons/start_icon.svg",
                                                    height: 16.0,
                                                  )
                                                : Text(
                                                    "$index",
                                                    style:
                                                        MAIN_TEXT_STYLE_BLACK,
                                                  ),
                                            Icon(Icons.arrow_right_alt),
                                            index ==
                                                    setRouteController
                                                            .cps.length -
                                                        2
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
                                                    style:
                                                        MAIN_TEXT_STYLE_BLACK,
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    RoundedContainer(
                                      height: 30.0,
                                      color: FILL_GRAY,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        child: showInfo
                                            ? Row(
                                                children: [
                                                  Text(
                                                    "${setRouteController.transitions[index]["distance"].toInt()}",
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
                                    RoundedContainer(
                                      color: Colors.transparent,
                                      height: 30.0,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        child: showInfo
                                            ? Row(
                                                children: [
                                                  Text(
                                                    "${setRouteController.transitions[index]["angle"].toInt()}",
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
              )
            : Container(),
      ],
    );
  }
}
