import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart' as gv;
import 'package:image_picker/image_picker.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';

class SetRouteController extends GetxController {
  MainController mainController = Get.find();
  gv.SugiyamaConfiguration builder = gv.SugiyamaConfiguration();
  var routeNameTextController = new TextEditingController();
  var descriptionTextController = new TextEditingController();
  var mapScaleTextController = new TextEditingController();
  var transitions = new List.filled(0, Map<String, dynamic>()).obs;
  var graph = gv.Graph().obs;
  var checkedThemes = "Science".obs;
  var checkedMethod = "Runner".obs;
  var checkedTypeOpen = "Open".obs;
  var checkedTerra = "Forest".obs;
  var checkedType = "Orient".obs;
  var checkedCPS = "obo".obs;
  var priceText = "0".obs;
  var avatarPath = "".obs;
  var hintText = "2".obs;
  var mapPath = "".obs;
  var nodes = [];
  var cps = [].obs;
  var position;
  var saving = false.obs;
  var updateGraphWidget;

  save() async {
    print(cps);
    // print(transitions);
    // return;
    if (routeNameTextController.text.length < 2) {
      Get.snackbar("Save error", "Route name may has less than 2 letters");
      return;
    }
    if (descriptionTextController.text.length < 10) {
      Get.snackbar(
          "Save error", "Route description may has less than 10 letters");
      return;
    }
    if (avatarPath.value.length == 0) {
      Get.snackbar("Save error", "Choose picture for route");
      return;
    }
    switch (checkedType.value) {
      case "Quest":
        for (var i = 0; i < transitions.length; i++) {
          if (transitions[i]["answers"] == null ||
              transitions[i]["answers"].length < 2) {
            Get.snackbar("Save error", "Not all transitions set");
            return;
          }
        }
        break;
      case "Rogaine":
        for (var i = 0; i < cps.length; i++) {
          if (cps[i]["rogaine_value"] == null ||
              cps[i]["rogaine_value"].length <= 0) {
            Get.snackbar("Save error", "Not all rogaine value set");
            return;
          }
        }
        break;
      case "Detective":
        for (var i = 0; i < cps.length; i++) {
          if (cps[i]["answers"] == null || cps[i]["answers"].length <= 0) {
            Get.snackbar("Save error", "Not all CPs set");
            return;
          }
          if (cps[i]["answers"][0]["cp_id"] == null) {
            for (int j = 0; j < cps[i]["answers"].length; j++) {
              // ignore: unnecessary_statements
              cps[i]["answers"][j]["cp_id"] == "empty";
            }
          }
        }
        break;
      case "Orient":
      default:
        break;
    }
    saving.value = true;
    var result = await OriApi.createRoute(
        mainController.getProfileID(),
        routeNameTextController.text,
        descriptionTextController.text,
        checkedTypeOpen.value,
        checkedType.value,
        checkedThemes.value,
        checkedMethod.value,
        checkedTerra.value,
        int.parse(hintText.value),
        // ignore: unrelated_type_equality_checks
        priceText.value == "" ? 0 : int.parse(priceText.value),
        avatarPath.value,
        mapPath.value,
        position["x"].toString(),
        position["y"].toString(),
        // ignore: unnecessary_null_comparison
        int.parse(mapScaleTextController.text == null
            ? mapScaleTextController.text
            : "0"),
        // ignore: invalid_use_of_protected_member
        cps.value,
        // ignore: invalid_use_of_protected_member
        transitions.value);
    saving.value = false;
    if (result == null || result.data[0]['error'].toString() != "true") {
      mainController.updateRoutes();
      Get.back();
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
  }

  SetRouteController(var cpsList) {
    updateCPS(cpsList);
    mapScaleTextController.text = "1";

    position = {"x": "0", "y": "0"};
  }

  clear() {
    routeNameTextController.clear();
    descriptionTextController.clear();
    mapScaleTextController.clear();
    checkedThemes = "Science".obs;
    checkedMethod = "Runner".obs;
    checkedTypeOpen = "Open".obs;
    checkedTerra = "Forest".obs;
    checkedType = "Orient".obs;
    checkedCPS = "obo".obs;
    priceText = "0".obs;
    avatarPath = "".obs;
    hintText = "2".obs;
    mapPath = "".obs;
    saving = false.obs;
    position = {"x": "0", "y": "0"};
    Get.appUpdate();
  }

  String notUsed() {
    int counter = 0;
    for (var i = 0; i < cps.length; i++) {
      bool consist = false;
      if (cps[i]["answers"] != null) {
        cps[i]["answers"].forEach((node) {
          if (node["cp_id"] == cps[i]["name"]) {
            consist = true;
          }
        });
      }
      if (consist) counter++;
    }
    return (cps.length - counter).toString();
  }

  updateGraph(bool filled) {
    if (filled) {
      graph.value.edges.clear();
      for (int i = 0; i < cps.length; i++) {
        if (cps[i]["answers"] != null && cps[i]["answers"].length > 0) {
          for (int j = 0; j < cps[i]["answers"].length; j++) {
            var tempIndex = cps.indexWhere(
                (element) => cps[i]["answers"][j]["cp_id"] == element["name"]);
            graph.value.addEdge(nodes[i], nodes[tempIndex]);
          }
        }

        print(cps[i]);
      }
    }
    updateGraphWidget();
  }

  updateCPS(cpsList) {
    cps.value = cpsList;
    for (int i = 0; i < cps.length; i++) {
      nodes.add(
        gv.Node.Id(i),
      );
      cps[i]["question"] = null;
      cps[i]["cp_name"] = null;
      cps[i]["answers"] = null;
      cps[i]["avatar"] = null;
      cps[i]["sound"] = null;
    }
  }

  showMethodPicture() {
    switch (checkedMethod.value) {
      case "Runner":
        return SvgPicture.asset(
          "assets/icons/runner_icon.svg",
          color: DARK_BROWN,
          height: 20.0,
        );
      case "Bike":
        return SvgPicture.asset(
          "assets/icons/bike_icon.svg",
          color: DARK_BROWN,
          height: 20.0,
        );
      case "Ski":
      default:
        return SvgPicture.asset(
          "assets/icons/ski_icon.svg",
          color: DARK_BROWN,
          height: 20.0,
        );
    }
  }

  showTerraPicture() {
    switch (checkedTerra.value) {
      case "Forest":
        return SvgPicture.asset(
          "assets/icons/forest_icon.svg",
          color: DARK_BROWN,
          height: 20.0,
        );
      case "Park":
        return SvgPicture.asset(
          "assets/icons/park_icon.svg",
          color: DARK_BROWN,
          height: 20.0,
        );
      case "City":
      default:
        return SvgPicture.asset(
          "assets/icons/city_icon.svg",
          color: DARK_BROWN,
          height: 20.0,
        );
    }
  }

  setRoutePicture() async {
    PickedFile? avatar =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (avatar != null) {
      avatarPath.value = avatar.path;
    }
  }

  @override
  void onInit() {
    super.onInit();
    //getDistanceToStart();
    // graph.addEdge(nodes[0], nodeWrapper(() {}, Text("Make answer")));
    builder..orientation = gv.SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM;

    Get.appUpdate();
  }

  Color circleColor() {
    switch (checkedType.value) {
      case "Quest":
        return ORANGE;
      case "Rogaine":
        return VIOLET;
      case "Detective":
        return LIGHT_RED;
      default:
        return ORIENT_COLOR;
    }
  }
}
