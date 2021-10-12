import 'dart:typed_data';

import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/set_point/views/photo_dialog.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

class SetPointPage extends StatefulWidget {
  var setPoint;
  SetPointPage(this.setPoint);
  @override
  _SetPointPageState createState() => _SetPointPageState();
}

class _SetPointPageState extends State<SetPointPage> {
  MainController mainController = Get.find();
  ScreenshotController screenshotController = ScreenshotController();
  var arSessionManager;
  var arObjectManager;
  var webObjectNode;
  var arAnchorManager;
  var arPhoto;
  double newContainerHeight = 0;
  double previousContainerHeight = 0;
  bool fullHeight = false;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];
  var ars;
  int selectedAr = -1;

  loadArs() async {
    var response = await OriApi.getArs();
    if (response.data[0]['error'].toString() != "true") {
      setState(() {
        ars = response.data[0]["ars"];
      });
    } else {
      Get.snackbar(
          "Error".tr,
          response.data[0]
              ['description']); // Вывод на ошибку корректности данных
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // ARView(
        //   onARViewCreated: onARViewCreated,
        //   planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
        // ),
        Screenshot(
          controller: screenshotController,
          child: Image.asset(
            "assets/images/cp_picture.png",
            height: Get.height,
            width: Get.width,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: WHITE_TRANSPARENT,
                  child: SvgPicture.asset(
                    "assets/icons/arrow_back_icon.svg",
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: InkWell(
                onTap: () async {
                  screenshotController.capture().then((Uint8List? image) {
                    //Capture Done
                    setState(() {
                      arPhoto = image!;
                    });
                    Get.dialog(PhotoDialog(photo: arPhoto));
                  }).catchError((onError) {
                    print(onError);
                  });
                },
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: WHITE_TRANSPARENT,
                  child: SvgPicture.asset(
                    "assets/icons/camera_icon.svg",
                    color: DARK_BROWN,
                    height: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  if (selectedAr > -1) {
                    widget.setPoint(ars[selectedAr]["id"], arPhoto);
                    Get.back();
                  } else {
                    Get.snackbar("Warning", "Select AR to set point");
                  }
                },
                child: RoundedContainer(
                  height: 45.0,
                  width: 150.0,
                  child: Center(
                    child: Text(
                      "Set point",
                      style: MAIN_TEXT_STYLE_BLACK,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                print(newContainerHeight);
                print(details.primaryDelta!);
                if ((newContainerHeight >= 0 && details.primaryDelta! >= 0) ||
                    (newContainerHeight <= 200 && details.primaryDelta! <= 0)) {
                  previousContainerHeight = newContainerHeight;
                  setState(() {
                    newContainerHeight -= details.primaryDelta!;
                  });
                  if (newContainerHeight <= previousContainerHeight) {
                    setState(() {
                      fullHeight = false;
                    });
                  } else
                    setState(() {
                      fullHeight = true;
                    });
                }
              },
              onVerticalDragEnd: (details) {
                if (fullHeight) {
                  setState(() {
                    newContainerHeight = 200;
                  });
                } else {
                  setState(() {
                    newContainerHeight = 0;
                  });
                }
              },
              child: RoundedContainer(
                width: Get.width,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 50 + Get.width / 3.5 + newContainerHeight,
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 15,
                          // color: Colors.pink,
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundedContainer(
                                height: 5,
                                width: 80,
                                color: LIGHT_GRAY,
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.all(0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            physics: fullHeight
                                ? BouncingScrollPhysics()
                                : NeverScrollableScrollPhysics(),
                            itemCount: ars == null ? 0 : ars.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                decoration: selectedAr == i
                                    ? BoxDecoration(
                                        border: Border.all(
                                          color: LIGHT_GRAY,
                                          width: 3.8,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)))
                                    : null,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          selectedAr = i;
                                        });
                                      },
                                      child: Container(
                                        height: selectedAr == i
                                            ? Get.width / 4.2
                                            : Get.width / 4,
                                        width: Get.width / 4,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    ars[i]["image"]))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.0,
                                    ),
                                    Text(
                                      "${ars[i]["name"]}",
                                      style: MAIN_TEXT_STYLE_BLACK,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          showWorldOrigin: true,
        );
    this.arObjectManager.onInitialize();

    this.arSessionManager.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager.onNodeTap = onNodeTapped;
    loadArs();
  }

  Future<void> onNodeTapped(List<String> nodes) async {
    Get.snackbar("title", nodes.toString());
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    anchors.forEach((anchor) {
      this.arAnchorManager.removeAnchor(anchor);
    });
    anchors = [];
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    if (singleHitTestResult != null) {
      var newAnchor =
          ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool didAddAnchor = await this.arAnchorManager.addAnchor(newAnchor);
      if (didAddAnchor) {
        this.anchors.add(newAnchor);
        // Add note to anchor
        var newNode = ARNode(
            type: NodeType.webGLB,
            uri: ars[selectedAr]["model"],
            scale: vm.Vector3(0.2, 0.2, 0.2),
            position: vm.Vector3(0.0, 0.0, 0.0),
            rotation: vm.Vector4(1.0, 0.0, 0.0, 0.0));
        bool didAddNodeToAnchor =
            await this.arObjectManager.addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor) {
          this.nodes.add(newNode);
        } else {
          this.arSessionManager.onError("Adding Node to Anchor failed");
        }
      } else {
        this.arSessionManager.onError("Adding Anchor failed");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadArs();
  }
}
