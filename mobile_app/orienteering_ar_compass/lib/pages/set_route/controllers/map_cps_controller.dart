import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orienteering_ar_compass/constants/math.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/map_marker.dart';
import 'package:orienteering_ar_compass/pages/set_route/controllers/set_route_controller.dart';
import 'package:orienteering_ar_compass/service/marker_generator.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';

class MapCPSController extends GetxController {
  var marker = Marker(markerId: MarkerId("marker")).obs;
  var circle = Circle(circleId: CircleId("circle")).obs;
  SetRouteController setRouteController = Get.find();
  MainController mainController = Get.find();
  GetStorage box = GetStorage();
  var settingLocation = false.obs;
  var selectedMarkers = [].obs;
  var markersInfo = [].obs;
  var polylines = [].obs;
  var markers = [].obs;
  var mapContext;
  var controller;
  var timer;

  int counter = 0;

  final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  animateToLocation() async {
    settingLocation.value = true;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        new CameraPosition(
          target: LatLng(mainController.currentLocation.value.latitude!,
              mainController.currentLocation.value.longitude!),
          zoom: 16.50,
        ),
      ),
    );
    settingLocation.value = false;
  }

  updateMarkers() async {
    polylines.clear();
    for (int i = 1; i < selectedMarkers.length; i++) {
      polylines.add(Polyline(
        color: Colors.white,
        visible: true,
        width: 2,
        points: [
          LatLng(double.parse(selectedMarkers[i - 1]["lat"]),
              double.parse(selectedMarkers[i - 1]["lng"])),
          LatLng(double.parse(selectedMarkers[i]["lat"]),
              double.parse(selectedMarkers[i]["lng"])),
        ],
        polylineId: PolylineId("distance" + i.toString()),
      ));
    }
    var result = markersInfo;
    List<Widget> markersWidgets = [];
    for (int i = 0; i < result.length; i++) {
      markersInfo[i]["last_marker"] = false;
      if (markersInfo[i]["marker_id"] == counter - 1) {
        markersInfo[i]["last_marker"] = true;
      }
      markersWidgets.add(
        MapMarker(
          id: result[i]["name"].toString(),
          number: result[i]["marker_id"],
          lastMarker: result[i]["last_marker"],
        ),
      );
    }
    MarkerGenerator mg =
        MarkerGenerator(markersWidgets, (List<Uint8List> bitmapList) {
      markers.value = [];
      for (int i = 0; i < result.length; i++) {
        markers.add(
          Marker(
            draggable: false,
            zIndex: 2,
            flat: false,
            anchor: Offset(0.5, 0.05),
            markerId: MarkerId(
              "markerId$i",
            ),
            position: LatLng(
                double.parse(result[i]["lat"]), double.parse(result[i]["lng"])),
            icon: BitmapDescriptor.fromBytes(bitmapList[i]),
            onTap: () {
              if (markersInfo[i]["marker_id"] == null) {
                markersInfo[i]["marker_id"] = counter++;
                selectedMarkers.add(markersInfo[i]);
                updateMarkers();
              }
            },
          ),
        );
      }
      // updateMarkers(, false);
    });
    mg.generate(mapContext);
  }

  updateRouteCPS() {
    setRouteController.updateCPS(selectedMarkers);
    setRouteController.transitions.clear();
    for (int i = 0; i < selectedMarkers.length - 1; i++) {
      setRouteController.transitions.add({
        "id": "$i",
        "is_full": false,
        "correct_answer": "",
        "avatar": "",
        "sound": "",
        "question": "",
        "answers": null,
        "show_info": true,
        "distance": calculateDistanceMeters(
          double.parse(selectedMarkers[i]["lat"]),
          double.parse(selectedMarkers[i]["lng"]),
          double.parse(selectedMarkers[i + 1]["lat"]),
          double.parse(selectedMarkers[i + 1]["lng"]),
        ),
        "angle": calculateAngle(
          double.parse(selectedMarkers[i + 1]["lng"]),
          double.parse(selectedMarkers[i]["lng"]),
          double.parse(selectedMarkers[i + 1]["lat"]),
          double.parse(selectedMarkers[i]["lat"]),
        ),
      });
    }
  }

  loadCPS() async {
    counter = 0;
    var result = await OriApi.getPoints(box.read("id"));
    if (result.data[0]['error'].toString() != "true") {
      markersInfo.value = result.data[0]["points"];
      selectedMarkers.value = new List.from(setRouteController.cps);
      for (var cp in setRouteController.cps) {
        markersInfo.forEach((element) {
          if (cp["name"] == element["name"]) {
            element["marker_id"] = cp["marker_id"];
            counter = cp["marker_id"];
            if (cp["marker_id"] > counter) counter = cp["marker_id"];
          }
        });
      }
      counter++;
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
  }

  onMapCreated(GoogleMapController controller, context) async {
    mapContext = context;
    await loadCPS();
    this.controller = controller;
    await updateMarkers();

    await updateMarkers();
    await animateToLocation();
  }

  clearSelected() {
    for (int i = 0; i < markersInfo.length; i++) {
      markersInfo[i]["marker_id"] = null;
    }
    selectedMarkers.clear();
    counter = 0;
    updateMarkers();
  }

  @override
  void onClose() {
    controller = null;
    super.onClose();
  }
}
