import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/main_button.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';

// ignore: must_be_immutable
class DeleteRouteDialog extends StatelessWidget {
  final Function onDiscard;
  final String routeId;

  DeleteRouteDialog({required this.onDiscard, required this.routeId});

  GetStorage box = GetStorage();
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
                  "Delete route?".tr,
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
                      onPressed: () async {
                        var result =
                            await OriApi.deleteRoute(int.parse(routeId));
                        if (result.data[0]['error'].toString() != "true") {
                          onDiscard(true);
                          Get.back();
                        } else {
                          Get.snackbar(
                              "Error".tr,
                              result.data[0][
                                  'description']); // Вывод на ошибку корректности данных
                        }
                      },
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
