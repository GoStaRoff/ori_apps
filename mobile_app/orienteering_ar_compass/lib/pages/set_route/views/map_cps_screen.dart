import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/set_route/controllers/map_cps_controller.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/help_dialog.dart';

// ignore: must_be_immutable
class MapCPSScreen extends StatelessWidget {
  MapCPSController mapCPSController = Get.put(MapCPSController());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
            () => GoogleMap(
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              compassEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              mapType: MapType.satellite,
              initialCameraPosition: mapCPSController.initialLocation,
              // ignore: unnecessary_null_comparison
              markers: Set.of((mapCPSController.marker.value != null)
                  ? [mapCPSController.marker.value, ...mapCPSController.markers]
                  : [...mapCPSController.markers]),
              // ignore: unnecessary_null_comparison
              circles: Set.of((mapCPSController.circle.value != null)
                  ? [mapCPSController.circle.value]
                  : []),
              // ignore: invalid_use_of_protected_member, unnecessary_null_comparison
              polylines: Set.of((mapCPSController.polylines.value != null)
                  // ignore: invalid_use_of_protected_member
                  ? [...mapCPSController.polylines.value]
                  : []),
              onMapCreated: (GoogleMapController controller) async {
                await mapCPSController.onMapCreated(controller, context);
                Get.appUpdate();
              },
            ),
          ),
          Positioned(
            left: 20.0,
            top: 20.0,
            child: SafeArea(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: WHITE_TRANSPARENT,
                    child: SvgPicture.asset(
                      "assets/icons/arrow_back_icon.svg",
                      color: DARK_BROWN,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: Obx(
              () => Visibility(
                visible: mapCPSController.selectedMarkers.length > 2,
                child: InkWell(
                  onTap: () {
                    mapCPSController.updateRouteCPS();
                    Get.back();
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
          ),
          Obx(
            () => Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: mapCPSController.animateToLocation,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: mapCPSController.settingLocation.value
                      ? Colors.white
                      : WHITE_TRANSPARENT,
                  child: SvgPicture.asset("assets/icons/my_position_icon.svg"),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: SafeArea(
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
          Positioned(
            bottom: 20,
            left: 20,
            child: SafeArea(
              child: Obx(
                () => Visibility(
                  visible: mapCPSController.selectedMarkers.isNotEmpty,
                  child: InkWell(
                    onTap: mapCPSController.clearSelected,
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
          ),
        ],
      ),
    );
  }
}
