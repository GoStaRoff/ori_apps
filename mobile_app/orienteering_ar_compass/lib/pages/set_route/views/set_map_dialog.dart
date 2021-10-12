import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_compass/pages/global_components/main_button.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/set_route/controllers/set_route_controller.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/set_map_page.dart';

// ignore: must_be_immutable
class SetMapDialog extends StatelessWidget {
  SetRouteController setRouteController = Get.find();

  pickMap() async {
    PickedFile? avatar =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (avatar != null) {
      Get.back();
      setRouteController.position = {"x": "0", "y": "0"};
      ;
      setRouteController.mapPath.value = avatar.path;
      Get.toNamed(SetMapPage.id);
    }
  }

  remove() {
    setRouteController.mapPath.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width / 8, vertical: Get.height / 4.5),
      child: RoundedContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Attention!",
              style: MAIN_TEXT_STYLE_BLACK,
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "We accept only\npdf, png, jpg files of 300 dpi",
              style:
                  MAIN_TEXT_STYLE_BLACK.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundedContainer(
              width: 200,
              color: BG_COLOR,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: ORIENT_COLOR,
                      child: SvgPicture.asset(
                        "assets/icons/arrow_up_icon.svg",
                        height: 15.0,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "North\non your map",
                      style: MAIN_TEXT_STYLE_BLACK,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Scale 1:",
                  style: MAIN_TEXT_STYLE_BLACK,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: 70.0,
                  child: CustomInput(
                    height: 50.0,
                    color: BG_COLOR,
                    controller: setRouteController.mapScaleTextController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "000",
                  style: MAIN_TEXT_STYLE_BLACK,
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Obx(
              () => setRouteController.mapPath.value != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainButton(
                          text: "Remove".tr,
                          onPressed: remove,
                          isActive: true,
                          width: 120.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        MainButton(
                          text: "Change start".tr,
                          onPressed: () {
                            Get.toNamed(SetMapPage.id);
                          },
                          isActive: true,
                          width: 120.0,
                        ),
                      ],
                    )
                  : MainButton(
                      text: "Upload".tr,
                      onPressed: pickMap,
                      isActive: true,
                      width: 120.0,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
