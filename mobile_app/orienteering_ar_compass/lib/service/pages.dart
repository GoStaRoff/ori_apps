import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orienteering_ar_compass/pages/auth/views/auth_page.dart';
import 'package:orienteering_ar_compass/pages/auth/views/email_auth_page.dart';
import 'package:orienteering_ar_compass/pages/auth/views/license_page.dart';
import 'package:orienteering_ar_compass/pages/home/views/home_page.dart';
import 'package:orienteering_ar_compass/pages/news/views/messages_page.dart';
import 'package:orienteering_ar_compass/pages/routes/views/routes_filter_page.dart';
import 'package:orienteering_ar_compass/pages/sales/views/sales_page.dart';
import 'package:orienteering_ar_compass/pages/sales/views/sales_payment_page.dart';
import 'package:orienteering_ar_compass/pages/search/views/search_page.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/cps_page.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/route_property_page.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/set_map_page.dart';
import 'package:orienteering_ar_compass/pages/settings/views/settings_page.dart';
import 'package:orienteering_ar_compass/pages/tariff/views/tariff_page.dart';
import 'package:orienteering_ar_compass/pages/wishes/views/wishes_page.dart';

String kINITIALROUTE =
    GetStorage().read('id') == null ? AuthPage.id : HomePage.id;

GetPage kUKNOWNROUTE = GetPage(name: "/notfound", page: () => Container());

List<GetPage<dynamic>> kPAGES = [
  GetPage(name: HomePage.id, page: () => HomePage()),
  GetPage(name: AuthPage.id, page: () => AuthPage()),
  GetPage(name: LicensePages.id, page: () => LicensePages()),
  GetPage(name: SettingsPage.id, page: () => SettingsPage()),
  GetPage(name: WishesPage.id, page: () => WishesPage()),
  GetPage(name: SalesPage.id, page: () => SalesPage()),
  GetPage(name: SalesPaymentPage.id, page: () => SalesPaymentPage()),
  GetPage(name: TariffPage.id, page: () => TariffPage()),
  GetPage(name: MessagesPage.id, page: () => MessagesPage()),
  GetPage(name: RoutesFilterPage.id, page: () => RoutesFilterPage()),
  GetPage(name: SearchPage.id, page: () => SearchPage()),
  GetPage(name: RoutePropertyPage.id, page: () => RoutePropertyPage()),
  GetPage(name: CPSPage.id, page: () => CPSPage()),
  GetPage(name: SetMapPage.id, page: () => SetMapPage()),
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
