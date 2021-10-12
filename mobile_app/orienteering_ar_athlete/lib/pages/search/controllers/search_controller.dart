import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/service/ori_api.dart';

class SearchController extends GetxController {
  MainController mainController = Get.find();
  var searchEditingController =
      new TextEditingController().obs; // Контроль ввода текста поисков
  var clearButtonVisible = false.obs; // Отображение кнопки очистки текстов
  var searchButtonEnabled = false.obs;
  var routes = [].obs;
  var coachs = [].obs;

  @override
  void onInit() {
    super.onInit();
    searchEditingController.value.addListener(checkClearButtonVisible);
  }

  @override
  void onClose() {
    super.onClose();
    searchEditingController.value.removeListener(checkClearButtonVisible);
  }

  onClearClick() => searchEditingController.value.clear();

  onSearchClick() async {
    var result = await OriApi.searchAthleteRoutes(
        mainController.profileID, searchEditingController.value.text);
    if (result.data[0]['error'].toString() != "true") {
      print(result.data[0]);
      routes.value = result.data[0]["routes"];
      coachs.value = result.data[0]["coachs"];
      print(routes);
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
  }

  checkClearButtonVisible() {
    clearButtonVisible.value = searchEditingController.value.text.isNotEmpty;
    searchButtonEnabled.value = searchEditingController.value.text.isNotEmpty;
  }
}
