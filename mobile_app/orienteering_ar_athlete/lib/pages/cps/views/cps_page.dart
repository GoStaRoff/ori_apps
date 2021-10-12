import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/main_button.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_athlete/pages/locator/components/cps_page_widget.dart';
import 'package:orienteering_ar_athlete/pages/cps/views/give_up_dialog.dart';
import 'package:orienteering_ar_athlete/pages/cps/views/rate_page.dart';

class CPSPage extends StatefulWidget {
  @override
  _CPSPageState createState() => _CPSPageState();
}

class _CPSPageState extends State<CPSPage> {
  MainController mainController = Get.find();

  @override
  void dispose() async {
    super.dispose();

    await mainController.stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => mainController.passingRoute.value
        ? Stack(
            children: [
              PageWrapper(
                header: Header(
                  withoutBack: true,
                  // leftWidget: Obx(
                  //   () => mainController.currentRoute["route_type"] == "Rogaine"
                  //       ? Center(
                  //           child: Text(
                  //             "Rogaine sum : ${mainController.currentRoute["rogaine_sum"].value}",
                  //             style: MAIN_TEXT_STYLE_BLACK,
                  //           ),
                  //         )
                  //       : Container(
                  //           color: mainController
                  //                       .currentRoute["rogaine_sum"].value >
                  //                   0
                  //               ? null
                  //               : null,
                  //         ),
                  // ),
                  leftWidget: mainController.currentRoute["route_type"] ==
                          "Rogaine"
                      ? CircleAvatar(
                          radius: 40,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(
                                          2, 2), // changes position of shadow
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  // border: Border.all(color: ORIENT_COLOR),
                                  color: DARK_BROWN,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  "TOTAL\n${mainController.currentRoute["rogaine_sum"].value}",
                                  style: AUTH_TITLE_TEXT_STYLE.copyWith(
                                      fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  middleWidget: Obx(
                    () => Text(
                      mainController.stopWatchValue.value,
                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                children: [
                  Column(
                    children: mainController.currentRoute["route_type"] !=
                            "Detective"
                        ? List.generate(
                            mainController.currentRoute["cps"].value.length,
                            (i) => CPSPageWidget(
                              index: i,
                              ordered: mainController
                                          .currentRoute["route_type"] ==
                                      "Quest" ||
                                  mainController.currentRoute["route_type"] ==
                                      "Orient",
                              cps: mainController.currentRoute["cps"].value,
                              isActive: (mainController.currentRoute["cps"]
                                      .value)[i]["is_active"]
                                  .value,
                              transitions:
                                  mainController.currentRoute["transitions"],
                            ),
                          ).toList()
                        : List.generate(
                            mainController.currentRoute["history"].value.length,
                            (i) => CPSPageWidget(
                              index: i,
                              isActive: true,
                              ordered: false,
                              cps: mainController.currentRoute["history"].value,
                              transitions:
                                  mainController.currentRoute["transitions"],
                            ),
                          ).toList(),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Row(
                    children: [
                      Obx(
                        () => ((mainController.currentRoute["route_type"] ==
                                            "Orient" ||
                                        mainController
                                                .currentRoute["route_type"] ==
                                            "Quest") &&
                                    mainController.currentRoute["step"].value ==
                                        -1) ||
                                (mainController.currentRoute["route_type"] ==
                                        "Rogaine" &&
                                    mainController
                                            .currentRoute["rogaine_sum"].value >
                                        0) ||
                                mainController.currentRoute["next_cp"].value ==
                                    ""
                            ? SizedBox(
                                width: 40.0,
                              )
                            : Container(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                ],
              ),
              Positioned(
                bottom: 100,
                right: 20,
                child: GestureDetector(
                  onLongPress: () {
                    Get.dialog(GiveUpDialog());
                  },
                  child: RoundedContainer(
                    height: 40.0,
                    width: 100,
                    color: LIGHT_GRAY,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "Give up",
                              style:
                                  MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 10),
                            ),
                            Text(
                              "(hold 2 sec.)",
                              style:
                                  MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => ((mainController.currentRoute["route_type"] == "Orient" ||
                                mainController.currentRoute["route_type"] ==
                                    "Quest") &&
                            mainController.currentRoute["step"].value == -1) ||
                        (mainController.currentRoute["route_type"] ==
                                "Rogaine" &&
                            mainController.currentRoute["rogaine_sum"].value >
                                0) ||
                        (mainController.currentRoute["route_type"] ==
                                "Detective" &&
                            mainController.currentRoute["next_cp"].value == "")
                    ? Positioned(
                        bottom: 100,
                        left: 20,
                        child: GestureDetector(
                          onLongPress:
                              mainController.currentRoute["route_type"] !=
                                      "Rogaine"
                                  ? () {
                                      print("non rogaine");
                                    }
                                  : () {
                                      Get.to(RatePage(isFinish: true));
                                    },
                          onTap: mainController.currentRoute["route_type"] !=
                                  "Rogaine"
                              ? () {
                                  Get.to(RatePage(isFinish: false));
                                }
                              : () {
                                  print("rogaine");
                                },
                          child: RoundedContainer(
                            height: 50.0,
                            width: Get.width / 2 - 30,
                            color: ORIENT_COLOR,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child:
                                    mainController.currentRoute["route_type"] !=
                                            "Rogaine"
                                        ? Text(
                                            "Finish",
                                            style: MAIN_TEXT_STYLE_WHITE,
                                          )
                                        : Column(
                                            children: [
                                              Text(
                                                "Finish",
                                                style: MAIN_TEXT_STYLE_WHITE,
                                              ),
                                              Text(
                                                "(hold 2 sec.)",
                                                style: MAIN_TEXT_STYLE_WHITE
                                                    .copyWith(fontSize: 8),
                                              ),
                                            ],
                                          ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ),
            ],
          )
        : Container());
  }
}
