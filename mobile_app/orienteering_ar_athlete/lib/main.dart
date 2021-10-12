import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/service/ori_translations.dart';
import 'package:orienteering_ar_athlete/service/pages.dart';

void main() async {
  await GetStorage.init();
  Get.put(MainController());
  runApp(
    GetMaterialApp(
      translations: OriTranslations(),
      locale: Get.deviceLocale,
      initialRoute: kINITIALROUTE,
      unknownRoute: kUKNOWNROUTE,
      getPages: kPAGES,
    ),
  );
}
