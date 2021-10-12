import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';

// ignore: must_be_immutable
class CPDialog extends StatelessWidget {
  final String id;
  final double latitude;
  final double longitude;
  bool deletingPoint;
  final String imageLink;
  var deletePoint;

  CPDialog(
      {required this.id,
      required this.longitude,
      required this.latitude,
      this.deletingPoint = false,
      this.deletePoint,
      required this.imageLink});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: RoundedContainer(
            height: Get.height / 2,
            width: Get.width / 1.2,
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: Material(
                color: Colors.white,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: deletingPoint
                          ? null
                          : () async {
                              await deletePoint(id);
                            },
                      child: SvgPicture.asset(
                        "assets/icons/trash_icon.svg",
                        color: deletingPoint ? LIGHT_GRAY : DARK_BROWN,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: Text(
                            id,
                            style:
                                MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 24.0),
                          ),
                        ),
                        Center(
                          child: Image.network(
                            imageLink,
                            height: Get.height / 3.5,
                          ),
                        ),
                        RoundedContainer(
                          width: Get.width / 2,
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
                                  latitude.toString(),
                                  style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                      fontSize: 12.0),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  longitude.toString(),
                                  style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                      fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
