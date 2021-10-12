import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/auth/components/auth_button.dart';
import 'package:orienteering_ar_compass/pages/auth/controllers/auth_controller.dart';
import 'package:orienteering_ar_compass/pages/auth/views/license_page.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_wrapper.dart';

class EmailAuthPage extends StatelessWidget {
  static String registrationId = "/emailRegister";
  static String loginId = "/emailLogin";

  final bool isAuth;

  EmailAuthPage({required this.isAuth});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Stack(
      children: [
        PageWrapper(
          children: [
            SizedBox(
              height: 60.0,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "glad1",
                    transitionOnUserGestures: true,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        "Glad to ".tr,
                        style: AUTH_TITLE_TEXT_STYLE,
                      ),
                    ),
                  ),
                  Hero(
                    tag: "glad2",
                    transitionOnUserGestures: true,
                    child: Material(
                      type: MaterialType.transparency, // likely needed
                      child: Text(
                        "meet you!".tr,
                        style: AUTH_TITLE_TEXT_STYLE,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Hero(
              tag: "logo",
              child: Container(
                height: 100,
                width: 100,
                child: SvgPicture.asset("assets/icons/ar_logo_icon.svg"),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Column(
              children: [
                CustomInput(
                  controller: authController.emailEditingController.value,
                  hintText: "Email".tr,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20.0,
                ),
                CustomInput(
                  controller: authController.passwordEditingController.value,
                  hintText: "Password".tr,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            if (isAuth)
              Hero(
                tag: "login",
                child: Material(
                  type: MaterialType.transparency,
                  child: AuthButton(
                    onTap: () {
                      if (authController
                                  .emailEditingController.value.text.length ==
                              0 ||
                          authController.passwordEditingController.value.text
                                  .length ==
                              0) {
                        Get.snackbar(
                            "Warning".tr, "Please, fill all fields".tr);
                      } else {
                        authController.signInWithEmail();
                      }
                    },
                    text: "Sign in with email".tr,
                    backgroundColor: LIGHT_GRAY,
                    rightChild: CircleAvatar(
                      backgroundColor: LIGHT_GRAY,
                      child:
                          SvgPicture.asset("assets/icons/email_black_icon.svg"),
                    ),
                  ),
                ),
              )
            else
              Column(
                children: [
                  Obx(
                    () => Hero(
                      tag: "licenses",
                      child: Material(
                        type: MaterialType.transparency,
                        child: AuthButton(
                          onTap: () {
                            Get.toNamed(LicensePages.id);
                          },
                          text: "Accept PP and UA".tr,
                          backgroundColor: LIGHT_GRAY,
                          rightChild: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    authController.agreementPP.value
                                        ? GREEN
                                        : DARK_BROWN,
                                child: SvgPicture.asset(
                                    "assets/icons/check_icon.svg"),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CircleAvatar(
                                backgroundColor:
                                    authController.agreementUA.value
                                        ? GREEN
                                        : DARK_BROWN,
                                child: SvgPicture.asset(
                                    "assets/icons/check_icon.svg"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Hero(
                    tag: "register",
                    child: Material(
                      type: MaterialType.transparency,
                      child: AuthButton(
                        onTap: () {
                          if (authController.emailEditingController.value.text
                                      .length ==
                                  0 ||
                              authController.passwordEditingController.value
                                      .text.length ==
                                  0) {
                            Get.snackbar(
                                "Warning".tr, "Please, fill all fields".tr);
                          } else if (!authController.agreementUA.value ||
                              !authController.agreementPP.value) {
                            Get.snackbar("Warning".tr,
                                "Please, accept Policy and Agreement".tr);
                          } else {
                            authController.signUpWithEmail();
                          }
                        },
                        text: "Create new account".tr,
                        backgroundColor: GREEN,
                        rightChild: CircleAvatar(
                          backgroundColor: GREEN,
                          child:
                              SvgPicture.asset("assets/icons/email_icon.svg"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        Positioned(
          right: 113,
          top: -374,
          child: Hero(
            tag: "line",
            child: Container(
              width: 3,
              child: SvgPicture.asset("assets/icons/red_line_icon.svg"),
            ),
          ),
        ),
      ],
    );
  }
}
