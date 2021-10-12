import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/percent.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/tariff/components/tariff_card.dart';
import 'package:orienteering_ar_compass/pages/tariff/views/tariff_payment_page.dart';

// ignore: must_be_immutable
class TariffContainer extends StatelessWidget {
  final Color color;
  final bool selected;
  final String tillDate;
  final String name;
  final String percent;
  final double twelveMonth;
  final double sixMonth;
  final double oneMonth;
  var onTap;

  TariffContainer({
    required this.color,
    required this.selected,
    required this.tillDate,
    required this.name,
    required this.percent,
    required this.oneMonth,
    required this.sixMonth,
    required this.twelveMonth,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: twelveMonth == 0
          ? () {
              onTap();
            }
          : null,
      child: RoundedContainer(
        color: selected ? color : Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.0,
            right: 1.0,
            left: 1.0,
            bottom: 1.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(name,
                            style: MAIN_TEXT_STYLE_WHITE.copyWith(
                                color: selected ? null : color)),
                        SizedBox(
                          width: 5.0,
                        ),
                        twelveMonth == 0
                            ? Container()
                            : tillDate.length != 0
                                ? Text("till ".tr + tillDate,
                                    style: MAIN_TEXT_STYLE_WHITE.copyWith(
                                        color: selected ? null : color))
                                : Container(),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("EARN".tr,
                            style: MAIN_TEXT_STYLE_WHITE.copyWith(
                                color: selected ? null : color)),
                        SizedBox(
                          width: 5.0,
                        ),
                        Percent(
                          count: percent,
                          color: selected ? Colors.white : color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              twelveMonth == 0
                  ? Container()
                  : RoundedContainer(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 20.0,
                          right: 10.0,
                          left: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TariffCard(
                              monthCount: 12,
                              price: twelveMonth,
                              onTap: () {
                                Get.to(
                                  TariffPaymentPage(
                                    price: twelveMonth.toString(),
                                    monthCount: 12,
                                    color: color,
                                    name: name,
                                  ),
                                );
                              },
                            ),
                            TariffCard(
                              monthCount: 6,
                              price: sixMonth,
                              onTap: () {
                                Get.to(
                                  TariffPaymentPage(
                                    price: sixMonth.toString(),
                                    monthCount: 6,
                                    color: color,
                                    name: name,
                                  ),
                                );
                              },
                            ),
                            TariffCard(
                              monthCount: 1,
                              price: oneMonth,
                              onTap: () {
                                Get.to(
                                  TariffPaymentPage(
                                    price: oneMonth.toString(),
                                    monthCount: 1,
                                    color: color,
                                    name: name,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
