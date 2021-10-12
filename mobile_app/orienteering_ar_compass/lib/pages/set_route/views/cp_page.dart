import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_list_view.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/main_button.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_padding.dart';
import 'package:orienteering_ar_compass/pages/set_route/controllers/set_route_controller.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/audio_page.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/choose_cp_dialog.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/discard_avatar_dialog.dart';

// ignore: must_be_immutable
class CPPage extends StatefulWidget {
  final int index;

  CPPage({required this.index});

  @override
  _CPPageState createState() => _CPPageState();
}

class _CPPageState extends State<CPPage> {
  SetRouteController setRouteController = Get.find();
  var answers = new List.filled(0, Map<String, dynamic>());
  TextEditingController questionEditingController = new TextEditingController();
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController answerEditingController =
      new TextEditingController(); // Контроль ввода текста ответа
  bool addButtonVisible = false; // Отображение кнопки очистки текстов
  String avatarPath = "";

  @override
  void initState() {
    super.initState();
    answerEditingController.addListener(onAnswerChange);
    setState(() {
      avatarPath = setRouteController.cps[widget.index]["avatar"] == null ||
              setRouteController.cps[widget.index]["avatar"].length < 1
          ? avatarPath
          : setRouteController.cps[widget.index]["avatar"];
      questionEditingController.text =
          setRouteController.cps[widget.index]["question"] == null ||
                  setRouteController.cps[widget.index]["question"].length < 1
              ? questionEditingController.text
              : setRouteController.cps[widget.index]["question"];
      nameEditingController.text =
          setRouteController.cps[widget.index]["cp_name"] == null ||
                  setRouteController.cps[widget.index]["cp_name"].length < 1
              ? questionEditingController.text
              : setRouteController.cps[widget.index]["cp_name"];
      if (setRouteController.cps[widget.index]["answers"] != null) {
        answers =
            new List.from(setRouteController.cps[widget.index]["answers"]);
      }
    });
  }

  setCPPicture() async {
    PickedFile? avatar =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (avatar != null) {
      setState(() {
        avatarPath = avatar.path;
      });
    }
  }

  onAdd() {
    setState(() {
      answers = [
        ...answers,
        {"answer": answerEditingController.text}
      ];
      answerEditingController.clear();
    });
  }

  onAnswerChange() {
    var arr = answers
        .where((answer) => answer["answer"] == answerEditingController.text);
    setState(() {
      addButtonVisible = answerEditingController.text.isNotEmpty && arr.isEmpty;
    });
  }

  clear() {
    setState(() {
      avatarPath = "";
      questionEditingController.clear();
      nameEditingController.clear();
      answers.clear();
    });
  }

  saveCP(cp, setRouteController) {
    if (nameEditingController.text.length == 0) {
      Get.snackbar("Saving failed", "Write CP NAME");
      return;
    }
    if (avatarPath.length == 0) {
      Get.snackbar("Saving failed", "Choose CP picture");
      return;
    }
    if (questionEditingController.text.length == 0) {
      Get.snackbar("Saving failed", "Write question text");
      return;
    }
    if (answers.length < 2) {
      Get.snackbar("Saving failed", "Write more answers");
      return;
    }
    bool fillAnswers = true;
    print(answers);
    for (var i = 0; i < answers.length; i++) {
      if (i == 0) {
        fillAnswers = answers[i]["cp_id"] != null;
      } else {
        if (fillAnswers == (answers[i]["cp_id"] == null)) {
          Get.snackbar("Saving failed", "Fill all answers or stay empty");
          return;
        }
      }
    }
    if (!fillAnswers) {
      cp["lastMarker"] = true;
    } else {
      cp["lastMarker"] = false;
    }
    cp["avatar"] = avatarPath;
    cp["question"] = questionEditingController.text;
    cp["cp_name"] = nameEditingController.text;
    cp["answers"] = new List.from(answers);
    setRouteController.updateGraph(fillAnswers);
    Get.back();
  }

  @override
  void dispose() {
    answerEditingController.removeListener(onAnswerChange);
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
                  children: [
                    CircleAvatar(
                      radius: 15.0,
                      backgroundImage: NetworkImage(setRouteController
                                  .cps[widget.index]["photo"].length >
                              0
                          ? setRouteController.cps[widget.index]["photo"]
                          : setRouteController.cps[widget.index]["ar_photo"]),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      setRouteController.cps[widget.index]["name"],
                      style: MAIN_TEXT_STYLE_BLACK,
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
                      avatarPath.length < 1
                          ? Stack(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 50.0,
                                    ),
                                    Center(
                                      child: InkWell(
                                        onTap: setCPPicture,
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
                                          setRouteController.cps[widget.index]
                                              ["sound"], (String name) {
                                        setRouteController.cps[widget.index]
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
                              ],
                            )
                          : Stack(
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
                                  bottom: 40.0,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(
                                        AudioPage(
                                            setRouteController.cps[widget.index]
                                                ["sound"], (String name) {
                                          setRouteController.cps[widget.index]
                                              ["sound"] = name;
                                        }),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.white60,
                                      child: SvgPicture.asset(
                                          "assets/icons/mic_icon.svg"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      Column(
                        children: [
                          SizedBox(
                            height: 220.0,
                          ),
                          Container(
                            width: Get.width,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: CustomInput(
                              style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                  fontSize: 24.0),
                              hintText: "CP NAME",
                              controller: nameEditingController,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(20),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
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
                                    controller: questionEditingController,
                                    color: BG_COLOR,
                                    hintText: "Type here...".tr,
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
                                    "ANSWERS".tr,
                                    style: MAIN_TEXT_STYLE_BLACK,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Column(
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
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  actionPane:
                                                      SlidableDrawerActionPane(),
                                                  actionExtentRatio: 0.25,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            answers[i]
                                                                ["answer"],
                                                            style:
                                                                MAIN_TEXT_STYLE_BLACK,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            await Get.dialog(
                                                                ChooseCPDialog(
                                                                    i,
                                                                    widget
                                                                        .index,
                                                                    answers));
                                                            setState(() {});
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              answers[i]["cp_id"] ==
                                                                      null
                                                                  ? Text(
                                                                      "Set CP",
                                                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                                                          fontWeight:
                                                                              FontWeight.w700))
                                                                  : Text(
                                                                      answers[i]
                                                                          [
                                                                          "cp_id"],
                                                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                                                          color:
                                                                              GREEN,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                              SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    "assets/icons/marker_icon.svg",
                                                                    color: answers[i]["cp_id"] ==
                                                                            null
                                                                        ? DARK_BROWN
                                                                        : GREEN,
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 20.0,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ).toList(),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomInput(
                                                      color: BG_COLOR,
                                                      hintText:
                                                          "Answer variant".tr,
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
                                                        backgroundColor:
                                                            BG_COLOR,
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
                                onPressed: () {
                                  saveCP(setRouteController.cps[widget.index],
                                      setRouteController);
                                },
                                isActive: true,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                        ],
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
