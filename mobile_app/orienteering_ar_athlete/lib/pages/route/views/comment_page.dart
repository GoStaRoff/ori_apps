import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/main_button.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_athlete/service/ori_api.dart';

// ignore: must_be_immutable
class CommentPage extends StatefulWidget {
  String routeId;

  CommentPage({required this.routeId});
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  int commentRate = 1;
  TextEditingController commentTextController = new TextEditingController();
  MainController mainController = Get.find();
  String checkedDifficulty = "easy";
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      header: Header(
        middleWidget: Text(
          "Comment".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
      ),
      children: [
        SizedBox(
          height: 30.0,
        ),
        Image.asset("assets/images/pin_img.png"),
        SizedBox(
          height: 40.0,
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
            Image.asset("assets/images/ok_emoji.png"),
            Image.asset("assets/images/thumb_up_emoji.png"),
            Image.asset("assets/images/thumd_down_emoji.png"),
            Image.asset("assets/images/love_emoji.png"),
            Image.asset("assets/images/good_emoji.png"),
            Image.asset("assets/images/tired_emoji.png"),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          child: MainButton(
            text: "Send",
            onPressed: () async {
              var result = await OriApi.addComment(int.parse(widget.routeId),
                  mainController.getProfileID(), commentTextController.text, 2);
              if (result.data[0]['error'].toString() != "true") {
                print(result.data[0]);
                mainController.updateRoute();
                mainController.updateRoutes();
                Get.back(closeOverlays: true);
                Get.back(closeOverlays: true);
              } else {
                Get.snackbar(
                    "Error".tr,
                    result.data[0]
                        ['description']); // Вывод на ошибку корректности данных
              }
            },
            isActive: true,
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}
