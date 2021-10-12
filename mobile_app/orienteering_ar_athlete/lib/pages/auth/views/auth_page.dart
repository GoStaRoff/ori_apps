import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/pages/auth/components/auth_button.dart';
import 'package:orienteering_ar_athlete/pages/auth/controllers/auth_controller.dart';
import 'package:orienteering_ar_athlete/pages/auth/views/email_auth_page.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_athlete/service/ori_api.dart';

class AuthPage extends StatelessWidget {
  static String id = "/auth";

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Stack(
      children: [
        PageWrapper(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: "glad1",
                    transitionOnUserGestures: true,
                    child: Material(
                      type: MaterialType.transparency, // likely needed
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
                  SizedBox(
                    height: 60.0,
                  ),
                  AuthButton(
                    onTap: () async {
                      await authController.signInGoogle();
                    },
                    text: "Sign in with Google".tr,
                    backgroundColor: Color(0xFF4F87EF),
                    rightChild: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset("assets/icons/google_icon.svg"),
                    ),
                  ),
                  AuthButton(
                    onTap: () {},
                    text: "Sign in with Facebook".tr,
                    backgroundColor: Color(0xFF3A5694),
                    rightChild: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset("assets/icons/facebook_icon.svg"),
                    ),
                  ),
                  AuthButton(
                    onTap: () async {
                      await OriApi.testRequest();
                    },
                    text: "Sign in with Twitter".tr,
                    backgroundColor: Color(0xFF03A9F4),
                    rightChild: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset("assets/icons/twitter_icon.svg"),
                    ),
                  ),
                  AuthButton(
                    onTap: () {},
                    text: "Sign in with Apple".tr,
                    backgroundColor: Colors.white,
                    rightChild: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset("assets/icons/apple_icon.svg"),
                    ),
                  ),
                  Hero(
                    tag: "login",
                    child: Material(
                      type: MaterialType.transparency,
                      child: AuthButton(
                        onTap: () {
                          Get.toNamed(EmailAuthPage.loginId);
                        },
                        text: "Sign in with email".tr,
                        backgroundColor: LIGHT_GRAY,
                        rightChild: CircleAvatar(
                          backgroundColor: LIGHT_GRAY,
                          child: SvgPicture.asset(
                              "assets/icons/email_black_icon.svg"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Text(
                          "OR".tr,
                          style: MAIN_TEXT_STYLE_WHITE.copyWith(
                              color: LIGHT_GRAY_TEXT),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 1.0,
                            child: Container(
                              color: LIGHT_GRAY,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Hero(
                        tag: "licenses",
                        child: Material(
                          type: MaterialType.transparency,
                          child: AuthButton(
                            onTap: () {},
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
                      Hero(
                        tag: "register",
                        child: Material(
                          type: MaterialType.transparency,
                          child: AuthButton(
                            onTap: () {
                              Get.toNamed(EmailAuthPage.registrationId);
                            },
                            text: "Create new account".tr,
                            backgroundColor: GREEN,
                            rightChild: CircleAvatar(
                              backgroundColor: GREEN,
                              child: SvgPicture.asset(
                                  "assets/icons/email_icon.svg"),
                            ),
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
        Positioned(
          right: 80,
          top: 140,
          child: Hero(
            tag: "logo",
            child: Container(
              height: 70,
              width: 70,
              child: SvgPicture.asset("assets/icons/ar_logo_icon.svg"),
            ),
          ),
        ),
        Positioned(
          right: 113,
          top: -214,
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
