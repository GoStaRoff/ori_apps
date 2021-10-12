import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/global_components/texted_checkbox.dart';
import 'package:orienteering_ar_compass/pages/routes/controllers/routes_controller.dart';

// ignore: must_be_immutable
class RoutesFilterPage extends StatelessWidget {
  static String id = '/routes_filter';
  RoutesController routesController = Get.find();
  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      fab: FloatingActionButton(
        onPressed: () {
          routesController.setFilterRoutes();
          Get.back();
        },
        backgroundColor: ORIENT_COLOR,
        child: Text(
          "Show".tr,
          style: MAIN_TEXT_STYLE_WHITE.copyWith(fontSize: 12.0),
        ),
      ),
      header: Header(
        leftWidget: InkWell(
          onTap: Get.back,
          child: SvgPicture.asset("assets/icons/close_icon.svg"),
        ),
        middleWidget: Text(
          "Filter".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        rightWidget: InkWell(
          onTap: routesController.reset,
          child: Text(
            "Reset",
            style: MAIN_TEXT_STYLE_BLACK.copyWith(
              fontSize: 14.0,
            ),
          ),
        ),
      ),
      children: [
        SizedBox(
          height: 30.0,
        ),
        Text(
          "BEGINNING".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        InkWell(
          onTap: () {
            routesController.selectDate(context);
          },
          child: RoundedContainer(
            height: 45.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => routesController.beginningDate.value == DateTime(0)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Day of beginning".tr,
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(
                              color: LIGHT_GRAY_TEXT,
                            ),
                          ),
                          SvgPicture.asset("assets/icons/calendar_icon.svg"),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat("dd-MM-yyyy")
                                .format(routesController.beginningDate.value),
                            style: MAIN_TEXT_STYLE_BLACK,
                          ),
                          SvgPicture.asset(
                            "assets/icons/calendar_icon.svg",
                            color: DARK_BROWN,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextedCheckBox(
                  text: "All".tr,
                  checked:
                      routesController.checkedTypeOpenFilter.value == "All",
                  onTap: () {
                    routesController.checkedTypeOpenFilter.value = "All";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Open".tr,
                  checked:
                      routesController.checkedTypeOpenFilter.value == "Open",
                  onTap: () {
                    routesController.checkedTypeOpenFilter.value = "Open";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Close".tr,
                  checked:
                      routesController.checkedTypeOpenFilter.value == "Close",
                  onTap: () {
                    routesController.checkedTypeOpenFilter.value = "Close";
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "SALES".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextedCheckBox(
                  text: "All".tr,
                  checked: routesController.checkedSalesFilter.value == "All",
                  onTap: () {
                    routesController.checkedSalesFilter.value = "All";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "< €100",
                  checked: routesController.checkedSalesFilter.value == "<100",
                  onTap: () {
                    routesController.checkedSalesFilter.value = "<100";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "€100-€1K",
                  checked:
                      routesController.checkedSalesFilter.value == "100-1K",
                  onTap: () {
                    routesController.checkedSalesFilter.value = "100-1K";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "€1K>",
                  checked: routesController.checkedSalesFilter.value == "1K>",
                  onTap: () {
                    routesController.checkedSalesFilter.value = "1K>";
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "PASSES".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextedCheckBox(
                  text: "All".tr,
                  checked: routesController.checkedPassesFilter.value == "All",
                  onTap: () {
                    routesController.checkedPassesFilter.value = "All";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "<100",
                  checked: routesController.checkedPassesFilter.value == "<100",
                  onTap: () {
                    routesController.checkedPassesFilter.value = "<100";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "100-1K",
                  checked:
                      routesController.checkedPassesFilter.value == "100-1K",
                  onTap: () {
                    routesController.checkedPassesFilter.value = "100-1K";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "1K>",
                  checked: routesController.checkedPassesFilter.value == "1K>",
                  onTap: () {
                    routesController.checkedPassesFilter.value = "1K>";
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "LENGTH".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextedCheckBox(
                  text: "Any".tr,
                  checked: routesController.checkedLengthFilter.value == "Any",
                  onTap: () {
                    routesController.checkedLengthFilter.value = "Any";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "<2${mainController.distance.value}",
                  checked: routesController.checkedLengthFilter.value == "<2",
                  onTap: () {
                    routesController.checkedLengthFilter.value = "<2";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "2-4${mainController.distance.value}",
                  checked: routesController.checkedLengthFilter.value == "2-4",
                  onTap: () {
                    routesController.checkedLengthFilter.value = "2-4";
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextedCheckBox(
                  text: "4-7${mainController.distance.value}",
                  checked: routesController.checkedLengthFilter.value == "4-7",
                  onTap: () {
                    routesController.checkedLengthFilter.value = "4-7";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "7${mainController.distance.value}>",
                  checked: routesController.checkedLengthFilter.value == "7>",
                  onTap: () {
                    routesController.checkedLengthFilter.value = "7>";
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "PRICE".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextedCheckBox(
                  text: "Any".tr,
                  checked: routesController.checkedPriceFilter.value == "Any",
                  onTap: () {
                    routesController.checkedPriceFilter.value = "Any";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "€0",
                  checked: routesController.checkedPriceFilter.value == "0",
                  onTap: () {
                    routesController.checkedPriceFilter.value = "0";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "<€3",
                  checked: routesController.checkedPriceFilter.value == "<3",
                  onTap: () {
                    routesController.checkedPriceFilter.value = "<3";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "€3-9",
                  checked: routesController.checkedPriceFilter.value == "3-9",
                  onTap: () {
                    routesController.checkedPriceFilter.value = "3-9";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "€9>",
                  checked: routesController.checkedPriceFilter.value == "9>",
                  onTap: () {
                    routesController.checkedPriceFilter.value = "9>";
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "TYPE".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextedCheckBox(
                  text: "Any".tr,
                  checked: routesController.checkedTypeFilter.value == "Any",
                  onTap: () {
                    routesController.checkedTypeFilter.value = "Any";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Orient".tr,
                  checked: routesController.checkedTypeFilter.value == "Orient",
                  onTap: () {
                    routesController.checkedTypeFilter.value = "Orient";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Quest".tr,
                  checked: routesController.checkedTypeFilter.value == "Quest",
                  onTap: () {
                    routesController.checkedTypeFilter.value = "Quest";
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextedCheckBox(
                  text: "Detective".tr,
                  checked:
                      routesController.checkedTypeFilter.value == "Detective",
                  onTap: () {
                    routesController.checkedTypeFilter.value = "Detective";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Rogaine".tr,
                  checked:
                      routesController.checkedTypeFilter.value == "Rogaine",
                  onTap: () {
                    routesController.checkedTypeFilter.value = "Rogaine";
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "THEMES".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextedCheckBox(
                  text: "All".tr,
                  checked: routesController.checkedThemesFilter.value == "All",
                  onTap: () {
                    routesController.checkedThemesFilter.value = "All";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Science".tr,
                  checked:
                      routesController.checkedThemesFilter.value == "Science",
                  onTap: () {
                    routesController.checkedThemesFilter.value = "Science";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Art".tr,
                  checked: routesController.checkedThemesFilter.value == "Art",
                  onTap: () {
                    routesController.checkedThemesFilter.value = "Art";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Sport".tr,
                  checked:
                      routesController.checkedThemesFilter.value == "Sport",
                  onTap: () {
                    routesController.checkedThemesFilter.value = "Sport";
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextedCheckBox(
                  text: "Geo".tr,
                  checked: routesController.checkedThemesFilter.value == "Geo",
                  onTap: () {
                    routesController.checkedThemesFilter.value = "Geo";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Language".tr,
                  checked:
                      routesController.checkedThemesFilter.value == "Language",
                  onTap: () {
                    routesController.checkedThemesFilter.value = "Language";
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80.0,
        ),
      ],
    );
  }
}
