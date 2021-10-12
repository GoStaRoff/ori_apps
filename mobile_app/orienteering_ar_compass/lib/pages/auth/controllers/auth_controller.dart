import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/home/views/home_page.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';

//--------------------------GetX контроллер авторизации--------------------------------
class AuthController extends GetxController {
  final GetStorage box = GetStorage(); // Инициализация локального хранилища Get
  final MainController mainController =
      Get.find(); //Инициализация главного контроллера
  var licenses = ''.obs; //Текст лицензии (html - код)
  var agreementPP = false.obs; //Значение PP
  var agreementUA = false.obs; //Значение UA
  var emailEditingController =
      new TextEditingController().obs; //Текстовый контроллер ввода поля "email"
  var passwordEditingController = new TextEditingController()
      .obs; //Текстовый контроллер ввода поля "password"
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'profile',
    'email',
  ]); //Переменная для контроля аворизации с помощью Google

//""""""""""""""""""""""""""Функия получения лицензии с API, устанавливает значение 'licenses' """"""""""""""""""""""""""
  getLicense() async {
    var result = await OriApi.getLicense(); //Вызов функии api-сервиса
    licenses.value = result.data[0]['title_pp'] +
        result.data[0]['description_pp'] +
        result.data[0]['title_ua'] +
        result.data[0][
            'description_ua']; // Присвоение значения полю 'licenses' контроллера
  }

//""""""""""""""""""""""""""Авторизация с помощью Google""""""""""""""""""""""""""
  Future<void> signInGoogle() async {
    _googleSignIn
        .disconnect(); // Выход из аккаунта Google усли он не был выполнен
    var user; // Инициализация переменной 'user'
    try {
      user = await _googleSignIn.signIn(); // Выполнение входа в Goggle аккаунт
      if (user.email == null) return;
    } catch (error) {
      Get.snackbar("Error".tr,
          "Something going wrong".tr); // Вывод уведомления об ошибке
      return; // Выход из функции
    }
    var result = await OriApi.socialAuth(user.email, user.displayName,
        user.photoUrl); // Вызов функии api-сервиса и запись в переменную 'result'
    if (!result.data[0]['error']) {
      // Проверка на ошибку api-запроса
      int id = int.parse(
          result.data[0]['id']); // Запись id пользователя в переменную 'id'
      box.write("id", id);
      mainController.initProfile(); // Сохранение id в локальное хранилище Get
      Get.offAllNamed(HomePage
          .id); // Переход на домашнюю страницу без возможности вернуться назад
      Get.snackbar("Message".tr,
          result.data[0]["description"]); // Вывод уведомления об авторизации
    }
  }

//""""""""""""""""""""""""""Авторизация с помощью почты""""""""""""""""""""""""""
  signInWithEmail() async {
    var result = await OriApi.login(emailEditingController.value.text,
        passwordEditingController.value.text); // Запрос на api-сервис
    if (result.data[0]['error'].toString() != "true") {
      // Проверка на ошибку запроса
      int id = int.parse(
          result.data[0]['id']); // Запись id пользователя в переменную 'id'
      box.write("id", id); // Сохранение id в локальное хранилище Get
      mainController.initProfile();
      Get.offAllNamed(HomePage
          .id); // Переход на домашнюю страницу без возможности вернуться назад
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
  }

//""""""""""""""""""""""""""Регистрация с помощью почты""""""""""""""""""""""""""
  signUpWithEmail() async {
    var result = await OriApi.registration(
        emailEditingController.value.text,
        passwordEditingController.value.text,
        agreementPP.value,
        agreementUA.value); // Запрос на api-сервис
    if (result.data[0]['error'].toString() != "true") {
      // Проверка на ошибку запроса
      int id = int.parse(
          result.data[0]['id']); // Запись id пользователя в переменную 'id'
      box.write("id", id); // Сохранение id в локальное хранилище Get
      mainController.initProfile();
      Get.offAllNamed(HomePage
          .id); // Переход на домашнюю страницу без возможности вернуться назад
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
  }

  //""""""""""""""""""""""""""Изменить состояние PP""""""""""""""""""""""""""
  changeAgreementPP() => agreementPP.value = !agreementPP.value;
//""""""""""""""""""""""""""Изменить состояние UA""""""""""""""""""""""""""
  changeAgreementUA() => agreementUA.value = !agreementUA.value;
}
