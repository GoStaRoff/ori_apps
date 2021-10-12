import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/set_route/controllers/set_route_controller.dart';

// ignore: must_be_immutable
class ChooseCPDialog extends StatelessWidget {
  SetRouteController setRouteController = Get.find();
  int answerID;
  int cpID;
  var answers;

  ChooseCPDialog(this.answerID, this.cpID, this.answers);

  cps() => setRouteController.cps
      .where((cp) => cp['name'] != setRouteController.cps[cpID]["name"])
      .toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
      child: RoundedContainer(
        child: Padding(
          padding: EdgeInsets.only(top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140,
                child: Text(
                  answers[answerID]["answer"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: MAIN_TEXT_STYLE_BLACK,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10.0,
                      );
                    },
                    itemCount: cps().length,
                    itemBuilder: (_, i) => InkWell(
                      onTap: () {
                        answers[answerID]["cp_id"] = cps()[i]["name"];
                        Get.appUpdate();
                        Get.back();
                      },
                      child: RoundedContainer(
                        height: 30.0,
                        color: DARK_BROWN,
                        child: Center(
                          child: Text(
                            cps()[i]["name"],
                            style: MAIN_TEXT_STYLE_WHITE,
                          ),
                        ),
                      ),
                    ),
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
