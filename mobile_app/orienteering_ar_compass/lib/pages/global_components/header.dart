import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  var leftWidget;
  var middleWidget;
  var rightWidget;

  bool withoutBack;

  Header(
      {this.leftWidget,
      this.middleWidget,
      this.rightWidget,
      this.withoutBack = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftWidget != null
              ? leftWidget
              : withoutBack
                  ? SizedBox(
                      width: 10.0,
                    )
                  : InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 12.0,
                        child: SvgPicture.asset(
                            "assets/icons/arrow_back_icon.svg"),
                      ),
                    ),
          middleWidget != null ? middleWidget : Container(),
          rightWidget != null
              ? rightWidget
              : SizedBox(
                  width: 25.0,
                ),
        ],
      ),
    );
  }
}
