import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart';
import 'package:graphview/GraphView.dart' as gv;
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/map_marker.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_compass/pages/set_route/components/cps_page_widget.dart';
import 'package:orienteering_ar_compass/pages/set_route/controllers/set_route_controller.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/cp_page.dart';
import 'package:orienteering_ar_compass/pages/set_route/views/map_cps_screen.dart';

// ignore: must_be_immutable
class CPSPage extends StatefulWidget {
  static String id = "/cps";

  @override
  State<CPSPage> createState() => _CPSPageState();
}

class _CPSPageState extends State<CPSPage> {
  SetRouteController setRouteController = Get.find();

  MainController mainController = Get.find();
  @override
  void initState() {
    super.initState();
    setRouteController.updateGraphWidget = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => PageWrapper(
          withListView: setRouteController.checkedType.value != "Detective",
          header: Header(
            middleWidget: Row(
              children: [
                Obx(
                  () => CircleAvatar(
                    radius: 20,
                    backgroundColor: setRouteController.circleColor(),
                    child: Center(
                      child: Text(
                        setRouteController.checkedType.value[0],
                        style: MAIN_TEXT_STYLE_WHITE,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  mainController.profileLogin +
                      "-" +
                      mainController.lastRoute.toString(),
                  style: MAIN_TEXT_STYLE_BLACK,
                ),
              ],
            ),
            rightWidget: InkWell(
              onTap: () {
                Get.to(() => MapCPSScreen());
              },
              child: SvgPicture.asset(
                "assets/icons/map_nav_icon.svg",
                height: 25.0,
                color: DARK_BROWN,
              ),
            ),
          ),
          children: [
            Obx(
              () => setRouteController.checkedType.value == "Detective"
                  ? Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "How to use",
                                style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                    color: ORIENT_COLOR, fontSize: 12.0),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(
                                Icons.help,
                                color: ORIENT_COLOR,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  border: Border.all(
                                      color: DARK_BROWN, width: 0.3)),
                              width: Get.width,
                              child: Obx(
                                () => setRouteController
                                        .graph.value.edges.isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => CPPage(index: 0));
                                              },
                                              child: MapMarker(
                                                id: setRouteController.cps[0]
                                                    ["name"],
                                                number: 0,
                                              ),
                                            ),
                                          ])
                                    : InteractiveViewer(
                                        constrained: false,
                                        boundaryMargin: EdgeInsets.all(100),
                                        minScale: 0.01,
                                        maxScale: 5.6,
                                        child: Obx(
                                          () => GraphView(
                                            graph:
                                                setRouteController.graph.value,
                                            algorithm:
                                                FruchtermanReingoldAlgorithm(),
                                            paint: Paint()
                                              ..color = Colors.green
                                              ..strokeWidth = 1
                                              ..style = PaintingStyle.stroke,
                                            builder: (gv.Node node) {
                                              var i = node.key!.value as int;
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 30.0,
                                                        horizontal: 20.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        new CPPage(index: i));
                                                  },
                                                  child: MapMarker(
                                                      id: setRouteController
                                                          .cps[i]["name"],
                                                      number: i == 0 ? 0 : null,
                                                      lastMarker:
                                                          setRouteController
                                                                  .cps[i]
                                                              ["lastMarker"]),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    )
                  : Obx(
                      () => Column(
                        children: List.generate(
                          setRouteController.cps.length,
                          (i) => CPSPageWidget(
                            index: i,
                            ordered: setRouteController.checkedType.value ==
                                    "Orient" ||
                                setRouteController.checkedType.value == "Quest",
                          ),
                        ).toList(),
                      ),
                    ),
            ),
          ],
        ));
  }
}
