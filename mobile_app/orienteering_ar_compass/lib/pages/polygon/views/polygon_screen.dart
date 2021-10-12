import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/loader_indicator.dart';
import 'package:orienteering_ar_compass/pages/global_components/main_button.dart';
import 'package:orienteering_ar_compass/pages/global_components/map_marker.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_compass/pages/polygon/controllers/polygon_controller.dart';

// ignore: must_be_immutable
class PolygonScreen extends StatelessWidget {
  PolygonController polygonController = Get.put(PolygonController());
  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      children: [
        SizedBox(
          height: 200.0,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LoaderIndicator(),
              MapMarker(id: "AQ1911"),
              SizedBox(
                height: 200.0,
              ),
              MainButton(
                  text: "CPPAGE",
                  onPressed: () {
                    // Get.to(CPPage(id: "AQDF"));
                  },
                  isActive: true)
            ],
          ),
        ),
      ],
    );
  }
}
