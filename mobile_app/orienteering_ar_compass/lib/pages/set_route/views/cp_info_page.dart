import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';

// ignore: must_be_immutable
class CPInfoPage extends StatelessWidget {
  var cp;

  CPInfoPage({this.cp});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: Stack(
        children: [
          Image.network(
            cp["photo"].length > 0 ? cp["photo"] : cp["ar_photo"],
            height: Get.height,
            width: Get.width,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            left: 10.0,
            top: 10.0,
            child: SafeArea(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.black54,
                    child: SvgPicture.asset(
                      "assets/icons/arrow_back_icon.svg",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                width: Get.width,
                height: 100.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        cp["name"],
                        style: MAIN_TEXT_STYLE_WHITE.copyWith(fontSize: 20.0),
                      ),
                      RoundedContainer(
                        width: 200.0,
                        height: 30.0,
                        color: BG_COLOR,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                  "assets/icons/google_maps_logo.svg"),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                cp["lat"].toString(),
                                style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                    fontSize: 12.0),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                cp["lng"].toString(),
                                style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                    fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
