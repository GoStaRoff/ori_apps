import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/loader_indicator.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_compass/pages/polygon/views/polygon_screen.dart';
import 'package:orienteering_ar_compass/pages/tariff/components/tariff_container.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';

// ignore: must_be_immutable
class TariffPage extends StatefulWidget {
  static String id = "/tariff";

  @override
  _TariffPageState createState() => _TariffPageState();
}

class _TariffPageState extends State<TariffPage> {
  MainController mainController = Get.find();
  GetStorage box = GetStorage();
  bool tariffLoading = false;
  var tariffList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      tariffList = mainController.tariffList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      fab: FloatingActionButton(
        backgroundColor: ORIENT_COLOR,
        child: Text("POLY"),
        onPressed: () {
          Get.to(PolygonScreen());
        },
      ),
      header: Header(
        middleWidget: Text(
          "Tariff Plan".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
      ),
      children: [
        tariffLoading
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
                  //                   tariffList[0]["name"],
                  //                   style: MAIN_TEXT_STYLE_BLACK,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5.0,
                  //                 ),
                  //                 mainController.profileTariff.value ==
                  //                     tariffList[0]["name"] ||
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
                      onTap: () async {
                        var result =
                            await OriApi.setTariff(box.read("id"), "FREE", 0);
                        if (result.data[0]['error'].toString() != "true") {
                          mainController.profileTariffTill.value = "";
                          mainController.profileTariff.value = "FREE";
                        } else {
                          Get.snackbar(
                              "Error".tr,
                              result.data[0][
                                  'description']); // Вывод на ошибку корректности данных
                        }
                        Get.back();
                      },
                      color: LIGHT_GRAY,
                      selected: mainController.profileTariff.value ==
                          tariffList[0]["name"],
                      name: tariffList[0]["name"],
                      tillDate: mainController.profileTariff.value ==
                              tariffList[0]["name"]
                          ? mainController.profileTariffTill.value
                          : "",
                      percent: tariffList[0]["hints"],
                      twelveMonth: double.parse(tariffList[0]["year_price"]),
                      sixMonth: double.parse(tariffList[0]["half_year_price"]),
                      oneMonth: double.parse(tariffList[0]["month_price"]),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Obx(
                    () => TariffContainer(
                      color: ORIENT_COLOR,
                      selected: mainController.profileTariff.value ==
                          tariffList[1]["name"],
                      name: tariffList[1]["name"],
                      tillDate: mainController.profileTariff.value ==
                              tariffList[1]["name"]
                          ? mainController.profileTariffTill.value
                          : "",
                      percent: tariffList[1]["hints"],
                      twelveMonth: double.parse(tariffList[1]["year_price"]),
                      sixMonth: double.parse(tariffList[1]["half_year_price"]),
                      oneMonth: double.parse(tariffList[1]["month_price"]),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Obx(
                    () => TariffContainer(
                      name: tariffList[2]["name"],
                      color: ORANGE,
                      selected: mainController.profileTariff.value ==
                          tariffList[2]["name"],
                      tillDate: mainController.profileTariff.value ==
                              tariffList[2]["name"]
                          ? mainController.profileTariffTill.value
                          : "",
                      percent: tariffList[2]["hints"],
                      twelveMonth: double.parse(tariffList[2]["year_price"]),
                      sixMonth: double.parse(tariffList[2]["half_year_price"]),
                      oneMonth: double.parse(tariffList[2]["month_price"]),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Obx(
                    () => TariffContainer(
                      color: LIGHT_RED,
                      selected: mainController.profileTariff.value ==
                          tariffList[3]["name"],
                      name: tariffList[3]["name"],
                      tillDate: mainController.profileTariff.value ==
                              tariffList[3]["name"]
                          ? mainController.profileTariffTill.value
                          : "",
                      percent: tariffList[3]["hints"],
                      twelveMonth: double.parse(tariffList[3]["year_price"]),
                      sixMonth: double.parse(tariffList[3]["half_year_price"]),
                      oneMonth: double.parse(tariffList[3]["month_price"]),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
