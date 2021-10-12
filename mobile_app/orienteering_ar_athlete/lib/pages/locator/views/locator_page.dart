import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/main_button.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';

class LocatorPage extends StatefulWidget {
  @override
  _LocatorPageState createState() => _LocatorPageState();
}

class _LocatorPageState extends State<LocatorPage> {
  MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      header: Header(
        withoutBack: true,
        middleWidget: Text(
          "Locator",
          style: MAIN_TEXT_STYLE_BLACK,
        ),
      ),
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            StreamBuilder<CompassEvent>(
              stream: FlutterCompass.events,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error reading heading: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                double? direction = snapshot.data!.heading;

                // if direction is null, then device does not support this sensor
                // show error message
                if (direction == null)
                  return Center(
                    child: Text("Device does not have sensors !"),
                  );

                return Transform.rotate(
                  angle: (direction * (math.pi / 180) * -1),
                  child: SvgPicture.asset("assets/images/compass_img.svg"),
                );
              },
            ),
            Image.asset(
              "assets/images/arrow_image.png",
              height: 150.0,
              color: LIGHT_RED,
            )
          ],
        ),
        SizedBox(
          height: 60.0,
        ),
        Obx(
          () => !mainController.passingRoute.value
              ? MainButton(
                  text: "Select route",
                  onPressed: () {
                    mainController.onChangePage(2);
                  },
                  isActive: true,
                )
              : Container(),
        ),
      ],
    );
  }
}
