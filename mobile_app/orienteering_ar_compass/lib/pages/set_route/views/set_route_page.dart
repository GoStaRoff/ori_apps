import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/math.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/cps.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_list_view.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/main_button.dart';
import 'package:orienteering_ar_compass/pages/global_components/money.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_padding.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/set_route/controllers/set_route_controller.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/cps_page.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/discard_avatar_dialog.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/route_property_page.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/set_map_dialog.dart';

// ignore: must_be_immutable
class SetRoutePage extends StatelessWidget {
  var setRouteController;
  MainController mainController = Get.find();

  SetRoutePage({required cpsList}) {
    setRouteController = Get.put(SetRouteController(cpsList));
    setRouteController.clear();
    setRouteController.transitions.clear();
    setRouteController.graph.value.edges.clear();

    for (int i = 0; i < cpsList.length - 1; i++) {
      setRouteController.transitions.add({
        "id": "$i",
        "is_full": false,
        "correct_answer": "",
        "sound": "",
        "avatar": "",
        "question": "",
        "answers": null,
        "show_info": true,
        "distance": calculateDistanceMeters(
          double.parse(cpsList[i]["lat"]),
          double.parse(cpsList[i]["lng"]),
          double.parse(cpsList[i + 1]["lat"]),
          double.parse(cpsList[i + 1]["lng"]),
        ),
        "angle": calculateAngle(
          double.parse(cpsList[i + 1]["lng"]),
          double.parse(cpsList[i]["lng"]),
          double.parse(cpsList[i + 1]["lat"]),
          double.parse(cpsList[i]["lat"]),
        ),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            PagePadding(
              child: Column(
                children: [
                  Header(
                    middleWidget: Row(
                      children: [
                        Obx(
                          () => CircleAvatar(
                            radius: 20,
                            backgroundColor: setRouteController.circleColor(),
                            child: Center(
                              child: Text(
                                setRouteController.checkedType.value[0],
                                style: MAIN_TEXT_STYLE_WHITE,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Obx(
                          () => Text(
                            mainController.profileLogin +
                                "-" +
                                mainController.lastRoute.value.toString(),
                            style: MAIN_TEXT_STYLE_BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomListView(
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        Get.toNamed(RoutePropertyPage.id);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              setRouteController.checkedTypeOpen.value,
                              style: MAIN_TEXT_STYLE_BLACK,
                            ),
                            Text(
                              setRouteController.checkedType.value,
                              style: MAIN_TEXT_STYLE_BLACK,
                            ),
                            setRouteController.showMethodPicture(),
                            setRouteController.showTerraPicture(),
                            CPS(
                              count: setRouteController.cps.length.toString(),
                            ),
                            Money(
                              count:
                                  setRouteController.priceText.value.length == 0
                                      ? "0"
                                      : setRouteController.priceText.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Obx(
                        () => setRouteController.avatarPath.value.length < 1
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: setRouteController.setRoutePicture,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 55.0,
                                        child: SvgPicture.asset(
                                          "assets/icons/camera_icon.svg",
                                          height: 40.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Stack(
                                children: [
                                  Container(
                                    height: 240.0,
                                    width: Get.width,
                                    child: Image.file(
                                      File(setRouteController.avatarPath.value),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    right: 20,
                                    top: 20,
                                    child: InkWell(
                                      onTap: () {
                                        Get.dialog(
                                          DiscardAvatarDialog(
                                            onDiscard: () {
                                              setRouteController
                                                  .avatarPath.value = "";
                                              Get.back();
                                            },
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white60,
                                        child: SvgPicture.asset(
                                            "assets/icons/trash_icon.svg"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 220.0,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 120.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    topLeft: Radius.circular(20.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      Obx(
                                        () => CircleAvatar(
                                          backgroundColor: BG_COLOR,
                                          radius: 40.0,
                                          backgroundImage: NetworkImage(
                                              setRouteController.cps[0]["photo"]
                                                          .length >
                                                      0
                                                  ? setRouteController.cps[0]
                                                      ["photo"]
                                                  : setRouteController.cps[0]
                                                      ["ar_photo"]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Obx(
                                                () => Text(
                                                  setRouteController.cps[0]
                                                      ["name"],
                                                  style: MAIN_TEXT_STYLE_BLACK
                                                      .copyWith(fontSize: 20.0),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Container(
                                                width: 20.0,
                                                height: 1.0,
                                                color: LIGHT_GRAY,
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                "Start CP".tr,
                                                style: MAIN_TEXT_STYLE_BLACK
                                                    .copyWith(fontSize: 18.0),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              RoundedContainer(
                                                height: 30.0,
                                                color: BG_COLOR,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                  ),
                                                  child: Obx(
                                                    () => Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            "assets/icons/google_maps_logo.svg"),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        Text(
                                                          setRouteController
                                                              .cps[0]["lat"]
                                                              .toString(),
                                                          style:
                                                              MAIN_TEXT_STYLE_BLACK
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12.0),
                                                        ),
                                                        SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                          setRouteController
                                                              .cps[0]["lng"]
                                                              .toString(),
                                                          style:
                                                              MAIN_TEXT_STYLE_BLACK
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 56.0,
                            color: Colors.white,
                            child: CustomInput(
                              style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                  fontSize: 24.0),
                              hintText: "ROUTE NAME",
                              controller:
                                  setRouteController.routeNameTextController,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(20),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Obx(
                            () => Container(
                              height: 130.0,
                              color: Colors.white,
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Get.dialog(SetMapDialog());
                                  },
                                  child: setRouteController.mapPath.value == ""
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                "assets/icons/map_dashed_border.svg"),
                                            Positioned(
                                              top: 20.0,
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: LIGHT_GRAY,
                                                    radius: 13.0,
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Add your map".tr,
                                                    style: MAIN_TEXT_STYLE_BLACK
                                                        .copyWith(
                                                            color:
                                                                LIGHT_GRAY_TEXT),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(
                                          width: Get.width / 1.1,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(
                                                    setRouteController
                                                        .mapPath.value))),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(CPSPage.id);
                            },
                            child: Container(
                              height: 56.0,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "CPs".tr,
                                      style: MAIN_TEXT_STYLE_BLACK,
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/arrow_icon.svg",
                                      height: 12.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 140.0,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomInput(
                                      hintText: "Description here...".tr,
                                      color: BG_COLOR,
                                      height: 100.0,
                                      controller: setRouteController
                                          .descriptionTextController,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: setRouteController.clear,
                                child: Container(
                                  width: 150.0,
                                  height: 45.0,
                                  child: Center(
                                    child: Text(
                                      "Clear all".tr,
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          color: LIGHT_GRAY_TEXT),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => MainButton(
                                  width: 150.0,
                                  text: "Save".tr,
                                  onPressed: () {
                                    setRouteController.save();
                                    // ignore: unnecessary_statements
                                  },
                                  isActive: !setRouteController.saving.value,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
