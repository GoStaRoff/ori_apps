import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_athlete/service/ori_api.dart';

//--------------------------GetX контроллер профиля--------------------------------
class ProfileController extends GetxController {
  MainController mainController = Get.find();
  var isGender = false.obs; // Переменная для проверки был ли установлен гендер
  var isMale = false.obs; // Пременная отображения тренера
  var birth = DateTime(1).obs; // Год рождения
  var infoHeight = 0.1.obs; // Высота контейнера для установки личных данных
  var settingPersonalInfo = false.obs; // Проверка на отображения контейнера ЛД

  // Функция инициализации контроллера
  @override
  void onInit() {
    print(mainController.getProfileID());
    var gender = mainController.profileGender.value;
    if (gender.length > 0) {
      isGender.value = true;
      isMale.value = gender == "Male" ? false : true;
      birth.value = mainController.profileDate.value;
    }
    super.onInit();
  }

  String getBirth() => Jiffy(birth.toString()).format("yyyy-MM-dd");

  //""""""""""""""""""""""""""Смена состяния 'isMale' """"""""""""""""""""""""""
  void toggleGender() async {
    if (isGender.value == false)
      isGender.value = true;
    else {
      isMale.value = !isMale.value;
      if (birth.value != DateTime(1)) {
        await setPersonalInfo();
      }
    }
  }

  // Изменение высоты контейнера ЛД
  void toggleInfoHeight() => infoHeight.value == 0.1
      ? infoHeight.value = 160.0
      : infoHeight.value = 0.1;

  // Отображения стрелочки в строке для открытия настройки ЛД
  Widget showPersonalInfoArrow() => infoHeight.value == 160.0
      ? SvgPicture.asset(
          "assets/icons/arrow_up_icon2.svg",
          height: 8.0,
          color: DARK_BROWN,
        )
      : SvgPicture.asset("assets/icons/arrow_down_icon.svg");

  // Фунция для выбора даты
  void selectDate(BuildContext context) async {
    var tempYear = await showRoundedDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDatePickerMode: DatePickerMode.year,
      theme: ThemeData(primarySwatch: Colors.grey),
    );
    if (tempYear != null) {
      birth.value = tempYear;
      if (isGender.value) {
        await setPersonalInfo(isDateFunction: true);
      }
    }
  }

  // Функция для обработки запроса на установку ЛД
  setPersonalInfo({bool isDateFunction = false}) async {
    settingPersonalInfo.value = true;
    var result = await OriApi.setPersonalInfo(mainController.getProfileID(),
        birth.value.toString(), !isMale.value ? "Male" : "Female");
    if (result.data[0]['error'].toString() != "true") {
      // Проверка ответа на обработаную ошибку
      if (isDateFunction) {
        Get.snackbar("Message".tr, result.data[0]['description']);
      }
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
    settingPersonalInfo.value = false;
  }

  setAvatar() async {
    PickedFile avatar;
    try {
      avatar = await ImagePicker().getImage(source: ImageSource.gallery)
          as PickedFile;
    } catch (e) {
      return;
    }
    var result = await OriApi.setAvatar(
      mainController.getProfileID(),
      File(avatar.path),
    );
    if (result.data[0]['error'].toString() != "true") {
      // Проверка ответа на обработаную ошибку
      mainController.profileAvatarLink.value = result.data[0]["client_avatar"];
      Get.snackbar("Message".tr, result.data[0]['description']);
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
  }

  showTariff() {
    Color color = LIGHT_GRAY; // Цвет контейнера про тариф
    if (mainController.tariffList != null) {
      if (mainController.tariffList[1]["name"] ==
          mainController.profileTariff.value) {
        color = ORIENT_COLOR;
      } else if (mainController.tariffList[2]["name"] ==
          mainController.profileTariff.value) {
        color = ORANGE;
      } else if (mainController.tariffList[3]["name"] ==
          mainController.profileTariff.value) {
        color = LIGHT_RED;
      }
    }
    return RoundedContainer(
      height: 30,
      color: color,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Center(
            child: Text(
          mainController.profileTariff.value,
          style: MAIN_TEXT_STYLE_WHITE,
        )),
      ),
    );
  }
}
