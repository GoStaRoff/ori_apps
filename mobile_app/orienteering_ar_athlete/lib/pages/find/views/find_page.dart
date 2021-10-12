import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/find/views/question_page.dart';
import 'package:orienteering_ar_athlete/service/ori_api.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
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
        Positioned(
          child: Screenshot(
            controller: screenshotController,
            child: Image.asset(
              "assets/images/cp_picture.png",
              height: Get.height,
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Positioned(
        //   top: 20,
        //   left: 20,
        //   child: Material(
        //     color: Colors.transparent,
        //     child: SafeArea(
        //       child: InkWell(
        //         onTap: () {
        //           Get.back(closeOverlays: true);
        //         },
        //         child: CircleAvatar(
        //           radius: 30.0,
        //           backgroundColor: WHITE_TRANSPARENT,
        //           child: SvgPicture.asset(
        //             "assets/icons/arrow_back_icon.svg",
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        Obx(
          () => Positioned(
            top: Get.height / 4,
            child: mainController.showAR.value
                ? InkWell(
                    onTap: () {
                      switch (mainController.currentRoute["route_type"]) {
                        case "Detective":
                          if (mainController
                                  .currentRoute["next_cp"].value.length >
                              0) {
                            Get.to(() => QuestionPage(
                                  cpQuestion: true,
                                  index:
                                      mainController.currentRoute["next_cp_i"],
                                  question: mainController
                                          .currentRoute["cps"].value[
                                      mainController.currentRoute["next_cp_i"]],
                                ));
                          } else {
                            mainController.currentRoute["step"].value = -1;
                            mainController.onChangePage(2);
                          }
                          break;
                        case "Rogaine":
                          mainController.currentRoute["rogaine_sum"] +=
                              int.parse(mainController
                                  .currentRoute["rogaine_cp"]["rogaine_value"]);

                          mainController.currentRoute["passed_cps"]
                              .add(mainController.currentRoute["rogaine_cp"]);
                          var cp = mainController.currentRoute["cps"].value
                              .firstWhere((_cp) =>
                                  _cp["name"] ==
                                  mainController.currentRoute["rogaine_cp"]
                                      ["name"]);
                          cp["is_active"].value = false;
                          mainController.currentRoute["cps"].value.removeWhere(
                              (cp) =>
                                  cp["name"] ==
                                  mainController.currentRoute["rogaine_cp"]
                                      ["name"]);
                          mainController.currentRoute["cps"].value = [
                            ...mainController.currentRoute["cps"].value,
                            cp
                          ];
                          mainController.onChangePage(2);
                          break;
                        case "Quest":
                          if (mainController.currentRoute["step"].value <
                              mainController
                                  .currentRoute["transitions"].length) {
                            Get.to(() => QuestionPage(
                                  cpQuestion: false,
                                  isLast: mainController
                                          .currentRoute["step"].value ==
                                      mainController
                                          .currentRoute["transitions"].length,
                                  index:
                                      mainController.currentRoute["step"].value,
                                  question:
                                      mainController.currentRoute["transitions"]
                                          [mainController
                                              .currentRoute["step"].value],
                                  withFullAnswer:
                                      mainController.currentRoute["transitions"]
                                              [mainController
                                                  .currentRoute["step"]
                                                  .value]["is_full"] ==
                                          "true",
                                ));
                          } else {
                            mainController.currentRoute["step"].value = -1;
                            mainController.onChangePage(2);
                          }
                          break;
                        default:
                          if (mainController.currentRoute["step"].value <
                              mainController.currentRoute["cps"].value.length -
                                  1) {
                            mainController.currentRoute["step"]++;
                          } else {
                            mainController.currentRoute["step"].value = -1;
                          }
                          mainController.onChangePage(2);
                          break;
                      }
                    },
                    child: Container(
                      width: Get.width / 2,
                      height: Get.width / 2,
                      color: Colors.green.withOpacity(0.5),
                    ),
                  )
                : Container(
                    width: Get.width / 2,
                    height: Get.width / 2,
                    color: Colors.red.withOpacity(0.5),
                  ),
          ),
        ),
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
