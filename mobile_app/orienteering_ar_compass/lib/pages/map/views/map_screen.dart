import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/map_marker.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/set_point/views/cp_dialog.dart';
import 'package:orienteering_ar_compass/pages/set_point/views/set_point_page.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/help_dialog.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/set_route_page.dart';
import 'package:orienteering_ar_compass/service/marker_generator.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';

// ignore: must_be_immutable
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MainController mainController = Get.put(MainController());
  Marker marker = Marker(markerId: MarkerId("marker"));
  Circle circle = Circle(circleId: CircleId("circle"));
  GetStorage box = GetStorage();
  bool setPointPage = false;
  bool settingLocation = false;
  bool deletingPoint = false;
  bool settingPoint = false;
  var selectedMarkers = [];
  var markersInfo = [];
  var polylines = [];
  var markers = [];
  var mapContext;
  var controller;
  var timer;

  int counter = 0;

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(mapContext)
        .load("assets/images/location_image.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);

    setState(() {
      marker = Marker(
          markerId: MarkerId("marker"),
          position: latlng,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("circle"),
          radius: 30.0,
          zIndex: 1,
          strokeColor: Colors.white,
          strokeWidth: 0,
          center: latlng,
          fillColor: Colors.white.withAlpha(70));
    });
  }

  animateToLocation() async {
    setState(() {
      settingLocation = true;
    });
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        new CameraPosition(
          target: LatLng(mainController.currentLocation.value.latitude!,
              mainController.currentLocation.value.longitude!),
          zoom: 16.50,
        ),
      ),
    );
    setState(() {
      settingLocation = false;
    });
  }

  updateMarkers() async {
    polylines.clear();
    for (int i = 1; i < selectedMarkers.length; i++) {
      setState(() {
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
      });
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
      markers = [];
      for (int i = 0; i < result.length; i++) {
        setState(() {
          markers.add(
            Marker(
              draggable: false,
              zIndex: 2,
              flat: false,
              anchor: Offset(0.5, 0.05),
              markerId: MarkerId(
                "markerId$i",
              ),
              position: LatLng(double.parse(result[i]["lat"]),
                  double.parse(result[i]["lng"])),
              icon: BitmapDescriptor.fromBytes(bitmapList[i]),
              onTap: () {
                if (setPointPage) {
                  Get.dialog(
                    CPDialog(
                      id: result[i]["name"].toString(),
                      latitude: double.parse(result[i]["lat"]),
                      longitude: double.parse(result[i]["lng"]),
                      deletingPoint: deletingPoint,
                      deletePoint: deletePoint,
                      imageLink: result[i]["photo"].length > 0
                          ? result[i]["photo"]
                          : result[i]["ar_photo"],
                    ),
                  );
                } else if (!setPointPage) {
                  if (markersInfo[i]["marker_id"] == null) {
                    markersInfo[i]["marker_id"] = counter++;
                    setState(() {
                      selectedMarkers.add(markersInfo[i]);
                    });
                    updateMarkers();
                  }
                }
              },
            ),
          );
        });
      }
      // updateMarkers(, false);
    });
    mg.generate(mapContext);
  }

  updateLocation() async {
    Uint8List imageData = await getMarker();
    updateMarkerAndCircle(mainController.currentLocation.value, imageData);
  }

  loadCPS() async {
    var result = await OriApi.getPoints(box.read("id"));
    if (result.data[0]['error'].toString() != "true") {
      setState(() {
        markersInfo = result.data[0]["points"];
      });
      print(markersInfo);
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
  }

  setPoint(String arID, arPhoto) async {
    setState(() {
      settingPoint = true;
    });
    var result = await OriApi.setPoint(
        box.read("id"),
        mainController.currentLocation.value.latitude!,
        mainController.currentLocation.value.longitude!,
        arPhoto,
        arID);
    if (result.data[0]['error'].toString() != "true") {
      await loadCPS();
      await updateMarkers();
      setState(() {
        settingPoint = false;
      });
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
  }

  deletePoint(String name) async {
    setState(() {
      deletingPoint = true;
    });
    var result = await OriApi.delPoint(name);
    if (result.data[0]['error'].toString() != "true") {
      await loadCPS();
      setState(() {
        deletingPoint = false;
      });
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
    updateMarkers();
    Get.back();
  }

  onMapCreated(GoogleMapController controller, context) async {
    mainController.updateCPS = loadCPS;
    setState(() {
      mapContext = context;
      this.controller = controller;
    });
    loadCPS();
    await updateMarkers();
    await animateToLocation();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) async {
      try {
        await updateLocation();
      } catch (e) {
        t.cancel();
      }
    });

    await updateMarkers();
  }

  clearSelected() {
    setState(() {
      for (int i = 0; i < markersInfo.length; i++) {
        markersInfo[i]["marker_id"] = null;
      }
      selectedMarkers.clear();
      counter = 0;
    });
    updateMarkers();
  }

  @override
  void initState() {
    super.initState();
    mainController.onChangePageCallback = (int pageIndex) {
      setState(() {
        if (pageIndex == 0) {
          setPointPage = true;
          clearSelected();
        } else
          setPointPage = false;
      });
    };
  }

  @override
  void dispose() {
    try {
      controller = null;
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            mapType: MapType.satellite,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.42796133580664, -122.085749655962),
              zoom: 14.4746,
            ),
            // ignore: unnecessary_null_comparison
            markers:
                // ignore: unnecessary_null_comparison
                Set.of((marker != null) ? [marker, ...markers] : [...markers]),
            // ignore: unnecessary_null_comparison
            circles: Set.of((circle != null) ? [circle] : []),
            // ignore: invalid_use_of_protected_member, unnecessary_null_comparison
            polylines: Set.of((polylines != null)
                // ignore: invalid_use_of_protected_member
                ? [...polylines]
                : []),
            onMapCreated: (GoogleMapController controller) async {
              await onMapCreated(controller, context);
              // Get.appUpdate();
            },
          ),
          Positioned(
            bottom: 100,
            child: setPointPage
                ? InkWell(
                    onTap: () async {
                      Get.to(SetPointPage(setPoint));
                      // var result = await OriApi.setPoint(
                      //     box.read("id"),
                      //     mainController.currentLocation.value.latitude!,
                      //     mainController.currentLocation.value.longitude!);
                      // print(result.data);
                      // if (result.data[0]['error'].toString() != "true") {
                      //   setState(() {
                      //     markersInfo.add({
                      //       "name": result.data[0]["id_point"],
                      //       "lat": mainController
                      //           .currentLocation.value.latitude!
                      //           .toString(),
                      //       "lng": mainController
                      //           .currentLocation.value.longitude!
                      //           .toString(),
                      //     });
                      //   });
                      // }
                      // await updateMarkers();
                    },
                    child: RoundedContainer(
                      height: 44,
                      width: 150,
                      color: settingPoint ? Colors.white : WHITE_TRANSPARENT,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Set point".tr,
                            style: MAIN_TEXT_STYLE_BLACK,
                          )
                        ],
                      ),
                    ),
                  )
                : Visibility(
                    visible: selectedMarkers.length > 2,
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          SetRoutePage(
                            cpsList: selectedMarkers,
                          ),
                        );
                      },
                      child: RoundedContainer(
                        height: 44,
                        width: 150,
                        color: WHITE_TRANSPARENT,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Set route".tr,
                              style: MAIN_TEXT_STYLE_BLACK,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: InkWell(
              onTap: animateToLocation,
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor:
                    settingLocation ? Colors.white : WHITE_TRANSPARENT,
                child: SvgPicture.asset("assets/icons/my_position_icon.svg"),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: SafeArea(
              child: Visibility(
                visible: !setPointPage,
                child: InkWell(
                  onTap: () {
                    Get.dialog(HelpDialog());
                  },
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: WHITE_TRANSPARENT,
                    child: SvgPicture.asset("assets/icons/help_icon.svg"),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 20,
            child: SafeArea(
              child: Visibility(
                visible: selectedMarkers.isNotEmpty,
                child: InkWell(
                  onTap: clearSelected,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: WHITE_TRANSPARENT,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/images/clear_image.png"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
