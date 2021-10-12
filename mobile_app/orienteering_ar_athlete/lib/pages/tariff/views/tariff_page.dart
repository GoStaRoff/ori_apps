import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/loader_indicator.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_athlete/pages/tariff/components/tariff_container.dart';
import 'package:orienteering_ar_athlete/pages/tariff/controllers/tariff_controller.dart';

// ignore: must_be_immutable
class TariffPage extends StatelessWidget {
  static String id = "/tariff";
  MainController mainController = Get.find();
  TariffController tariffController = Get.put(TariffController());

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      fab: FloatingActionButton(
        backgroundColor: ORIENT_COLOR,
        child: Text("POLY"),
        onPressed: () {
          // Get.to(PolygonScreen());
        },
      ),
      header: Header(
        middleWidget: Text(
          "Tariff Plan".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
      ),
      children: [
        Obx(
          () => tariffController.tariffLoading.value
              ? Column(
                  children: [
                    SizedBox(
                      height: Get.height / 3,
                    ),
                    Center(child: LoaderIndicator()),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 25.0,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     mainController.profileTariffTill.value = "";
                    //     mainController.profileTariff.value = "FREE";
                    //   },
                    //   child: RoundedContainer(
                    //     height: 55.0,
                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 30.0),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Obx(
                    //             () => Row(
                    //               children: [
                    //                 Text(
                    //                   tariffController.tariffList[0]["name"],
                    //                   style: MAIN_TEXT_STYLE_BLACK,
                    //                 ),
                    //                 SizedBox(
                    //                   width: 5.0,
                    //                 ),
                    //                 mainController.profileTariff.value ==
                    //                     tariffController.tariffList[0]["name"] ||
                    //                         mainController.profileTariff.value
                    //                                 .length ==
                    //                             0
                    //                     ? Text(
                    //                         "- current".tr,
                    //                         style: MAIN_TEXT_STYLE_BLACK
                    //                             .copyWith(color: GREEN),
                    //                       )
                    //                     : Container(),
                    //               ],
                    //             ),
                    //           ),
                    //           Row(
                    //             crossAxisAlignment: CrossAxisAlignment.end,
                    //             children: [
                    //               Text(
                    //                 "EARN".tr,
                    //                 style: MAIN_TEXT_STYLE_BLACK.copyWith(
                    //                     fontSize: 14.0),
                    //               ),
                    //               SizedBox(
                    //                 width: 5.0,
                    //               ),
                    //               Percent(
                    //                 count: int.parse(tariffController
                    //                     .tariffList[0]["hints"]),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Obx(
                      () => TariffContainer(
                        onTap: () {
                          tariffController.setTariff("FREE", 0, "");
                        },
                        color: LIGHT_GRAY,
                        selected: mainController.profileTariff.value ==
                            tariffController.tariffList[0]["name"],
                        name: tariffController.tariffList[0]["name"],
                        tillDate: mainController.profileTariff.value ==
                                tariffController.tariffList[0]["name"]
                            ? mainController.profileTariffTill.value
                            : "",
                        percent: tariffController.tariffList[0]["hints"],
                        twelveMonth: double.parse(
                            tariffController.tariffList[0]["year_price"]),
                        sixMonth: double.parse(
                            tariffController.tariffList[0]["half_year_price"]),
                        oneMonth: double.parse(
                            tariffController.tariffList[0]["month_price"]),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Obx(
                      () => TariffContainer(
                        color: ORIENT_COLOR,
                        selected: mainController.profileTariff.value ==
                            tariffController.tariffList[1]["name"],
                        name: tariffController.tariffList[1]["name"],
                        tillDate: mainController.profileTariff.value ==
                                tariffController.tariffList[1]["name"]
                            ? mainController.profileTariffTill.value
                            : "",
                        percent: tariffController.tariffList[1]["hints"],
                        twelveMonth: double.parse(
                            tariffController.tariffList[1]["year_price"]),
                        sixMonth: double.parse(
                            tariffController.tariffList[1]["half_year_price"]),
                        oneMonth: double.parse(
                            tariffController.tariffList[1]["month_price"]),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Obx(
                      () => TariffContainer(
                        name: tariffController.tariffList[2]["name"],
                        color: ORANGE,
                        selected: mainController.profileTariff.value ==
                            tariffController.tariffList[2]["name"],
                        tillDate: mainController.profileTariff.value ==
                                tariffController.tariffList[2]["name"]
                            ? mainController.profileTariffTill.value
                            : "",
                        percent: tariffController.tariffList[2]["hints"],
                        twelveMonth: double.parse(
                            tariffController.tariffList[2]["year_price"]),
                        sixMonth: double.parse(
                            tariffController.tariffList[2]["half_year_price"]),
                        oneMonth: double.parse(
                            tariffController.tariffList[2]["month_price"]),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Obx(
                      () => TariffContainer(
                        color: LIGHT_RED,
                        selected: mainController.profileTariff.value ==
                            tariffController.tariffList[3]["name"],
                        name: tariffController.tariffList[3]["name"],
                        tillDate: mainController.profileTariff.value ==
                                tariffController.tariffList[3]["name"]
                            ? mainController.profileTariffTill.value
                            : "",
                        percent: tariffController.tariffList[3]["hints"],
                        twelveMonth: double.parse(
                            tariffController.tariffList[3]["year_price"]),
                        sixMonth: double.parse(
                            tariffController.tariffList[3]["half_year_price"]),
                        oneMonth: double.parse(
                            tariffController.tariffList[3]["month_price"]),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
