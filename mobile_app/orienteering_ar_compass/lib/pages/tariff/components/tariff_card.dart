import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/money.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';

class TariffCard extends StatelessWidget {
  final int monthCount;
  final double price;
  final void Function()? onTap;

  TariffCard(
      {required this.monthCount, required this.price, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RoundedContainer(
        borderEnabled: true,
        borderColor: BG_COLOR,
        height: Get.width / 4,
        width: Get.width / 4,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$monthCount",
                    style: MAIN_TEXT_STYLE_BLACK,
                  ),
                  Text(
                    " month".tr,
                    style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 14.0),
                  ),
                ],
              ),
              Money(
                count: price.toString(),
              ),
              Text(
                "€ ${price ~/ monthCount}" + " per month".tr,
                style: MAIN_TEXT_STYLE_BLACK.copyWith(
                  fontSize: 11.0,
                  color: price ~/ monthCount == price
                      ? Colors.white
                      : LIGHT_GRAY_TEXT,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
