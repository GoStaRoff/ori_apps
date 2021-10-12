import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orienteering_ar_athlete/pages/auth/views/auth_page.dart';
import 'package:orienteering_ar_athlete/pages/auth/views/email_auth_page.dart';
import 'package:orienteering_ar_athlete/pages/auth/views/license_page.dart';
import 'package:orienteering_ar_athlete/pages/global_components/help_page.dart';
import 'package:orienteering_ar_athlete/pages/home/views/home_page.dart';
import 'package:orienteering_ar_athlete/pages/medals/views/medals_page.dart';
import 'package:orienteering_ar_athlete/pages/news/views/messages_page.dart';
import 'package:orienteering_ar_athlete/pages/routes/views/routes_filter_page.dart';
import 'package:orienteering_ar_athlete/pages/search/views/search_page.dart';
import 'package:orienteering_ar_athlete/pages/settings/views/settings_page.dart';
import 'package:orienteering_ar_athlete/pages/tariff/views/tariff_page.dart';
import 'package:orienteering_ar_athlete/pages/wishes/views/wishes_page.dart';

String kINITIALROUTE =
    GetStorage().read('id') == null ? AuthPage.id : HomePage.id;

GetPage kUKNOWNROUTE = GetPage(name: "/notfound", page: () => Container());

List<GetPage<dynamic>> kPAGES = [
  GetPage(name: HomePage.id, page: () => HomePage()),
  GetPage(name: AuthPage.id, page: () => AuthPage()),
  GetPage(name: LicensePages.id, page: () => LicensePages()),
  GetPage(name: SettingsPage.id, page: () => SettingsPage()),
  GetPage(name: WishesPage.id, page: () => WishesPage()),
  GetPage(name: TariffPage.id, page: () => TariffPage()),
  GetPage(name: MessagesPage.id, page: () => MessagesPage()),
  GetPage(name: RoutesFilterPage.id, page: () => RoutesFilterPage()),
  GetPage(name: SearchPage.id, page: () => SearchPage()),
  GetPage(name: MedalsPage.id, page: () => MedalsPage()),
  GetPage(name: HelpPage.id, page: () => HelpPage()),
  GetPage(
      name: EmailAuthPage.registrationId,
      page: () => EmailAuthPage(
            isAuth: false,
          )),
  GetPage(
      name: EmailAuthPage.loginId,
      page: () => EmailAuthPage(
            isAuth: true,
          )),
];
