import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/dMedal.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/help_page.dart';
import 'package:orienteering_ar_athlete/pages/global_components/medal.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_athlete/pages/medals/controllers/medals_controller.dart';
import 'package:orienteering_ar_athlete/pages/medals/views/medals_filter_page.dart';
import 'package:orienteering_ar_athlete/pages/medals/views/priority_dialog.dart';

// ignore: must_be_immutable
class MedalsPage extends StatelessWidget {
  static String id = "/medals";
  MedalsController medalsController = Get.put(MedalsController());
  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      withListView: false,
      header: Header(
        middleWidget: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                mainController.profileAvatarLink.value,
              ),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              mainController.profileLogin.value,
              style: MAIN_TEXT_STYLE_BLACK,
            ),
          ],
        ),
        rightWidget: InkWell(
          onTap: () {
            Get.toNamed(HelpPage.id);
          },
          child: SvgPicture.asset("assets/icons/share_icon.svg"),
        ),
      ),
      children: [
        Expanded(
          child: medalsController.medals.value.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: Get.height / 3.5,
                    ),
                    Image.asset(
                      "assets/images/no_medals_img.png",
                      width: Get.width / 1.5,
                    ),
                    Text(
                      "No medals yet...".tr,
                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                          color: LIGHT_GRAY_TEXT),
                    )
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => InkWell(
                            onTap: () {
                              Get.to(MedalsFilterPage());
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 7.0,
                                    bottom: 7.0,
                                    right: 7.0,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/filter_icon.svg',
                                    color:
                                        medalsController.filteredCount.value > 0
                                            ? GREEN
                                            : null,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Visibility(
                                    visible:
                                        medalsController.filteredCount.value >
                                            0,
                                    child: CircleAvatar(
                                      radius: 8.0,
                                      backgroundColor: GREEN,
                                      child: Text(
                                        "${medalsController.filteredCount.value}",
                                        style: MAIN_TEXT_STYLE_WHITE.copyWith(
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.dialog(PriorityDialog());
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/sort_icon.svg"),
                              SizedBox(
                                width: 5.0,
                              ),
                              Obx(
                                () => Text(
                                  medalsController.priorityItems[
                                      medalsController.checkedPriority.value],
                                  style: MAIN_TEXT_STYLE_BLACK,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Obx(
                      () => Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 5,
                              );
                            },
                            itemCount: medalsController.medalsRows.length,
                            itemBuilder: (_, i) {
                              return medalsController.medalsRows[i];
                            }),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
