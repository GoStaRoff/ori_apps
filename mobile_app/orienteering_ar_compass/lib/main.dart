import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/service/network_binding.dart';
import 'package:orienteering_ar_compass/service/ori_translations.dart';
import 'package:orienteering_ar_compass/service/pages.dart';

void main() async {
  await GetStorage.init();
  Get.put(MainController());
  runApp(
    GetMaterialApp(
      initialBinding: NetworkBinding(),
      translations: OriTranslations(),
      initialRoute: kINITIALROUTE,
      unknownRoute: kUKNOWNROUTE,
      locale: Get.deviceLocale,
      getPages: kPAGES,
    ),
  );
}
