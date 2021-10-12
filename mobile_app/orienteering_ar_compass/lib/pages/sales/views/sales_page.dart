import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_list_item.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/money.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_padding.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/sales/components/month_card.dart';
import 'package:orienteering_ar_compass/pages/sales/controllers/sales_controller.dart';
import 'package:orienteering_ar_compass/pages/sales/views/sales_payment_page.dart';
import 'package:orienteering_ar_compass/pages/tariff/views/tariff_page.dart';

// ignore: must_be_immutable
class SalesPage extends StatelessWidget {
  static String id = "/sales";
  MainController mainController = Get.find();
  SalesController salesController = Get.put(SalesController());

  showContainer() {
    Color color = LIGHT_GRAY; // Цвет контейнера про тариф
    if (mainController.tariffList[1]["name"] ==
        mainController.profileTariff.value) {
      color = ORIENT_COLOR;
    } else if (mainController.tariffList[2]["name"] ==
        mainController.profileTariff.value) {
      color = ORANGE;
    } else if (mainController.tariffList[3]["name"] ==
        mainController.profileTariff.value) {
      color = LIGHT_RED;
    }
    return Container(
      width: 80.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      child: Center(
        child: Text(
          mainController.profileTariff.value,
          style: MAIN_TEXT_STYLE_WHITE,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ORIENT_COLOR,
        onPressed: salesController.scrollToStart,
        child: Container(
          height: 20.0,
          width: 20.0,
          child: SvgPicture.asset("assets/icons/arrow_up_icon.svg"),
        ),
      ),
      backgroundColor: BG_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            PagePadding(
              child: Header(
                middleWidget: InkWell(
                  onTap: () {
                    Get.toNamed(TariffPage.id);
                  },
                  child: RoundedContainer(
                    height: 45.0,
                    width: 230.0,
                    child: Row(
                      children: [
                        Obx(
                          () => showContainer(),
                        ),
                        Expanded(
                          child: Center(
                            child: Text("Change plan\nto EARN MORE".tr),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(SalesPaymentPage.id);
              },
              child: Obx(
                () => PagePadding(
                  child: mainController.payseraAddress.value.length < 1
                      ? Row(
                          children: [
                            Text(
                              "No payment system account! ".tr,
                              style: MAIN_TEXT_STYLE_WHITE.copyWith(
                                  color: LIGHT_RED, fontSize: 13.0),
                            ),
                            Text(
                              "Set".tr,
                              style: MAIN_TEXT_STYLE_WHITE.copyWith(
                                color: LIGHT_RED,
                                fontSize: 13.0,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              "Your".tr,
                              style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                  fontSize: 13.0),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Image.asset("assets/images/paysera_logo2.png"),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "account".tr,
                              style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                  fontSize: 13.0),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              height: 70.0,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Money(
                          count: "123.35",
                        ),
                        Text(
                          "To be paid".tr,
                          style: MAIN_TEXT_STYLE_BLACK.copyWith(
                            color: LIGHT_GRAY_TEXT,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50.0,
                      width: 1.0,
                      color: BG_COLOR,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Money(
                          count: "250.35",
                        ),
                        Text(
                          "Total paid".tr,
                          style: MAIN_TEXT_STYLE_BLACK.copyWith(
                            color: LIGHT_GRAY_TEXT,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 80.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 5,
                              );
                            },
                            itemCount: 10,
                            itemBuilder: (_, i) =>
                                MonthCard(month: "March", year: "$i")),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      color: BG_COLOR,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total April - Free plan (20%)",
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(color: GREEN),
                          ),
                          Text(
                            "€103.96",
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(color: GREEN),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1.0,
                      color: BG_COLOR,
                    ),
                    Expanded(
                      child: ListView.separated(
                        controller: salesController.scrollController,
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 5,
                          );
                        },
                        itemCount: 10,
                        itemBuilder: (_, i) => CustomListItem(
                          rightChild: Text(
                            "$i",
                            style: MAIN_TEXT_STYLE_BLACK,
                          ),
                          leftChild: Text(
                            "Boris 109-1",
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
        ),
      ),
    );
  }
}
