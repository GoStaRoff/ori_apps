import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/main_button.dart';
import 'package:orienteering_ar_compass/pages/global_components/map_marker.dart';
import 'package:orienteering_ar_compass/pages/set_route/controllers/set_route_controller.dart';
import 'package:orienteering_ar_compass/service/marker_generator.dart';

class SetMapPage extends StatefulWidget {
  static String id = '/set_map';

  @override
  _SetMapPageState createState() => _SetMapPageState();
}

class _SetMapPageState extends State<SetMapPage> {
  SetRouteController setRouteController = Get.find();
  String pickedMap = "";
  bool showInstruction = true;
  Offset position = Offset(0, 0);
  var image;

  save() {
    setRouteController.position = {"x": position.dx, "y": position.dy};
    setRouteController.mapPath.value = pickedMap;
    Get.back();
  }

  @override
  void initState() {
    super.initState();
    if (setRouteController.position["x"] != "0" &&
        setRouteController.position["y"] != "0") {
      position = new Offset(
          setRouteController.position["x"], setRouteController.position["y"]);
    }
    pickedMap = setRouteController.mapPath.value;
    MarkerGenerator([
      MapMarker(
        id: setRouteController.cps[0]["name"],
        number: 0,
      )
    ], (images) {
      ui.decodeImageFromList(images[0], (img) {
        setState(() {
          image = img;
        });
      });
    }).generate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: Stack(
        alignment: Alignment.center,
        children: [
          InteractiveViewer(
            constrained: false,
            maxScale: 5,
            minScale: 0.001,
            child: GestureDetector(
                onTapDown: (TapDownDetails event) {
                  setState(() {
                    position = event.localPosition;
                  });
                },
                child: Stack(
                  children: [
                    Image.file(File(pickedMap)),
                    CustomPaint(
                      willChange: true,
                      painter: MapPainter(
                        pos: position,
                        image: image,
                      ),
                    ),
                  ],
                )),
          ),
          showInstruction
              ? Container()
              : Positioned(
                  bottom: 25.0,
                  child: MainButton(
                    text: "Save".tr,
                    onPressed: save,
                    isActive: true,
                    width: 150.0,
                  ),
                ),
          showInstruction
              ? Container()
              : Positioned(
                  top: 20,
                  left: 20,
                  child: SafeArea(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          "assets/icons/arrow_back_icon.svg",
                        ),
                      ),
                    ),
                  ),
                ),
          showInstruction
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      showInstruction = false;
                    });
                  },
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black.withOpacity(0.75),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(),
                        MapMarker(
                          id: setRouteController.cps[0]["name"],
                          number: 0,
                        ),
                        Text(
                          "Show Start CP ${setRouteController.cps[0]["name"]}\n\nEnlarge the map to be\nprecise as possible!",
                          style: MAIN_TEXT_STYLE_WHITE,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  Offset pos;
  var image;

  MapPainter({required this.pos, this.image});

  @override
  void paint(Canvas canvas, Size size) {
    if (pos != Offset(0, 0) && image != null) {
      Offset position = Offset(pos.dx - 69, pos.dy - 90);
      canvas.drawImage(image, position, Paint());
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
