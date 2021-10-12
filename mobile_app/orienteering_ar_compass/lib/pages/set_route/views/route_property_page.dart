import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_compass/pages/global_components/texted_checkbox.dart';
import 'package:orienteering_ar_compass/pages/set_route/components/pictured_checkbox.dart';
import 'package:orienteering_ar_compass/pages/set_route/controllers/set_route_controller.dart';

// ignore: must_be_immutable
class RoutePropertyPage extends StatelessWidget {
  static String id = "/route_property";
  SetRouteController setRouteController = Get.find();
  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      fab: FloatingActionButton(
        backgroundColor: ORIENT_COLOR,
        onPressed: Get.back,
        child: Text(
          "OK",
          style: MAIN_TEXT_STYLE_WHITE,
        ),
      ),
      header: Header(
        middleWidget: Text(
          "Route ID: ".tr +
              mainController.profileLogin.value +
              "-" +
              mainController.lastRoute.toString(),
          style: MAIN_TEXT_STYLE_BLACK,
        ),
      ),
      children: [
        SizedBox(
          height: 30.0,
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: TextedCheckBox(
                  text: "Open".tr,
                  checked: setRouteController.checkedTypeOpen.value == "Open",
                  onTap: () {
                    setRouteController.checkedTypeOpen.value = "Open";
                  },
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Closed".tr,
                  checked: setRouteController.checkedTypeOpen.value == "Closed",
                  onTap: () {
                    setRouteController.checkedTypeOpen.value = "Closed";
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
                  text: "Orienteering".tr,
                  checked: setRouteController.checkedType.value == "Orient",
                  onTap: () {
                    setRouteController.checkedType.value = "Orient";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Rogaine".tr,
                  checked: setRouteController.checkedType.value == "Rogaine",
                  onTap: () {
                    setRouteController.checkedType.value = "Rogaine";
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
                  checked: setRouteController.checkedType.value == "Detective",
                  onTap: () {
                    setRouteController.checkedType.value = "Detective";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Quest".tr,
                  checked: setRouteController.checkedType.value == "Quest",
                  onTap: () {
                    setRouteController.checkedType.value = "Quest";
                  },
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Visibility(
            visible: setRouteController.checkedType.value == "Quest",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          text: "Science".tr,
                          checked: setRouteController.checkedThemes.value ==
                              "Science",
                          onTap: () {
                            setRouteController.checkedThemes.value = "Science";
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: TextedCheckBox(
                          text: "Geo".tr,
                          checked:
                              setRouteController.checkedThemes.value == "Geo",
                          onTap: () {
                            setRouteController.checkedThemes.value = "Geo";
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: TextedCheckBox(
                          text: "Art".tr,
                          checked:
                              setRouteController.checkedThemes.value == "Art",
                          onTap: () {
                            setRouteController.checkedThemes.value = "Art";
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
                          text: "Sport".tr,
                          checked:
                              setRouteController.checkedThemes.value == "Sport",
                          onTap: () {
                            setRouteController.checkedThemes.value = "Sport";
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: TextedCheckBox(
                          text: "Language".tr,
                          checked: setRouteController.checkedThemes.value ==
                              "Language",
                          onTap: () {
                            setRouteController.checkedThemes.value = "Language";
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "METHOD".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              PicturedCheckBox(
                picturePath: "assets/icons/runner_icon.svg",
                checked: setRouteController.checkedMethod.value == "Runner",
                onTap: () {
                  setRouteController.checkedMethod.value = "Runner";
                },
              ),
              SizedBox(
                width: 20.0,
              ),
              PicturedCheckBox(
                picturePath: "assets/icons/bike_icon.svg",
                checked: setRouteController.checkedMethod.value == "Bike",
                onTap: () {
                  setRouteController.checkedMethod.value = "Bike";
                },
              ),
              SizedBox(
                width: 20.0,
              ),
              PicturedCheckBox(
                picturePath: "assets/icons/ski_icon.svg",
                checked: setRouteController.checkedMethod.value == "Ski",
                onTap: () {
                  setRouteController.checkedMethod.value = "Ski";
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "TERRA".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              PicturedCheckBox(
                picturePath: "assets/icons/forest_icon.svg",
                checked: setRouteController.checkedTerra.value == "Forest",
                onTap: () {
                  setRouteController.checkedTerra.value = "Forest";
                },
              ),
              SizedBox(
                width: 20.0,
              ),
              PicturedCheckBox(
                picturePath: "assets/icons/city_icon.svg",
                checked: setRouteController.checkedTerra.value == "City",
                onTap: () {
                  setRouteController.checkedTerra.value = "City";
                },
              ),
              SizedBox(
                width: 20.0,
              ),
              PicturedCheckBox(
                picturePath: "assets/icons/park_icon.svg",
                checked: setRouteController.checkedTerra.value == "Park",
                onTap: () {
                  setRouteController.checkedTerra.value = "Park";
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "PENALTY".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Row(
            children: [
              Text(
                "Hint usage".tr,
                style: MAIN_TEXT_STYLE_BLACK,
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                width: 80,
                child: CustomInput(
                  onChanged: (value) {
                    setRouteController.hintText.value = value;
                  },
                  initialValue: setRouteController.hintText.value,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "min".tr,
                style: MAIN_TEXT_STYLE_BLACK,
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
              Text(
                "€",
                style: MAIN_TEXT_STYLE_BLACK,
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                width: 140,
                child: CustomInput(
                  initialValue: setRouteController.priceText.value,
                  onChanged: (value) {
                    setRouteController.priceText.value = value;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "per 1 pass".tr,
                style: MAIN_TEXT_STYLE_BLACK,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
