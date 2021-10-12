import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/pages/global_components/main_button.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';

// ignore: must_be_immutable
class RemoveCommentDialog extends StatelessWidget {
  var remove;

  RemoveCommentDialog({this.remove});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RoundedContainer(
        height: Get.height / 5,
        width: Get.width / 1.3,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Remove comment?".tr,
                  style: MAIN_TEXT_STYLE_BLACK,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: Get.back,
                      child: Container(
                        width: 100.0,
                        height: 45.0,
                        child: Center(
                          child: Text(
                            "No".tr,
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                color: LIGHT_GRAY_TEXT),
                          ),
                        ),
                      ),
                    ),
                    MainButton(
                      width: 100.0,
                      text: "Yes".tr,
                      onPressed: remove,
                      isActive: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
