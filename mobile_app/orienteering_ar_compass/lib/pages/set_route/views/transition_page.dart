import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/answer_checkbox.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_list_view.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/main_button.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_padding.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/set_route/controllers/set_route_controller.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/audio_page.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/discard_avatar_dialog.dart';

// ignore: must_be_immutable
class TransitionPage extends StatefulWidget {
  int index;

  TransitionPage(this.index);

  @override
  _TransitionPageState createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  SetRouteController setRouteController = Get.find();
  TextEditingController answerEditingController =
      new TextEditingController(); // Контроль ввода текста ответа
  TextEditingController fullAnswerEditingController =
      new TextEditingController();
  TextEditingController questionEditingController = new TextEditingController();
  bool answersListVisible = true;
  bool addButtonVisible = false; // Отображение кнопки очистки текстов
  bool infoVisible = true;
  String checkedAnswer = ""; // Текст правильного ответа
  String avatarPath = "";
  var answers = [];

  @override
  void initState() {
    super.initState();
    answerEditingController.addListener(onAnswerChange);
    fullAnswerEditingController.addListener(onFullAnswerChange);
    setState(() {
      answers.clear();
      if (setRouteController.transitions[widget.index]["answers"] != null) {
        var _answers = [];
        for (var answer in setRouteController.transitions[widget.index]
            ["answers"]) {
          _answers.add(answer["answer"]);
        }
        if (setRouteController.transitions[widget.index]["is_full"]) {
          var answersText = "";
          for (var answer in _answers) {
            answersText += "$answer, ";
          }
          answersText = answersText.substring(0, answersText.length - 2);
          fullAnswerEditingController.text = answersText;
        } else {
          answers = new List.from(_answers);
        }
      }
      infoVisible =
          setRouteController.transitions[widget.index]["show_info"] ?? true;
      checkedAnswer =
          setRouteController.transitions[widget.index]["correct_answer"] ?? "";
      avatarPath = setRouteController.transitions[widget.index]["avatar"] ==
                  null ||
              setRouteController.transitions[widget.index]["avatar"].length < 1
          ? avatarPath
          : setRouteController.transitions[widget.index]["avatar"];
      questionEditingController.text =
          setRouteController.transitions[widget.index]["question"] == null ||
                  setRouteController
                          .transitions[widget.index]["question"].length <
                      1
              ? questionEditingController.text
              : setRouteController.transitions[widget.index]["question"];
    });
  }

  onAdd() {
    setState(() {
      answers.add(answerEditingController.text);
      answerEditingController.clear();
    });
  }

  onAnswerChange() {
    setState(() {
      var arr =
          answers.where((answer) => answer == answerEditingController.text);
      addButtonVisible = answerEditingController.text.isNotEmpty && arr.isEmpty;
    });
  }

  setTransitionPicture() async {
    PickedFile? avatar =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (avatar != null) {
      setState(() {
        avatarPath = avatar.path;
      });
    }
  }

  onFullAnswerChange() {
    setState(() {
      answersListVisible = fullAnswerEditingController.text.isEmpty;
    });
  }

  saveTransition(transition) {
    if (avatarPath.length == 0) {
      Get.snackbar("Saving failed", "Choose transition picture");
      return;
    }
    if (questionEditingController.text.length == 0) {
      Get.snackbar("Saving failed", "Write question text");
      return;
    }
    if (answers.isEmpty) {
      var answersString = fullAnswerEditingController.text;
      var res = answersString.split(',');
      for (var i = 0; i < res.length; i++) {
        res[i] = res[i].trim();
      }
      if (res.length > 1) {
        answers = res;
        transition["is_full"] = true;
      }
    } else {
      if (checkedAnswer.length == 0) {
        Get.snackbar("Saving failed", "Choose correct answer");
        return;
      } else
        transition["correct_answer"] = checkedAnswer;
      transition["is_full"] = false;
    }
    if (answers.length < 2) {
      Get.snackbar("Saving failed", "Write more answers");
      return;
    }
    print(answers);

    transition["avatar"] = avatarPath;
    transition["question"] = questionEditingController.text;
    var _answers = [];
    for (var answer in answers) {
      _answers.add({"answer": answer});
    }
    transition["answers"] = new List.from(_answers);
    transition["show_info"] = infoVisible;
    print(transition);
    Get.back();
  }

  clear() {
    setState(() {
      avatarPath = "";
      questionEditingController.text = "";
      answerEditingController.text = "";
      fullAnswerEditingController.text = "";
      answers = [];
      checkedAnswer = "";
      infoVisible = true;
    });
  }

  @override
  void dispose() {
    answerEditingController.removeListener(onAnswerChange);
    fullAnswerEditingController.removeListener(onFullAnswerChange);
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
                middleWidget: Row(
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
                    widget.index == setRouteController.cps.length - 2
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
                  avatarPath.length < 1
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 60.0,
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: setTransitionPicture,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 55.0,
                                      child: SvgPicture.asset(
                                        "assets/icons/camera_icon.svg",
                                        height: 40.0,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.0,
                                ),
                              ],
                            ),
                            Positioned(
                              right: 20.0,
                              bottom: 20.0,
                              child: InkWell(
                                onTap: () {
                                  Get.to(AudioPage(
                                      setRouteController
                                          .transitions[widget.index]["sound"],
                                      (String name) {
                                    setRouteController.transitions[widget.index]
                                        ["sound"] = name;
                                  }));
                                },
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.white,
                                  child: SvgPicture.asset(
                                      "assets/icons/mic_icon.svg"),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20.0,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    infoVisible = !infoVisible;
                                  });
                                },
                                child: RoundedContainer(
                                  height: 30.0,
                                  width: 120.0,
                                  child: Row(
                                    children: [
                                      RoundedContainer(
                                        width: 70.0,
                                        color: FILL_GRAY,
                                        child: Center(
                                          child: infoVisible
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${setRouteController.transitions[widget.index]["distance"].toInt()}",
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
                                                  style: MAIN_TEXT_STYLE_WHITE,
                                                ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: infoVisible
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${setRouteController.transitions[widget.index]["angle"].toInt()}",
                                                      style:
                                                          MAIN_TEXT_STYLE_BLACK,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "o",
                                                          style:
                                                              MAIN_TEXT_STYLE_BLACK
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
                                                  style: MAIN_TEXT_STYLE_BLACK,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: Image.file(
                                File(avatarPath),
                                fit: BoxFit.cover,
                                height: 240.0,
                                width: Get.width,
                              ),
                            ),
                            Positioned(
                              right: 20,
                              top: 20,
                              child: InkWell(
                                onTap: () {
                                  Get.dialog(
                                    DiscardAvatarDialog(
                                      onDiscard: () {
                                        setState(() {
                                          avatarPath = "";
                                        });
                                        Get.back();
                                      },
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white60,
                                  child: SvgPicture.asset(
                                      "assets/icons/trash_icon.svg"),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20.0,
                              bottom: 20.0,
                              child: InkWell(
                                onTap: () {
                                  Get.to(AudioPage(
                                      setRouteController
                                          .transitions[widget.index]["sound"],
                                      (String name) {
                                    setRouteController.transitions[widget.index]
                                        ["sound"] = name;
                                  }));
                                },
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.white60,
                                  child: SvgPicture.asset(
                                      "assets/icons/mic_icon.svg"),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20.0,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    infoVisible = !infoVisible;
                                  });
                                },
                                child: RoundedContainer(
                                  height: 30.0,
                                  width: 120.0,
                                  child: Row(
                                    children: [
                                      RoundedContainer(
                                        width: 70.0,
                                        color: FILL_GRAY,
                                        child: Center(
                                          child: infoVisible
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${setRouteController.transitions[widget.index]["distance"].toInt()}",
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
                                                  style: MAIN_TEXT_STYLE_WHITE,
                                                ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: infoVisible
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${setRouteController.transitions[widget.index]["angle"].toInt()}",
                                                      style:
                                                          MAIN_TEXT_STYLE_BLACK,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "o",
                                                          style:
                                                              MAIN_TEXT_STYLE_BLACK
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
                                                  style: MAIN_TEXT_STYLE_BLACK,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  Container(
                    width: Get.width,
                    height: 170.0,
                    color: Colors.white,
                    child: PagePadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TEXT (I.E. QUESTION)".tr,
                            style: MAIN_TEXT_STYLE_BLACK,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          CustomInput(
                            height: 100.0,
                            color: BG_COLOR,
                            hintText: "Type here...".tr,
                            controller: questionEditingController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: Get.width,
                    color: Colors.white,
                    child: PagePadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ANSWER".tr,
                            style: MAIN_TEXT_STYLE_BLACK,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Visibility(
                                  visible:
                                      answers.isEmpty || !answersListVisible,
                                  child: Column(
                                    children: [
                                      CustomInput(
                                        height: 100.0,
                                        color: BG_COLOR,
                                        controller: fullAnswerEditingController,
                                        hintText:
                                            "Enter all variations of the Keyword, separated by coma "
                                                .tr,
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      SizedBox(
                                        height: 1.0,
                                        child: Container(
                                          color: BG_COLOR,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: answersListVisible,
                                  child: Column(
                                    children: [
                                      Column(
                                        children: List.generate(
                                          answers.length,
                                          (i) => Slidable(
                                            actions: [],
                                            secondaryActions: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    answers.removeAt(i);
                                                  });
                                                },
                                                child: Container(
                                                  color: Colors.redAccent,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                            actionPane:
                                                SlidableDrawerActionPane(),
                                            actionExtentRatio: 0.25,
                                            child: AnswerCheckbox(
                                              checked:
                                                  checkedAnswer == answers[i],
                                              onTap: () {
                                                setState(() {
                                                  checkedAnswer = answers[i];
                                                });
                                              },
                                              answerText: answers[i],
                                            ),
                                          ),
                                        ).toList(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: CustomInput(
                                                color: BG_COLOR,
                                                hintText: "Answer variant".tr,
                                                controller:
                                                    answerEditingController,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Visibility(
                                              visible: addButtonVisible,
                                              child: InkWell(
                                                onTap: onAdd,
                                                child: CircleAvatar(
                                                  backgroundColor: BG_COLOR,
                                                  radius: 22.0,
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: clear,
                        child: Container(
                          width: 150.0,
                          height: 45.0,
                          child: Center(
                            child: Text(
                              "Clear all".tr,
                              style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                  color: LIGHT_GRAY_TEXT),
                            ),
                          ),
                        ),
                      ),
                      MainButton(
                        width: 150.0,
                        text: "Save".tr,
                        onPressed: () => saveTransition(
                            setRouteController.transitions[widget.index]),
                        isActive: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
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
