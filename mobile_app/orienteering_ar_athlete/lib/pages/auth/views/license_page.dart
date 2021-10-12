import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/pages/auth/controllers/auth_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/bottom_rounded_container.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_checkbox.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_list_view.dart';
import 'package:orienteering_ar_athlete/pages/global_components/main_button.dart';

class LicensePages extends StatelessWidget {
  static String id = "/license";
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();

    return Scaffold(
      backgroundColor: BG_COLOR,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: CustomListView(
                  children: [
                    Obx(
                      () => Html(
                        data: authController.licenses.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomRoundedContainer(
              height: 190,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 25.0),
                child: Obx(
                  () => Column(
                    children: [
                      CustomCheckBox(
                        text: "I agree PP...".tr,
                        isChecked: authController.agreementPP.value,
                        onChanged: () {
                          authController.changeAgreementPP();
                        },
                      ),
                      CustomCheckBox(
                        text: "I agree UA...".tr,
                        isChecked: authController.agreementUA.value,
                        onChanged: () {
                          authController.changeAgreementUA();
                        },
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 60.0,
                          ),
                          Expanded(
                            child: MainButton(
                              text: "OK".tr,
                              isActive: true,
                              onPressed: () {
                                Get.back(closeOverlays: true);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 60.0,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
