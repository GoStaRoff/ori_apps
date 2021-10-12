import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/service/ori_api.dart';

class TariffController extends GetxController {
  MainController mainController = Get.find();
  GetStorage box = GetStorage();
  var tariffLoading = false.obs;
  var tariffList = [].obs;
  var buyLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    tariffList.value = mainController.tariffList;
  }

  setTariff(String name, int monthCount, String till) async {
    buyLoading.value = true;
    var result = await OriApi.setTariff(box.read("id"), name, monthCount);
    if (result.data[0]['error'].toString() != "true") {
      mainController.profileTariffTill.value = till;
      mainController.profileTariff.value = name;
      buyLoading.value = false;
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
    Get.back(closeOverlays: true);
  }
}
