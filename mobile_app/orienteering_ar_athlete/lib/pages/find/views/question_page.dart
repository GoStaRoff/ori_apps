import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/answer_checkbox.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_list_view.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/main_button.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_padding.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';

class QuestionPage extends StatefulWidget {
  bool cpQuestion;
  bool withFullAnswer;
  var question;
  int index;
  bool isLast;

  QuestionPage({
    this.isLast = false,
    this.index = 0,
    this.cpQuestion = false,
    this.withFullAnswer = false,
    this.question,
  });
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  MainController mainController = Get.find();
  bool infoVisible = false;
  int checkedAnswer = -1;
  TextEditingController answerController = new TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  late List<bool> wrongAnswers;

  checkAnswer() {
    if (widget.withFullAnswer) {
      if (widget.question["answers"].contains(answerController.text)) {
        mainController.currentRoute["transitions"][widget.index]["show_info"]
            .value = "true";
        mainController.currentRoute["step"]++;
        mainController.onChangePage(2);
        Get.back(closeOverlays: true);
        return;
      } else {
        Get.snackbar("Wrong answer", "Penalty +999min");
        return;
      }
    }
    if (checkedAnswer >= 0) {
      if (widget.cpQuestion) {
        mainController.currentRoute["next_cp"].value =
            widget.question["answers"][checkedAnswer]["cp_id"];
        print(mainController.currentRoute["next_cp"].value);
        mainController.currentRoute["history"].value.last["question"] =
            widget.question["question"];
        mainController.currentRoute["history"].value.last["answer"].value =
            widget.question["answers"][checkedAnswer]["answer"];
        if (widget.question["answers"][checkedAnswer]["cp_id"] != "")
          mainController.currentRoute["history"].value = [
            ...mainController.currentRoute["history"].value,
            {
              "name": widget.question["answers"][checkedAnswer]["cp_id"],
              "answer": Rx<String>("")
            }
          ];

        mainController.onChangePage(2);
        Get.back(closeOverlays: true);
        return;
      }
      if (widget.question["answers"][checkedAnswer] ==
          widget.question["correct_answer"]) {
        mainController.currentRoute["transitions"][widget.index]["show_info"]
            .value = "true";
        mainController.currentRoute["step"]++;
        mainController.onChangePage(2);
        Get.back(closeOverlays: true);
      } else {
        setState(() {
          wrongAnswers[checkedAnswer] = true;
          checkedAnswer = -1;
        });
        Get.snackbar("Wrong answer", "Penalty +999min");
      }
    } else
      Get.snackbar("Warning", "Choose answer");
  }

  play() async {
    if (audioPlayer.state == PlayerState.PLAYING)
      await audioPlayer.stop();
    else {
      var result = await audioPlayer.play(widget.question["sound"]);
      print(result);
    }
    print(audioPlayer.state);
  }

  @override
  void initState() {
    wrongAnswers = new List.filled(widget.question["answers"].length, false);
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            PagePadding(
              child: Header(
                middleWidget: widget.cpQuestion
                    ? Row(
                        children: [
                          CircleAvatar(
                            radius: 15.0,
                            backgroundImage: NetworkImage(
                                widget.question["photo"].length > 0
                                    ? widget.question["photo"]
                                    : widget.question["ar_photo"]),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            widget.question["name"],
                            style: MAIN_TEXT_STYLE_BLACK,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Transition ".tr,
                            style: MAIN_TEXT_STYLE_BLACK,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          widget.index == 0
                              ? SvgPicture.asset(
                                  "assets/icons/start_icon.svg",
                                  height: 16.0,
                                )
                              : Text(
                                  "${widget.index}",
                                  style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                      fontWeight: FontWeight.w700),
                                ),
                          Icon(Icons.arrow_right_alt),
                          widget.isLast
                              ? CircleAvatar(
                                  radius: 10.0,
                                  backgroundColor: LIGHT_RED,
                                  child: CircleAvatar(
                                    radius: 8.0,
                                    backgroundColor: BG_COLOR,
                                    child: CircleAvatar(
                                      radius: 6.0,
                                      backgroundColor: LIGHT_RED,
                                      child: CircleAvatar(
                                        radius: 4.0,
                                        backgroundColor: BG_COLOR,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  "${widget.index + 1}",
                                  style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                      fontWeight: FontWeight.w700),
                                ),
                        ],
                      ),
              ),
            ),
            Expanded(
              child: CustomListView(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: Image.network(
                                widget.question["avatar"],
                                fit: BoxFit.cover,
                                height: 240.0,
                                width: Get.width,
                              ),
                            ),
                            widget.question["sound"].length > 0
                                ? Positioned(
                                    right: 20.0,
                                    bottom: 40.0,
                                    child: InkWell(
                                      onTap: play,
                                      child: CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.white60,
                                        child: SvgPicture.asset(
                                            "assets/icons/mic_icon.svg"),
                                      ),
                                    ),
                                  )
                                : Container(),
                            widget.cpQuestion
                                ? Container()
                                : Positioned(
                                    top: 20.0,
                                    child: RoundedContainer(
                                      height: 30.0,
                                      width: 120.0,
                                      child: Row(
                                        children: [
                                          RoundedContainer(
                                            width: 70.0,
                                            color: FILL_GRAY,
                                            child: Center(
                                              child: widget.question[
                                                          "show_info"] ==
                                                      "true"
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          widget.question[
                                                                  "distance"]
                                                              .substring(
                                                                  0,
                                                                  widget
                                                                      .question[
                                                                          "distance"]
                                                                      .indexOf(
                                                                          ".")),
                                                          style:
                                                              MAIN_TEXT_STYLE_WHITE,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "m",
                                                              style:
                                                                  MAIN_TEXT_STYLE_WHITE
                                                                      .copyWith(
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      "?",
                                                      style:
                                                          MAIN_TEXT_STYLE_WHITE,
                                                    ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: widget.question[
                                                          "show_info"] ==
                                                      "true"
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          widget
                                                              .question["angle"]
                                                              .substring(
                                                                  0,
                                                                  widget
                                                                      .question[
                                                                          "angle"]
                                                                      .indexOf(
                                                                          ".")),
                                                          style:
                                                              MAIN_TEXT_STYLE_BLACK,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "o",
                                                              style: MAIN_TEXT_STYLE_BLACK
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12.0),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      "?",
                                                      style:
                                                          MAIN_TEXT_STYLE_BLACK,
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Positioned(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 220.0,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: Get.width,
                                  constraints: BoxConstraints(
                                    minHeight: Get.height / 2 + 90,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      topLeft: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.question["question"],
                                          style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        widget.withFullAnswer &&
                                                !widget.cpQuestion
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  CustomInput(
                                                    hintText:
                                                        "Write answer here..",
                                                    height: 200,
                                                    color: BG_COLOR,
                                                    controller:
                                                        answerController,
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                children: List.generate(
                                                  widget.question["answers"]
                                                      .length,
                                                  (i) => AnswerCheckbox(
                                                    checked: checkedAnswer == i,
                                                    isWrong: wrongAnswers[i],
                                                    onTap: wrongAnswers[i]
                                                        ? null
                                                        : () {
                                                            setState(() {
                                                              checkedAnswer = i;
                                                            });
                                                          },
                                                    answerText:
                                                        widget.cpQuestion
                                                            ? widget.question[
                                                                    "answers"]
                                                                [i]["answer"]
                                                            : widget.question[
                                                                "answers"][i],
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 20,
                                  top: 10,
                                  child: GestureDetector(
                                    onTap: checkAnswer,
                                    child: RoundedContainer(
                                      height: 40.0,
                                      width: 80,
                                      color: DARK_BROWN,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            "CHECK",
                                            style: MAIN_TEXT_STYLE_WHITE
                                                .copyWith(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
