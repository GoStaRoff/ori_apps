import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orienteering_ar_athlete/constants/math.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/service/ori_api.dart';

class RoutesController extends GetxController {
  MainController mainController = Get.find();
  var priorityItems = [
    "RATING".tr,
    "TYPE".tr,
    "ID".tr,
    "LENGTH".tr,
    "CPS".tr,
    "PRICE".tr,
    "".tr,
    "DISTANCE TO START".tr,
  ]; // Варианты сортировки маршрутов
  var checkedPriority = 0.obs; // Выбрана сортировка
  var checkedTypeOpenFilter = "All".obs;
  var checkedSalesFilter = "All".obs;
  var checkedThemesFilter = "All".obs;
  var checkedPassesFilter = "All".obs;
  var checkedLengthFilter = "Any".obs;
  var checkedPriceFilter = "Any".obs;
  var checkedTypeFilter = "Any".obs;
  var beginningDate = DateTime(0).obs;
  var routes = [].obs; // Список маршрутов
  var filteredRoutes = [].obs; // Список отфильтрованых маршрутов
  var filteredCount = 0.obs; // Количество применённых фильтров
  var sumPasses = 0.obs; // Сума всех прохожденний маршрутов
  Rx<double> sumSales = 0.0.obs; // Сума зароботка со всех маршрутов
  var averageTips = 0.obs; // Средние чаевые за все маршрути

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  setCheckedPriority(int index) {
    String propertyName;
    // "route_id": "15",
    // "route_oc": "Close",
    // "route_name": "Boris 109-1",
    // "route_type": "Quest",
    // "route_theme": "Science",
    // "route_method": "Ski",
    // "route_terra": "City",
    // "route_cps_count": "20",
    // "route_rate": "3.8",
    // "route_length": "10",
    // "route_price": 22.99,
    // "route_passes_count": "9000",
    // "route_cash_count": "9910",
    // "route_percent": "25",
    // "distance_start": "10",
    // "created_date": "2021-07-4",
    switch (index) {
      case 0:
        propertyName = "route_rate";
        break;
      case 1:
        propertyName = "route_type";
        break;
      case 2:
        propertyName = "route_name";
        break;
      case 3:
        propertyName = "route_length";
        break;
      case 4:
        propertyName = "route_cps_count";
        break;
      case 5:
        propertyName = "route_price";
        break;
      case 7:
        propertyName = "distance_start";
        break;
      case 0:
      default:
        propertyName = "route_rate";
        break;
    }
    filteredRoutes.sort((a, b) {
      print(a[propertyName]);
      if (isNumeric(b[propertyName].toString())) {
        return double.parse(b[propertyName].toString())
            .compareTo(double.parse(a[propertyName].toString()));
      } else {
        return b[propertyName].compareTo(a[propertyName]);
      }
    });
    checkedPriority.value = index;
  }

  void selectDate(BuildContext context) async {
    var tempDate = await showRoundedDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDatePickerMode: DatePickerMode.year,
      theme: ThemeData(primarySwatch: Colors.grey),
    );
    if (tempDate != null) {
      beginningDate.value = tempDate;
    }
  }

  void reset() {
    checkedTypeOpenFilter.value = "All";
    checkedSalesFilter.value = "All";
    checkedThemesFilter.value = "All";
    checkedPassesFilter.value = "All";
    checkedLengthFilter.value = "Any";
    checkedPriceFilter.value = "Any";
    checkedTypeFilter.value = "Any";
    beginningDate.value = DateTime(0);
  }

  @override
  void onInit() {
    super.onInit();
    loadRoutes();
    mainController.updateRoutes = loadRoutes;
  }

  loadRoutes() async {
    var result = await OriApi.getAthleteRoutes(mainController.getProfileID());
    print(result);
    if (result.data[0]['error'].toString() != "true") {
      if (result.data[0]["routes"] != null)
        routes.value = result.data[0]["routes"];
      else
        return;
      print(routes);
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
    for (var i = 0; i < routes.length; i++) {
      routes[i]["route_cps_count"] = routes[i]["cps"].length.toString();
      if (routes[i]["route_type"] == "Rogaine" ||
          routes[i]["route_type"] == "Detective") {
        routes[i]["route_length"] = "0";
      }
      print(mainController.currentLocation);
      routes[i]["distance_start"] = calculateDistanceMeters(
              double.parse(routes[i]["cps"][0]["lat"]),
              double.parse(routes[i]["cps"][0]["lng"]),
              mainController.currentLocation!=null?mainController.currentLocation.value.latitude:0.0,
              mainController.currentLocation!=null?mainController.currentLocation.value.longitude:0.0)
          .toString();
    }
    setFilterRoutes();
  }

  setFilterRoutes() {
    filteredCount.value = 0;
    filteredRoutes.value = routes;
    if (beginningDate.value != DateTime(0)) {
      filteredRoutes.value = filteredRoutes
          .where((item) =>
              DateFormat("yyyy-MM-dd")
                  .parse(item["created_date"])
                  .compareTo(beginningDate.value) >=
              0)
          .toList();
      filteredCount.value++;
    }
    switch (checkedTypeOpenFilter.value) {
      case "All":
        break;
      default:
        filteredRoutes.value = filteredRoutes
            .where((item) => item["route_oc"] == checkedTypeOpenFilter.value)
            .toList();
        filteredCount.value++;
        break;
    }
    switch (checkedTypeFilter.value) {
      case "Any":
        break;
      default:
        filteredRoutes.value = filteredRoutes
            .where((item) => item["route_type"] == checkedTypeFilter.value)
            .toList();
        filteredCount.value++;
        break;
    }
    switch (checkedThemesFilter.value) {
      case "All":
        break;
      default:
        filteredRoutes.value = filteredRoutes
            .where((item) => item["route_theme"] == checkedThemesFilter.value)
            .toList();
        filteredCount.value++;
        break;
    }
    switch (checkedSalesFilter.value) {
      case "<100":
        filteredRoutes.value = filteredRoutes
            .where((item) => int.parse(item["route_cash_count"]) <= 100)
            .toList();
        filteredCount.value++;
        break;
      case "100-1K":
        filteredRoutes.value = filteredRoutes
            .where((item) =>
                int.parse(item["route_cash_count"]) > 100 &&
                int.parse(item["route_cash_count"]) <= 1000)
            .toList();
        filteredCount.value++;
        break;
      case "1K>":
        filteredRoutes.value = filteredRoutes
            .where((item) => int.parse(item["route_cash_count"]) > 1000)
            .toList();
        filteredCount.value++;
        break;
      default:
        break;
    }
    switch (checkedPassesFilter.value) {
      case "<100":
        filteredRoutes.value = filteredRoutes
            .where((item) => int.parse(item["route_passes_count"]) <= 100)
            .toList();
        filteredCount.value++;
        break;
      case "100-1K":
        filteredRoutes.value = filteredRoutes
            .where((item) =>
                int.parse(item["route_passes_count"]) > 100 &&
                int.parse(item["route_passes_count"]) <= 1000)
            .toList();
        filteredCount.value++;
        break;
      case "1K>":
        filteredRoutes.value = filteredRoutes
            .where((item) => int.parse(item["route_passes_count"]) > 1000)
            .toList();
        filteredCount.value++;
        break;
      default:
        break;
    }
    switch (checkedLengthFilter.value) {
      case "<2":
        filteredRoutes.value = filteredRoutes
            .where((item) => int.parse(item["route_length"]) <= 2)
            .toList();
        filteredCount.value++;
        break;
      case "2-4":
        filteredRoutes.value = filteredRoutes
            .where((item) =>
                int.parse(item["route_length"]) > 2 &&
                int.parse(item["route_length"]) <= 4)
            .toList();
        filteredCount.value++;
        break;
      case "4-7":
        filteredRoutes.value = filteredRoutes
            .where((item) =>
                int.parse(item["route_length"]) > 4 &&
                int.parse(item["route_length"]) <= 7)
            .toList();
        filteredCount.value++;
        break;
      case "7>":
        filteredRoutes.value = filteredRoutes
            .where((item) => int.parse(item["route_length"]) > 7)
            .toList();
        filteredCount.value++;
        break;
      default:
        break;
    }
    switch (checkedPriceFilter.value) {
      case "0":
        filteredRoutes.value = filteredRoutes
            .where((item) => int.parse(item["route_price"]) == 0)
            .toList();
        filteredCount.value++;
        break;
      case "<3":
        filteredRoutes.value = filteredRoutes
            .where((item) => int.parse(item["route_price"]) <= 3)
            .toList();
        filteredCount.value++;
        break;
      case "3-9":
        filteredRoutes.value = filteredRoutes
            .where((item) =>
                int.parse(item["route_price"]) > 3 &&
                int.parse(item["route_price"]) <= 9)
            .toList();
        filteredCount.value++;
        break;
      case "9>":
        filteredRoutes.value = filteredRoutes
            .where((item) => int.parse(item["route_price"]) > 9)
            .toList();
        filteredCount.value++;
        break;
      default:
        break;
    }
    sumPasses.value = 0;
    sumSales.value = 0;
    averageTips.value = 0;
    int sumTips = 0;
    filteredRoutes.forEach((element) {
      sumPasses.value =
          int.parse(element["route_passes_count"]) + sumPasses.value;
      sumSales.value += int.parse(element["route_cash_count"]);
      sumTips = int.parse(element["route_percent"]) + sumTips;
    });
    try {
      averageTips.value = sumTips ~/ filteredRoutes.length;
    } catch (e) {}

    setCheckedPriority(checkedPriority.value);
  }
}
