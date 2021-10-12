import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';

class SearchController extends GetxController {
  var searchEditingController =
      new TextEditingController().obs; // Контроль ввода текста поисков
  var clearButtonVisible = false.obs; // Отображение кнопки очистки текстов
  var searchButtonEnabled = false.obs;
  var routes = [].obs;

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
    var result =
        await OriApi.searchCoachRoutes(64, searchEditingController.value.text);
    if (result.data[0]['error'].toString() != "true") {
      routes.value = result.data[0]["routes"];
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
