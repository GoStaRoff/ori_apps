import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/service/languages/danish.dart';
import 'package:orienteering_ar_compass/service/languages/english.dart';
import 'package:orienteering_ar_compass/service/languages/finnish.dart';
import 'package:orienteering_ar_compass/service/languages/french.dart';
import 'package:orienteering_ar_compass/service/languages/german.dart';
import 'package:orienteering_ar_compass/service/languages/norwegian.dart';
import 'package:orienteering_ar_compass/service/languages/russian.dart';
import 'package:orienteering_ar_compass/service/languages/swedish.dart';

class OriTranslations extends Translations {
  static Map<String, Locale> languages = {
    // Список языков
    "english": Locale('en_US'),
    "russian": Locale('ru_RU'),
    "norwegian": Locale('no_NO'),
    "swedish": Locale('sv_SE'),
    "finnish": Locale('finnish'),
    "danish": Locale('da_DK'),
    "french": Locale('fr_FR'),
    "german": Locale('de_DE'),
  };

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': english,
        'ru_RU': russian,
        'de_DE': german,
        'fr_FR': french,
        'da_DK': danish,
        'no_NO': norwegian,
        'sv_SE': swedish,
        'fi_FI': finnish,
      };
}
