import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/main_button.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

// ignore: must_be_immutable
class RatePage extends StatefulWidget {
  var sendRate;
  bool isFinish;

  RatePage({this.sendRate, required this.isFinish});
  @override
  _RatePageState createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  int rate = 0;
  TextEditingController commentTextController = new TextEditingController();
  MainController mainController = Get.find();
  String checkedDifficulty = "easy";

  getCircle() {
    String text;
    Color color;
    switch (mainController.currentRoute["route_type"]) {
      case "Orient":
        text = "O";
        color = ORIENT_COLOR;
        break;
      case "Quest":
        text = "Q";
        color = ORANGE;
        break;
      case "Rogaine":
        text = "R";
        color = VIOLET;
        break;
      default:
        text = "D";
        color = LIGHT_RED;
        break;
    }
    return CircleAvatar(
      radius: 20,
      backgroundColor: color,
      child: Center(
        child: Text(
          text,
          style: MAIN_TEXT_STYLE_WHITE,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      header: Header(
        middleWidget: Row(
          children: [
            getCircle(),
            SizedBox(
              width: 10.0,
            ),
            Text(
              mainController.currentRoute["route_generated_name"],
              style: MAIN_TEXT_STYLE_BLACK,
            )
          ],
        ),
      ),
      children: [
        SizedBox(
          height: 30.0,
        ),
        widget.isFinish
            ? Image.asset("assets/images/finish_img.png")
            : Image.asset("assets/images/sad_img.png"),
        SizedBox(
          height: 10.0,
        ),
        Center(
          child: Text(
            "Please rate the route",
            style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              rate,
              (i) => GestureDetector(
                onTap: () {
                  setState(() {
                    rate = i + 1;
                  });
                },
                child: Icon(
                  Icons.star,
                  color: Color(0xFFF6AB56),
                  size: 40,
                ),
              ),
            ).toList(),
            ...List.generate(
              5 - rate,
              (i) => GestureDetector(
                onTap: () {
                  setState(() {
                    rate += i + 1;
                  });
                },
                child: Icon(
                  Icons.star,
                  color: LIGHT_GRAY,
                  size: 40,
                ),
              ),
            ).toList(),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        CustomInput(
          height: 170,
          hintText: "Write comment here..".tr,
          controller: commentTextController,
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                commentTextController.text += "👌";
                commentTextController.selection = TextSelection.fromPosition(
                    TextPosition(offset: commentTextController.text.length));
              },
              child: Image.asset("assets/images/ok_emoji.png"),
            ),
            GestureDetector(
              onTap: () {
                commentTextController.text += "👍";
                commentTextController.selection = TextSelection.fromPosition(
                    TextPosition(offset: commentTextController.text.length));
              },
              child: Image.asset("assets/images/thumb_up_emoji.png"),
            ),
            GestureDetector(
              onTap: () {
                commentTextController.text += "👎";
                commentTextController.selection = TextSelection.fromPosition(
                    TextPosition(offset: commentTextController.text.length));
              },
              child: Image.asset("assets/images/thumd_down_emoji.png"),
            ),
            GestureDetector(
              onTap: () {
                commentTextController.text += "🥰";
                commentTextController.selection = TextSelection.fromPosition(
                    TextPosition(offset: commentTextController.text.length));
              },
              child: Image.asset("assets/images/love_emoji.png"),
            ),
            GestureDetector(
              onTap: () {
                commentTextController.text += "😃";
                commentTextController.selection = TextSelection.fromPosition(
                    TextPosition(offset: commentTextController.text.length));
              },
              child: Image.asset("assets/images/good_emoji.png"),
            ),
            GestureDetector(
              onTap: () {
                commentTextController.text += "😩";
                commentTextController.selection = TextSelection.fromPosition(
                    TextPosition(offset: commentTextController.text.length));
              },
              child: Image.asset("assets/images/tired_emoji.png"),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                onTap: () {
                  if (rate > 0) {
                    mainController.stopWatchTimer.onExecute
                        .add(StopWatchExecute.stop);
                    mainController.stopWatchTimer.onExecute
                        .add(StopWatchExecute.reset);
                    mainController.passingRoute.value = false;
                    mainController.currentRoute = null;
                    mainController.onChangePage(2);
                    Get.back(closeOverlays: true);
                  } else {
                    Get.snackbar("Warning", "Please give an estimate");
                  }
                },
                child: Container(
                  height: 45.0,
                  child: Center(
                    child: Text(
                      "Quit and do not pay!".tr,
                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                          color: LIGHT_GRAY_TEXT, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Container(
                child: MainButton(
                  text: widget.isFinish ? "Checkout" : "Quit and checkout",
                  onPressed: () {
                    if (rate > 0) {
                      mainController.stopWatchTimer.onExecute
                          .add(StopWatchExecute.stop);
                      mainController.stopWatchTimer.onExecute
                          .add(StopWatchExecute.reset);
                      mainController.passingRoute.value = false;
                      mainController.currentRoute = null;
                      mainController.onChangePage(2);
                      Get.back(closeOverlays: true);
                    } else {
                      Get.snackbar("Warning", "Please give an estimate");
                    }
                  },
                  isActive: true,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}
