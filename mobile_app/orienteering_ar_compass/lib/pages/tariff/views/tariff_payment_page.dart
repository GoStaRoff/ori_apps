import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/main_button.dart';
import 'package:orienteering_ar_compass/pages/global_components/money.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_padding.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';

// ignore: must_be_immutable
class TariffPaymentPage extends StatefulWidget {
  static String id = "/tariff_payment";

  final String price;
  final Color color;
  final String name;
  final int monthCount;

  TariffPaymentPage({
    required this.price,
    required this.name,
    required this.color,
    required this.monthCount,
  });

  @override
  _TariffPaymentPageState createState() => _TariffPaymentPageState();
}

class _TariffPaymentPageState extends State<TariffPaymentPage> {
  MainController mainController = Get.find();
  bool buyLoading = false;

  @override
  Widget build(BuildContext context) {
    String till = Jiffy().add(months: widget.monthCount).format("yyyy-MM-dd");
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: MultipleRoundedCurveClipper(),
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: PagePadding(
                  child: Column(
                    children: [
                      Header(
                        middleWidget: Text(
                          "Payment".tr,
                          style: MAIN_TEXT_STYLE_BLACK,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Column(
                          children: [
                            Money(
                              count: widget.price,
                              fontSize: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.name,
                                  style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                      color: widget.color),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "till ".tr + till,
                                  style: MAIN_TEXT_STYLE_BLACK,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: PagePadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FOR".tr,
                    style: MAIN_TEXT_STYLE_BLACK,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RoundedContainer(
                    width: Get.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: Row(
                        children: [
                          Text(widget.name + " tariff".tr),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedContainer(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NUM CARD",
                            style: MAIN_TEXT_STYLE_BLACK,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          CustomInput(
                            color: BG_COLOR,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "EXP DATE",
                                      style: MAIN_TEXT_STYLE_BLACK,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomInput(
                                      color: BG_COLOR,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "CVV",
                                      style: MAIN_TEXT_STYLE_BLACK,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CustomInput(
                                      color: BG_COLOR,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset("assets/icons/applepay_logo_icon.svg"),
                      SvgPicture.asset("assets/icons/gpay_logo_icon.svg"),
                      SvgPicture.asset("assets/icons/samsung_logo_icon.svg"),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: MainButton(
                      text: "Buy".tr,
                      onPressed: () async {
                        buyLoading = true;
                        var result = await OriApi.setTariff(
                            mainController.getProfileID(),
                            widget.name,
                            widget.monthCount);
                        if (result.data[0]['error'].toString() != "true") {
                          mainController.profileTariffTill.value = till;
                          mainController.profileTariff.value = widget.name;
                          buyLoading = false;
                        } else {
                          Get.snackbar(
                              "Error".tr,
                              result.data[0][
                                  'description']); // Вывод на ошибку корректности данных
                        }
                        Get.back();
                      },
                      isActive: !buyLoading,
                      width: 150.0,
                    ),
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
