import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/medal.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_athlete/service/ori_api.dart';

class MedalsController extends GetxController {
  MainController mainController = Get.find();
  var priorityItems = [
    "Date",
    "Passes",
    "Terrain",
    "Type",
    "Route name",
  ]; // Варианты сортировки медалей

  var medalDate = DateTime(0).obs;
  var checkedTypeFilter = "All".obs;
  var checkedTerrainFilter = "All".obs;
  var checkedBestFilter = "All".obs;
  var checkedAthletePasses = "All".obs;
  var checkedPriority = 0.obs; // Выбрана сортировка
  var filteredMedals = [].obs;
  var filteredCount = 0.obs;
  var medals = [].obs;
  var medalsRows = [].obs;

  void selectDate(BuildContext context) async {
    var tempDate = await showRoundedDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDatePickerMode: DatePickerMode.year,
      theme: ThemeData(primarySwatch: Colors.grey),
    );
    if (tempDate != null) {
      medalDate.value = tempDate;
    }
  }

  reset() {
    medalDate.value = DateTime(0);
    checkedTypeFilter.value = "All";
    checkedTerrainFilter.value = "All";
    checkedBestFilter.value = "All";
    checkedAthletePasses.value = "All";
  }

  loadMedals() {
    medals.value = [
      {
        "id": "1",
        "athlete_login": "test12",
        "athlete_passes": "43",
        "athlete_time": "2:34",
        "athlete_distance": "2414",
        "time_percent": "34",
        "distance_percent": "80",
        "route_time": "1:32",
        "route_distance": "2214",
        "route_best": "Runner",
        "route_passes": "5124",
        "route_terra": "Forest",
        "route_type": "Orient",
        "medal": "0",
        "medal_passes": "5124",
        "cp_count": "21",
        "route_name": "san4os047 109-2",
        "route_length": "32.3",
        "beated": "false",
        "date": "09.10.2021",
      },
      {
        "id": "2",
        "athlete_login": "test12",
        "athlete_passes": "2",
        "athlete_time": "2:34",
        "athlete_distance": "2414",
        "time_percent": "34",
        "distance_percent": "80",
        "route_time": "1:32",
        "route_distance": "2214",
        "route_best": "CPS",
        "route_passes": "324",
        "route_terra": "City",
        "route_type": "Quest",
        "medal": "10",
        "medal_passes": "324",
        "cp_count": "9",
        "route_name": "gostar-2",
        "route_length": "11.6",
        "beated": "false",
        "date": "09.10.2021",
      },
      {
        "id": "3",
        "athlete_login": "vasgenturbo",
        "athlete_passes": "1",
        "athlete_time": "2:34",
        "athlete_distance": "2414",
        "time_percent": "34",
        "distance_percent": "80",
        "route_time": "1:32",
        "route_distance": "2214",
        "route_best": "Runner",
        "route_passes": "5124",
        "route_terra": "Park",
        "route_type": "Detective",
        "medal": "1",
        "medal_passes": "5124",
        "cp_count": "21",
        "route_name": "san4os047 109-2",
        "route_length": "32.3",
        "beated": "false",
        "date": "09.10.2021",
      },
      {
        "id": "4",
        "athlete_login": "test12",
        "athlete_passes": "43",
        "athlete_time": "2:34",
        "athlete_distance": "2414",
        "time_percent": "34",
        "distance_percent": "80",
        "route_time": "1:32",
        "route_distance": "2214",
        "route_best": "Runner",
        "route_passes": "5124",
        "route_terra": "Forest",
        "route_type": "Rogaine",
        "medal": "50",
        "medal_passes": "5124",
        "cp_count": "21",
        "route_name": "san4os047 109-2",
        "route_length": "32.3",
        "beated": "false",
        "date": "09.10.2021",
      },
      {
        "id": "5",
        "athlete_login": "test12",
        "athlete_passes": "2",
        "athlete_time": "2:34",
        "athlete_distance": "2414",
        "time_percent": "34",
        "distance_percent": "80",
        "route_time": "1:32",
        "route_distance": "2214",
        "route_best": "CPS",
        "route_passes": "5124",
        "route_terra": "Forest",
        "medal": "20",
        "medal_passes": "7124",
        "cp_count": "21",
        "route_name": "san4os047 109-2",
        "route_length": "32.3",
        "beated": "true",
        "date": "09.10.2021",
      },
    ];
    // var result = await OriApi.getAthleteMedals(mainController.getProfileID());
    // print(result);
    // if (result.data[0]['error'].toString() != "true") {
    //   if (result.data[0]["routes"] != null)
    //     medals.value = result.data[0]["routes"];
    //   else
    //     return;
    //   print(medals);
    // } else {
    //   Get.snackbar("Error".tr,
    //       result.data[0]['description']); // Вывод на ошибку корректности данных
    // }
    setFilterMedals();
  }

  getMedalsRows() {
    List<Widget> rows = [];
    for (var i = 0; i < filteredMedals.length; i += 3) {
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            i >= filteredMedals.length
                ? Container(
                    width: Get.width / 3.5,
                  )
                : Column(
                    children: [
                      Container(
                        width: Get.width / 3.5,
                        child: Column(
                          children: [
                            Medal(
                              kof: Get.width / 550,
                              medal: filteredMedals[i],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/runner_icon.svg",
                            height: 15,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            filteredMedals[i]["route_passes"],
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${filteredMedals[i]["athlete_time"]} - ${filteredMedals[i]["athlete_distance"]}",
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 12),
                          ),
                          Text(
                            "m",
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 8),
                          ),
                        ],
                      ),
                      filteredMedals[i]["medal"] == "0"
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/ribbon_icon.svg",
                                  height: 20,
                                ),
                                Text(
                                  "You are leader!",
                                  style: MAIN_TEXT_STYLE_WHITE.copyWith(
                                    fontSize: 9,
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filteredMedals[i]["time_percent"],
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "%",
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 8),
                                    ),
                                    Text(
                                      " - ",
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 12),
                                    ),
                                    Text(
                                      filteredMedals[i]["distance_percent"],
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "%",
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 8),
                                    ),
                                  ],
                                ),
                                RoundedContainer(
                                  borderEnabled: true,
                                  borderColor: DARK_BROWN,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 3),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/leader_icon.svg"),
                                        SizedBox(width: 4.0),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${filteredMedals[i]["athlete_time"]} - ${filteredMedals[i]["athlete_distance"]}",
                                              style: MAIN_TEXT_STYLE_BLACK
                                                  .copyWith(fontSize: 10),
                                            ),
                                            Text(
                                              "m",
                                              style: MAIN_TEXT_STYLE_BLACK
                                                  .copyWith(fontSize: 8),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                      Text(
                        filteredMedals[i]["date"],
                        style: MAIN_TEXT_STYLE_BLACK.copyWith(
                            color: LIGHT_GRAY_TEXT, fontSize: 10),
                      ),
                    ],
                  ),
            i + 1 >= filteredMedals.length
                ? Container(
                    width: Get.width / 3.5,
                  )
                : Column(
                    children: [
                      Container(
                        width: Get.width / 3.5,
                        child: Column(
                          children: [
                            Medal(
                              kof: Get.width / 550,
                              medal: filteredMedals[i + 1],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/runner_icon.svg",
                            height: 15,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            filteredMedals[i + 1]["route_passes"],
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${filteredMedals[i + 1]["athlete_time"]} - ${filteredMedals[i + 1]["athlete_distance"]}",
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 12),
                          ),
                          Text(
                            "m",
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 8),
                          ),
                        ],
                      ),
                      filteredMedals[i + 1]["medal"] == "0"
                          ? Container(
                              width: 60,
                              height: 30,
                              color: GREEN,
                            )
                          : Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filteredMedals[i + 1]["time_percent"],
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "%",
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 8),
                                    ),
                                    Text(
                                      " - ",
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 12),
                                    ),
                                    Text(
                                      filteredMedals[i + 1]["distance_percent"],
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "%",
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 8),
                                    ),
                                  ],
                                ),
                                RoundedContainer(
                                  borderEnabled: true,
                                  borderColor: DARK_BROWN,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 3),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/leader_icon.svg"),
                                        SizedBox(width: 4.0),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${filteredMedals[i + 1]["athlete_time"]} - ${medals[i + 1]["athlete_distance"]}",
                                              style: MAIN_TEXT_STYLE_BLACK
                                                  .copyWith(fontSize: 10),
                                            ),
                                            Text(
                                              "m",
                                              style: MAIN_TEXT_STYLE_BLACK
                                                  .copyWith(fontSize: 8),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                      Text(
                        filteredMedals[i + 1]["date"],
                        style: MAIN_TEXT_STYLE_BLACK.copyWith(
                            color: LIGHT_GRAY_TEXT, fontSize: 10),
                      ),
                    ],
                  ),
            i + 2 >= filteredMedals.length
                ? Container(
                    width: Get.width / 3.5,
                  )
                : Column(
                    children: [
                      Container(
                        width: Get.width / 3.5,
                        child: Column(
                          children: [
                            Medal(
                              kof: Get.width / 550,
                              medal: filteredMedals[i + 2],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/runner_icon.svg",
                            height: 15,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            filteredMedals[i + 2]["route_passes"],
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${filteredMedals[i + 2]["athlete_time"]} - ${filteredMedals[i + 2]["athlete_distance"]}",
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 12),
                          ),
                          Text(
                            "m",
                            style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 8),
                          ),
                        ],
                      ),
                      filteredMedals[i + 2]["medal"] == "0"
                          ? Container(
                              width: 60,
                              height: 30,
                              color: GREEN,
                            )
                          : Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filteredMedals[i + 2]["time_percent"],
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "%",
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 8),
                                    ),
                                    Text(
                                      " - ",
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 12),
                                    ),
                                    Text(
                                      filteredMedals[i + 2]["distance_percent"],
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "%",
                                      style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                          fontSize: 8),
                                    ),
                                  ],
                                ),
                                RoundedContainer(
                                  borderEnabled: true,
                                  borderColor: DARK_BROWN,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 3),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/leader_icon.svg"),
                                        SizedBox(width: 4.0),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${filteredMedals[i + 2]["athlete_time"]} - ${medals[i + 2]["athlete_distance"]}",
                                              style: MAIN_TEXT_STYLE_BLACK
                                                  .copyWith(fontSize: 10),
                                            ),
                                            Text(
                                              "m",
                                              style: MAIN_TEXT_STYLE_BLACK
                                                  .copyWith(fontSize: 8),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                      Text(
                        filteredMedals[i + 2]["date"],
                        style: MAIN_TEXT_STYLE_BLACK.copyWith(
                            color: LIGHT_GRAY_TEXT, fontSize: 10),
                      ),
                    ],
                  ),
          ],
        ),
      );
    }
    medalsRows.value = rows;
  }

  setFilterMedals() {
    filteredCount.value = 0;
    filteredMedals.value = medals.value;
    if (medalDate.value != DateTime(0)) {
      filteredMedals.value = filteredMedals
          .where((item) =>
              DateFormat("dd.MM.yyyy").parse(item["date"]) == medalDate.value)
          .toList();
      filteredCount.value++;
    }
    switch (checkedTypeFilter.value) {
      case "All":
        break;
      default:
        filteredMedals.value = filteredMedals
            .where((item) => item["medal"] == checkedTypeFilter.value)
            .toList();
        filteredCount.value++;
        break;
    }
    switch (checkedAthletePasses.value) {
      case "All":
        break;
      case "3+":
        filteredMedals.value = filteredMedals
            .where((item) => int.parse(item["athlete_passes"]) >= 3)
            .toList();

        filteredCount.value++;
        break;
      default:
        filteredMedals.value = filteredMedals
            .where(
                (item) => item["athlete_passes"] == checkedAthletePasses.value)
            .toList();
        filteredCount.value++;
        break;
    }
    switch (checkedBestFilter.value) {
      case "All":
        break;
      default:
        filteredMedals.value = filteredMedals
            .where((item) => item["route_best"] == checkedBestFilter.value)
            .toList();
        filteredCount.value++;
        break;
    }
    switch (checkedTerrainFilter.value) {
      case "All":
        break;
      default:
        filteredMedals.value = filteredMedals
            .where((item) => item["route_terra"] == checkedTerrainFilter.value)
            .toList();
        filteredCount.value++;
        break;
    }
    setCheckedPriority(checkedPriority.value);
  }

  setCheckedPriority(int index) {
    String propertyName;
    switch (index) {
      case 0:
        propertyName = "date";
        break;
      case 1:
        propertyName = "athlete_passes";
        break;
      case 2:
        propertyName = "route_terra";
        break;
      case 3:
        propertyName = "medal";
        break;
      case 4:
        propertyName = "route_name";
        break;
      default:
        propertyName = "date";
        break;
    }
    filteredMedals.sort((a, b) {
      print(a[propertyName]);
      if (propertyName == "medal" || propertyName == "athlete_passes") {
        var temp = a;
        a = b;
        b = temp;
      }
      if (isNumeric(b[propertyName].toString())) {
        return double.parse(b[propertyName].toString())
            .compareTo(double.parse(a[propertyName].toString()));
      } else {
        return b[propertyName].compareTo(a[propertyName]);
      }
    });
    checkedPriority.value = index;
    getMedalsRows();
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadMedals();
  }
}
