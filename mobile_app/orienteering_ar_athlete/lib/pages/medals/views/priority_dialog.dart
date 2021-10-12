import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/pages/medals/controllers/medals_controller.dart';
import 'package:orienteering_ar_athlete/pages/routes/components/priority_item.dart';

// ignore: must_be_immutable
class PriorityDialog extends StatelessWidget {
  MedalsController medalsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Get.width / 4),
      child: Container(
        decoration: BoxDecoration(
          color: BG_COLOR,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20.0,
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: Get.back,
                    child: SvgPicture.asset(
                      "assets/icons/close_icon.svg",
                    ),
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: medalsController.priorityItems.length,
                      itemBuilder: (_, i) => Obx(
                        () => PriorityItem(
                          text: medalsController.priorityItems[i],
                          isChecked:
                              i == medalsController.checkedPriority.value,
                          onTap: () {
                            medalsController.setCheckedPriority(i);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
