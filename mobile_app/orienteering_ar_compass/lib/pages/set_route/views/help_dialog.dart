import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';

class HelpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Material(
            color: Colors.transparent,
            child: RoundedContainer(
              height: Get.height / 2,
              width: Get.width / 1.2,
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Material(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Image.asset("assets/images/pin_img.png"),
                      SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "To set a new route".tr,
                              style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "Tap CP consistently".tr,
                              style: MAIN_TEXT_STYLE_BLACK,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "First CP - START".tr,
                              style: MAIN_TEXT_STYLE_BLACK,
                            ),
                            Text(
                              "Last CP - FINISH".tr,
                              style: MAIN_TEXT_STYLE_BLACK,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Done? Click".tr,
                                  style: MAIN_TEXT_STYLE_BLACK,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                RoundedContainer(
                                  color: BG_COLOR,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Text(
                                      "Set route".tr,
                                      style: MAIN_TEXT_STYLE_BLACK,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
