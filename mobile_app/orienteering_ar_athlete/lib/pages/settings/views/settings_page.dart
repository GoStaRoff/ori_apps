import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_checkbox.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_item_list.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/main_button.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_athlete/pages/settings/views/exit_dialog.dart';
import 'package:orienteering_ar_athlete/service/ori_api.dart';
import 'package:orienteering_ar_athlete/service/ori_translations.dart';

class SettingsPage extends StatefulWidget {
  static String id = "/settings";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  MainController mainController = Get.find();
  String distance = "km"; // Переменная для обозначения дистанции
  String language =
      "english"; // Переменная для обозначения языка// Список валют
  bool savingValues = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      distance = mainController.distance.value;
      language = mainController.language.value;
    });
  }

  setDistance(String value) {
    setState(() {
      distance = value;
    });
  }

//""""""""""""""""""""""""""Смена состяния 'language' """"""""""""""""""""""""""
  setLanguage(String value) {
    setState(() {
      language = value;
    });
  }

  saveSettings() async {
    setState(() {
      savingValues = true;
    });
    var result = await OriApi.setSettings(
        mainController.getProfileID(), "€", distance, language);
    if (result.data[0]['error'].toString() != "true") {
      mainController.language.value = language;
      Get.updateLocale(OriTranslations.languages[language]!);
      mainController.distance.value = distance;
      Get.snackbar("Message".tr, result.data[0]['description']);
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
    mainController.updateRoutes();
    setState(() {
      savingValues = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      fab: FloatingActionButton(
        onPressed: () {
          Get.dialog(ExitDialog());
        },
        child: Text(
          "Exit",
          style: AUTH_TITLE_TEXT_STYLE.copyWith(fontSize: 12.0),
        ),
        backgroundColor: ORIENT_COLOR,
      ),
      header: Header(
        middleWidget: Text(
          "Settings".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
      ),
      children: [
        SizedBox(
          height: 25.0,
        ),
        Text(
          "DISTANCE MEASURE".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        RoundedContainer(
          child: Column(
            children: [
              CustomItemList(
                child: Padding(
                  padding: EdgeInsets.only(right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "km",
                        style: MAIN_TEXT_STYLE_BLACK,
                      ),
                      CustomCheckBox(
                          isChecked: distance == "km",
                          onChanged: () {
                            setDistance("km");
                          })
                    ],
                  ),
                ),
                onPressed: () {},
              ),
              CustomItemList(
                disabledLine: true,
                child: Padding(
                  padding: EdgeInsets.only(right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "miles",
                        style: MAIN_TEXT_STYLE_BLACK,
                      ),
                      CustomCheckBox(
                          isChecked: distance == "miles",
                          onChanged: () {
                            setDistance("miles");
                          })
                    ],
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "LANGUAGE".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        RoundedContainer(
          height: 60,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Center(
              child: DropdownButton<String>(
                value: language,
                isExpanded: true,
                icon: SvgPicture.asset("assets/icons/arrow_down_icon.svg"),
                style: MAIN_TEXT_STYLE_BLACK,
                underline: SizedBox(),
                onChanged: (String? newValue) {
                  setLanguage(newValue.toString());
                },
                items: OriTranslations.languages.keys
                    .toList()
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        MainButton(
            text: "SAVE".tr, onPressed: saveSettings, isActive: !savingValues),
      ],
    );
  }
}
