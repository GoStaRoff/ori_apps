import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/main_button.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SalesPaymentPage extends StatelessWidget {
  static String id = "/sales_payment";
  var addressInputController = TextEditingController();
  MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    addressInputController.text = mainController.payseraAddress.value;
    return PageWrapper(
      header: Header(
        middleWidget: Text(
          "Payment".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
      ),
      children: [
        SizedBox(
          height: 25.0,
        ),
        Text(
          "All your earnings will be send to you by by one of payment systems below from 1-st to 7-th day of each month, if your earnings are equal or more than €100. \n\nIf your earnings do not reach €100 in the given month, the amount will be added to the next month earnings."
              .tr,
          textAlign: TextAlign.center,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 30.0,
        ),
        Center(
          child: Text(
            "Be carefull!\nWrong address, no money!".tr,
            style: MAIN_TEXT_STYLE_BLACK.copyWith(
              color: GREEN,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Row(
          children: [
            Image.asset("assets/images/paysera_logo.png"),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: CustomInput(
                hintText: "Enter your PAYSERA address".tr,
                controller: addressInputController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        InkWell(
          onTap: () async {
            String url = "https://bank.paysera.com/en/registration";
            if (await canLaunch(url)) {
              await launch(
                url,
                forceSafariVC: false,
                forceWebView: false,
                headers: <String, String>{'header_key': 'header_value'},
              );
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "It is very easy to open your PaySera account".tr,
                style: MAIN_TEXT_STYLE_BLACK.copyWith(
                  color: Color(0xFF52B4E0),
                  fontSize: 14,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Container(
                width: 15.0,
                height: 15.0,
                child: SvgPicture.asset(
                  "assets/icons/arrow_icon.svg",
                  color: Color(0xFF52B4E0),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        MainButton(
            text: "OK".tr,
            onPressed: () {
              mainController.payseraAddress.value = addressInputController.text;
              OriApi.setPaymentAddress(mainController.profileID,
                  int.parse(addressInputController.text));
              Get.back();
            },
            isActive: true),
      ],
    );
  }
}
