import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_athlete/pages/global_components/texted_checkbox.dart';
import 'package:orienteering_ar_athlete/pages/medals/controllers/medals_controller.dart';
import 'package:orienteering_ar_athlete/pages/routes/controllers/routes_controller.dart';

// ignore: must_be_immutable
class MedalsFilterPage extends StatelessWidget {
  static String id = '/routes_filter';
  MedalsController medalsController = Get.find();
  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      fab: FloatingActionButton(
        onPressed: () {
          medalsController.setFilterMedals();
          Get.back(closeOverlays: true);
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
          onTap: medalsController.reset,
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
          "DATE".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        InkWell(
          onTap: () {
            medalsController.selectDate(context);
          },
          child: RoundedContainer(
            height: 45.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => medalsController.medalDate.value == DateTime(0)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Day of receiving".tr,
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
                                .format(medalsController.medalDate.value),
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
        Text(
          "TYPE".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextedCheckBox(
                      text: "All".tr,
                      checked:
                          medalsController.checkedTypeFilter.value == "All",
                      onTap: () {
                        medalsController.checkedTypeFilter.value = "All";
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: TextedCheckBox(
                      text: "Cup".tr,
                      checked: medalsController.checkedTypeFilter.value == "0",
                      onTap: () {
                        medalsController.checkedTypeFilter.value = "0";
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: TextedCheckBox(
                      text: "1st".tr,
                      checked: medalsController.checkedTypeFilter.value == "1",
                      onTap: () {
                        medalsController.checkedTypeFilter.value = "1";
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextedCheckBox(
                      text: "10%".tr,
                      checked: medalsController.checkedTypeFilter.value == "10",
                      onTap: () {
                        medalsController.checkedTypeFilter.value = "10";
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: TextedCheckBox(
                      text: "20%".tr,
                      checked: medalsController.checkedTypeFilter.value == "20",
                      onTap: () {
                        medalsController.checkedTypeFilter.value = "20";
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: TextedCheckBox(
                      text: "50%".tr,
                      checked: medalsController.checkedTypeFilter.value == "50",
                      onTap: () {
                        medalsController.checkedTypeFilter.value = "50";
                      },
                    ),
                  ),
                ],
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
          () => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextedCheckBox(
                      text: "All".tr,
                      checked:
                          medalsController.checkedTerrainFilter.value == "All",
                      onTap: () {
                        medalsController.checkedTerrainFilter.value = "All";
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: TextedCheckBox(
                      text: "Park".tr,
                      checked:
                          medalsController.checkedTerrainFilter.value == "Park",
                      onTap: () {
                        medalsController.checkedTerrainFilter.value = "Park";
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextedCheckBox(
                      text: "City".tr,
                      checked:
                          medalsController.checkedTerrainFilter.value == "City",
                      onTap: () {
                        medalsController.checkedTerrainFilter.value = "City";
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: TextedCheckBox(
                      text: "Forest".tr,
                      checked: medalsController.checkedTerrainFilter.value ==
                          "Forest",
                      onTap: () {
                        medalsController.checkedTerrainFilter.value = "Forest";
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "BEST".tr,
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
                  checked: medalsController.checkedBestFilter.value == "All",
                  onTap: () {
                    medalsController.checkedBestFilter.value = "All";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Time".tr,
                  checked: medalsController.checkedBestFilter.value == "Runner",
                  onTap: () {
                    medalsController.checkedBestFilter.value = "Runner";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "Distance".tr,
                  checked: medalsController.checkedBestFilter.value == "CPS",
                  onTap: () {
                    medalsController.checkedBestFilter.value = "CPS";
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
          "ATHLETE PASSES".tr,
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
                  checked: medalsController.checkedAthletePasses.value == "All",
                  onTap: () {
                    medalsController.checkedAthletePasses.value = "All";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "1".tr,
                  checked: medalsController.checkedAthletePasses.value == "1",
                  onTap: () {
                    medalsController.checkedAthletePasses.value = "1";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "2".tr,
                  checked: medalsController.checkedAthletePasses.value == "2",
                  onTap: () {
                    medalsController.checkedAthletePasses.value = "2";
                  },
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: TextedCheckBox(
                  text: "3+".tr,
                  checked: medalsController.checkedAthletePasses.value == "3+",
                  onTap: () {
                    medalsController.checkedAthletePasses.value = "3+";
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
