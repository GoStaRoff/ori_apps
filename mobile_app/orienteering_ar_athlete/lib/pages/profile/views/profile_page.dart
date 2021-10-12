import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/counter.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_item_list.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_list_view.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_athlete/pages/medals/views/medals_page.dart';
import 'package:orienteering_ar_athlete/pages/news/views/messages_page.dart';
import 'package:orienteering_ar_athlete/pages/profile/controllers/profile_controller.dart';
import 'package:orienteering_ar_athlete/pages/settings/views/settings_page.dart';
import 'package:orienteering_ar_athlete/pages/tariff/views/tariff_page.dart';
import 'package:orienteering_ar_athlete/pages/wishes/views/wishes_page.dart';

class ProfileScreen extends StatelessWidget {
  static String id = '/profile';

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    MainController mainController = Get.find();
    return PageWrapper(
      header: Header(
        withoutBack: true,
        middleWidget: Text(
          "Athlete Profile".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        rightWidget: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          onTap: () {
            Get.toNamed(SettingsPage.id);
          },
          child: SvgPicture.asset('assets/icons/settings_icon.svg'),
        ),
      ),
      children: [
        Column(
          children: [
            SizedBox(
              height: 40.0,
            ),
            Obx(
              () => CircleAvatar(
                radius: 55.0,
                backgroundColor: Colors.white,
                backgroundImage:
                    NetworkImage(mainController.profileAvatarLink.value),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: profileController.setAvatar,
                        child: CircleAvatar(
                          radius: 18.0,
                          backgroundColor: DARK_BROWN,
                          child:
                              SvgPicture.asset("assets/icons/camera_icon.svg"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Obx(
              () => Text(
                mainController.profileLogin.value,
                style: MAIN_TEXT_STYLE_BLACK,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            RoundedContainer(
              onTap: () {
                Get.toNamed(TariffPage.id);
              },
              height: 55.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tariff Plan".tr,
                      style: MAIN_TEXT_STYLE_BLACK,
                    ),
                    Obx(
                      () => profileController.showTariff(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedContainer(
              child: Column(
                children: [
                  CustomItemList(
                    onPressed: () {
                      Get.toNamed(MedalsPage.id);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          child:
                              SvgPicture.asset("assets/icons/medal_icon.svg"),
                        ),
                        SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          "My Medals".tr,
                          style: MAIN_TEXT_STYLE_BLACK,
                        )
                      ],
                    ),
                  ),
                  CustomItemList(
                    onPressed: () {
                      Get.toNamed(MessagesPage.id);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                child: SvgPicture.asset(
                                    "assets/icons/email_black_icon.svg"),
                              ),
                              SizedBox(
                                width: 25.0,
                              ),
                              Text(
                                "News".tr,
                                style: MAIN_TEXT_STYLE_BLACK,
                              ),
                            ],
                          ),
                          Obx(
                            () => mainController.unreadMessages.value > 0
                                ? Counter(mainController.unreadMessages.value)
                                : Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomItemList(
                    onPressed: () {
                      Get.toNamed(WishesPage.id);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          child: SvgPicture.asset("assets/icons/fav_icon.svg"),
                        ),
                        SizedBox(
                          width: 25.0,
                        ),
                        Text(
                          "My Wishes".tr,
                          style: MAIN_TEXT_STYLE_BLACK,
                        )
                      ],
                    ),
                  ),
                  CustomItemList(
                    disabledLine: true,
                    onPressed: profileController.toggleInfoHeight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                child: SvgPicture.asset(
                                    "assets/icons/pers_icon.svg"),
                              ),
                              SizedBox(
                                width: 25.0,
                              ),
                              Text(
                                "Personal info".tr,
                                style: MAIN_TEXT_STYLE_BLACK,
                              ),
                            ],
                          ),
                          Obx(
                            () => profileController.showPersonalInfoArrow(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => AnimatedContainer(
                      height: profileController.infoHeight.value,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                        ),
                        color: Color(0xFFF8F8F9),
                      ),
                      duration: Duration(
                        milliseconds: 500,
                      ),
                      child: CustomListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                InkWell(
                                  onTap: profileController
                                          .settingPersonalInfo.value
                                      ? null
                                      : () {
                                          profileController.selectDate(context);
                                        },
                                  child: RoundedContainer(
                                    height: 45.0,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Obx(
                                        () => profileController.birth.value ==
                                                DateTime(1)
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Day of birth".tr,
                                                    style: MAIN_TEXT_STYLE_BLACK
                                                        .copyWith(
                                                      color: LIGHT_GRAY_TEXT,
                                                    ),
                                                  ),
                                                  SvgPicture.asset(
                                                      "assets/icons/calendar_icon.svg"),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    profileController
                                                        .getBirth(),
                                                    style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                                        color: !profileController
                                                                .settingPersonalInfo
                                                                .value
                                                            ? DARK_BROWN
                                                            : LIGHT_GRAY_TEXT),
                                                  ),
                                                  SvgPicture.asset(
                                                    "assets/icons/calendar_icon.svg",
                                                    color: !profileController
                                                            .settingPersonalInfo
                                                            .value
                                                        ? DARK_BROWN
                                                        : LIGHT_GRAY_TEXT,
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                InkWell(
                                  child: RoundedContainer(
                                    height: 45.0,
                                    width: 250.0,
                                    child: Obx(
                                      () => InkWell(
                                        onTap: profileController
                                                .settingPersonalInfo.value
                                            ? null
                                            : profileController.toggleGender,
                                        child: Stack(
                                          children: [
                                            Visibility(
                                              visible: profileController
                                                  .isGender.value,
                                              child: AnimatedPositioned(
                                                duration:
                                                    Duration(milliseconds: 400),
                                                left: profileController
                                                        .isMale.value
                                                    ? 125
                                                    : 0,
                                                child: AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  width: 125.0,
                                                  height: 45.0,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: profileController
                                                                .settingPersonalInfo
                                                                .value
                                                            ? LIGHT_GRAY_TEXT
                                                            : DARK_BROWN),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(20.0),
                                                      topRight:
                                                          profileController
                                                                  .isMale.value
                                                              ? Radius.circular(
                                                                  20.0)
                                                              : Radius.circular(
                                                                  0.0),
                                                      bottomLeft:
                                                          Radius.circular(20.0),
                                                      topLeft:
                                                          !profileController
                                                                  .isMale.value
                                                              ? Radius.circular(
                                                                  20.0)
                                                              : Radius.circular(
                                                                  0.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      "Male".tr,
                                                      style: !profileController
                                                                  .isMale
                                                                  .value &&
                                                              profileController
                                                                  .isGender
                                                                  .value
                                                          ? MAIN_TEXT_STYLE_BLACK
                                                          : MAIN_TEXT_STYLE_BLACK
                                                              .copyWith(
                                                                  color:
                                                                      LIGHT_GRAY_TEXT),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      "Female".tr,
                                                      style: profileController
                                                                  .isMale
                                                                  .value &&
                                                              profileController
                                                                  .isGender
                                                                  .value
                                                          ? MAIN_TEXT_STYLE_BLACK
                                                          : MAIN_TEXT_STYLE_BLACK
                                                              .copyWith(
                                                                  color:
                                                                      LIGHT_GRAY_TEXT),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ],
    );
  }
}
