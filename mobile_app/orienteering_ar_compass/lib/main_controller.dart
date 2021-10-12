import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:location/location.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';
import 'package:orienteering_ar_compass/service/ori_translations.dart';

class MainController extends GetxController {
  final GetStorage box = GetStorage();
  var location;
  var pageIndex = 3.obs;
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
  var lastRoute = 1.obs;
  var updateRoutes;
  var updateCPS;
  // ignore: top_level_function_literal_block
  var onChangePageCallback;
  var currentLocation;
  var updateRoute;
  var tariffList;

  getProfileID() => box.read("id");
  @override
  void onInit() {
    super.onInit();
    initProfile();
    location = new Location();
    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc.obs;
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
        profileTariffTill.value = profile["coach_tariff_end_date"] ?? "";
        profileTariff.value = profile["coach_tariff"] ?? "FREE";
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
    onChangePageCallback(s);
    if (s == 1) s = 0;
    pageIndex.value = s;
  }
}
