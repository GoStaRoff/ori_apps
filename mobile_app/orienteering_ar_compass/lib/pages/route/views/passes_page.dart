import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_compass/pages/route/components/pass_widget.dart';
import 'package:orienteering_ar_compass/pages/route/components/passes_check_box.dart';
import 'package:orienteering_ar_compass/pages/route/controllers/route_controller.dart';

// ignore: must_be_immutable
class PassesPage extends StatelessWidget {
  RouteController routeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      fab: FloatingActionButton(
        backgroundColor: ORIENT_COLOR,
        onPressed: () {},
        child: Container(
          height: 20.0,
          width: 20.0,
          child: SvgPicture.asset("assets/icons/arrow_up_icon.svg"),
        ),
      ),
      header: Header(
        middleWidget: Text(
          "Passes",
          style: MAIN_TEXT_STYLE_BLACK,
        ),
      ),
      children: [
        SizedBox(
          height: 20.0,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PassesCheckBox(
                count: "1",
                text: "pass",
                checked: routeController.checkedPass.value == "1",
                onTap: () {
                  routeController.checkedPass.value = "1";
                },
              ),
              PassesCheckBox(
                count: "2",
                text: "passes",
                checked: routeController.checkedPass.value == "2",
                onTap: () {
                  routeController.checkedPass.value = "2";
                },
              ),
              PassesCheckBox(
                count: "3+",
                text: "passes",
                checked: routeController.checkedPass.value == "3+",
                onTap: () {
                  routeController.checkedPass.value = "3+";
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        PassWidget(),
        PassWidget(),
        PassWidget(),
        PassWidget(),
      ],
    );
  }
}
