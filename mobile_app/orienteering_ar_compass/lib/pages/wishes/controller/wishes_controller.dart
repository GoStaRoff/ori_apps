import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orienteering_ar_compass/pages/wishes/components/image_box.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';

//--------------------------GetX контроллер авторизации--------------------------------
class WishesController extends GetxController {
  GetStorage box = GetStorage(); // Инициализация локального хранилища Get
  var enabledSendButton = true.obs; // Значение включена ли кнопка отправки
  var images = RxMap<String, Widget>(); // Список изображений
  var wishEditingController = new TextEditingController()
      .obs; // //Текстовый контроллер ввода поля "wishText"

  bool showAddButton() =>
      images.length <
      3; // Установка лимита для отображения кнопки для добавления изображний

  //""""""""""""""""""""""""""Функция загрузки изображения с галереи """"""""""""""""""""""""""
  Future getImage() async {
    // ignore: deprecated_member_use
    PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery)
        as PickedFile; //Получить картинку с галереи
    images[image.path] = ImageBox(
      path: image.path,
      delete: () {
        images.remove(image.path);
      }, // Добавление изображения
    );
  }

//""""""""""""""""""""""""""Функция отправки пожелания """"""""""""""""""""""""""
  void sendWish() async {
    if (wishEditingController.value.text.isEmpty) {
      // Проверка на наличие теста пожелания
      Get.snackbar(
          "Warning".tr,
          "Fill wish text"
              .tr); // Если теста нет - вывести следуещее уведомление
      return; // Закночить выполнение функции
    }
    enabledSendButton.value = false; // Выключит кнопку отправки
    List<File> wishFiles = []; // Инициализация переменной 'wishFiles'
    images.forEach((key, value) => wishFiles.add(
        File(key))); // Добавить каждый файл изображения из переменной 'images'
    await OriApi.sendWish(box.read("id"), wishEditingController.value.text,
        wishFiles); // Запрос на api-сервис
    Get.back(); // Назад
    Get.snackbar("Notification".tr, "Wish was send, thank you!".tr,
        snackPosition: SnackPosition
            .BOTTOM); // Вывод уведомления об успешной отправки пожелания
  }
}
