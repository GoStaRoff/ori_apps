import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:location/location.dart';
import 'package:orienteering_ar_athlete/constants/math.dart';
import 'package:orienteering_ar_athlete/service/ori_api.dart';
import 'package:orienteering_ar_athlete/service/ori_translations.dart';

class MainController extends GetxController {
  var stopWatchTimer;

  var stopWatchValue = "".obs;
  var location;
  final GetStorage box = GetStorage();
  var profileID = -1.obs;
  var profileDate = DateTime(1).obs;
  var distance = "".obs; // Переменная для обозначения дистанции
  var profileLogin = "".obs;
  var profileGender = "".obs;
  var language = "".obs; // Переменная для обозначения языка
  var profileAvatarLink = "".obs;
  var initProfileLoading = false.obs;
  var profileTariff = "FREE".obs;
  var profileTariffTill = "".obs;
  var payseraAddress = "".obs;
  var unreadMessages = 0.obs;

  var pageIndex = 3.obs;
  // ignore: top_level_function_literal_block
  var onChangePageCallback;
  var currentLocation;
  var currentRoute;
  var passingRoute = false.obs;
  var updateRoute;
  var updateRoutes;
  var showAR = false.obs;
  var tariffList;

  getProfileID() => box.read("id");
  @override
  void onInit() {
    super.onInit();
    initProfile();
    location = new Location();
    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc.obs;
      if (passingRoute.value) {
        if ((currentRoute["route_type"] == "Orient" ||
                currentRoute["route_type"] == "Quest") &&
            currentRoute["step"].value != -1) {
          double distanceToCP = calculateDistanceMeters(
              currentLocation.value.latitude!,
              currentLocation.value.longitude!,
              double.parse(
                  currentRoute["cps"].value[currentRoute["step"].value]["lat"]),
              double.parse(currentRoute["cps"].value[currentRoute["step"].value]
                  ["lng"]));
          print(distanceToCP);
          showAR.value = distanceToCP < 20;
        } else if (currentRoute["route_type"] == "Rogaine") {
          var cp;
          for (var i = 0; i < currentRoute["cps"].value.length; i++) {
            double distanceToCP = calculateDistanceMeters(
                currentLocation.value.latitude!,
                currentLocation.value.longitude!,
                double.parse(currentRoute["cps"].value[i]["lat"]),
                double.parse(currentRoute["cps"].value[i]["lng"]));
            if (distanceToCP < 20 &&
                currentRoute["cps"].value[i]["is_active"].value) {
              cp = currentRoute["cps"].value[i];
              showAR.value = true;
            }
          }
          if (cp == null) {
            showAR.value = false;
            currentRoute["rogaine_cp"] = {};
          } else
            currentRoute["rogaine_cp"] = cp;
        } else if (currentRoute["route_type"] == "Detective" &&
            currentRoute["next_cp"].value != "") {
          int index = currentRoute["cps"].value.lastIndexWhere(
              (cp) => cp["name"] == currentRoute["next_cp"].value);

          print(index);
          if (index >= 0 &&
              calculateDistanceMeters(
                      currentLocation.value.latitude!,
                      currentLocation.value.longitude!,
                      double.parse(currentRoute["cps"].value[index]["lat"]),
                      double.parse(currentRoute["cps"].value[index]["lng"])) <
                  20) {
            showAR.value = true;
            currentRoute["next_cp_i"] = index;
          } else {
            showAR.value = false;
          }
        }
      }
    });
  }

  initProfile() async {
    // GetStorage().write("id", 64);
    var result = await OriApi.getTariff();
    if (result.data[0]['error'].toString() != "true") {
      tariffList = result.data[0]["tariffs"];
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
    var id = getProfileID();
    if (id != null) {
      initProfileLoading.value = true;
      var result = await OriApi.getClientInfo(id);
      if (result.data[0]['error'].toString() != "true") {
        var profile = result.data[0];
        print(profile);
        distance.value = profile["measure"] ?? "km";
        language.value = profile["language"] ?? "english";
        Get.updateLocale(OriTranslations.languages[language.value]!);
        profileGender.value = profile["gender"] ?? "";
        profileLogin.value = profile["client_login"];
        profileDate.value = Jiffy(profile["year"]).dateTime;
        profileAvatarLink.value = profile["client_avatar"] ??
            "http://dncompany.fun/admin/uploads/clients/3694011626703325.jpg";
        payseraAddress.value = profile["paysera_address"] ?? "";
        profileTariffTill.value = profile["athlete_tariff_end_date"] ?? "";
        profileTariff.value = profile["athlete_tariff"] ?? "FREE";
        unreadMessages.value = int.parse(profile["unread_messages"]);
        Get.snackbar("Message".tr, result.data[0]['description']);
      } else {
        Get.snackbar(
            "Error".tr,
            result.data[0]
                ['description']); // Вывод на ошибку корректности данных
      }
      initProfileLoading.value = false;
    }
  }

  onChangePage(int s) {
    if (s == 2 && passingRoute.value) s = 4;
    pageIndex.value = s;
  }
}
