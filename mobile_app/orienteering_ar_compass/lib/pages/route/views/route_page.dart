import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/cps.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_list_view.dart';
import 'package:orienteering_ar_compass/pages/global_components/distance.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/loader_indicator.dart';
import 'package:orienteering_ar_compass/pages/global_components/money.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_padding.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/route/views/comments_page.dart';
import 'package:orienteering_ar_compass/pages/route/views/delete_route_dialog.dart';
import 'package:orienteering_ar_compass/pages/route/views/passes_page.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

// ignore: must_be_immutable
class RoutePage extends StatefulWidget {
  // RouteController routeController = Get.put(RouteController());
  String routeID;
  RoutePage(this.routeID);

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  var route;
  bool isLoading = false;
  MainController mainController = Get.find();

  loadRoute() async {
    setState(() {
      isLoading = true;
    });

    var responce =
        await OriApi.getRoute(mainController.getProfileID(), widget.routeID);
    print(responce.data[0]);
    route = responce.data[0];

    route["distance_start"] = "2";
    route["route_cps_count"] = route["cps"].length.toString();
    if (route["route_type"] == "Rogaine" ||
        route["route_type"] == "Detective") {
      route["route_length"] = "0";
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    mainController.updateRoute = loadRoute;
    loadRoute();
  }

  getCircle() {
    if (route == null) {
      return Container();
    }
    String text;
    Color color;
    switch (route["route_type"]) {
      case "Orient":
        text = "O";
        color = ORIENT_COLOR;
        break;
      case "Quest":
        text = "Q";
        color = ORANGE;
        break;
      case "Rogaine":
        text = "R";
        color = VIOLET;
        break;
      default:
        text = "D";
        color = LIGHT_RED;
        break;
    }
    return CircleAvatar(
      radius: 20,
      backgroundColor: color,
      child: Center(
        child: Text(
          text,
          style: MAIN_TEXT_STYLE_WHITE,
        ),
      ),
    );
  }

  getTerra() {
    String icon;
    switch (route["route_terra"]) {
      case "Forest":
        icon = "assets/icons/forest_icon.svg";
        break;
      case "City":
        icon = "assets/icons/city_icon.svg";
        break;
      default:
        icon = "assets/icons/park_icon.svg";
        break;
    }
    return icon;
  }

  getMethod() {
    String icon;
    switch (route["route_method"]) {
      case "Runner":
        icon = "assets/icons/runner_icon.svg";
        break;
      case "Bike":
        icon = "assets/icons/bike_icon.svg";
        break;
      default:
        icon = "assets/icons/ski_icon.svg";
        break;
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            PagePadding(
              child: Column(
                children: [
                  Header(
                    middleWidget: Row(
                      children: [
                        getCircle(),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          isLoading ? "Loading" : route["route_generated_name"],
                          style: MAIN_TEXT_STYLE_BLACK,
                        )
                      ],
                    ),
                    rightWidget: isLoading
                        ? null
                        : InkWell(
                            onTap: () async {
                              bool deleted = false;
                              await Get.dialog(DeleteRouteDialog(
                                onDiscard: (bool _deleted) {
                                  deleted = _deleted;
                                },
                                routeId: widget.routeID,
                              ));
                              if (deleted) {
                                mainController.updateRoutes();
                                Get.back();
                              }
                            },
                            child:
                                SvgPicture.asset("assets/icons/trash_icon.svg"),
                          ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            isLoading
                ? Column(
                    children: [
                      SizedBox(
                        height: Get.height / 3,
                      ),
                      Center(child: LoaderIndicator()),
                    ],
                  )
                : Expanded(
                    child: CustomListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                              getTerra(),
                              color: DARK_BROWN,
                              height: 20.0,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(PassesPage());
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/runner_icon.svg",
                                    color: DARK_BROWN,
                                    height: 20.0,
                                  ),
                                  Text(
                                    route["route_passes_count"],
                                    style: MAIN_TEXT_STYLE_BLACK,
                                  ),
                                ],
                              ),
                            ),
                            route["route_type"] == "Orient" ||
                                    route["route_type"] == "Quest"
                                ? Distance(
                                    distance: route["route_length"].toString(),
                                  )
                                : SvgPicture.asset(
                                    getMethod(),
                                    color: DARK_BROWN,
                                    height: 20.0,
                                  ),
                            CPS(
                              count: route["route_cps_count"],
                            ),
                            InkWell(
                              onTap: () async {
                                await Get.to(CommentsPage(
                                  comments: route["comments"],
                                  routeId: route["route_id"],
                                ));
                                setState(() {});
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: GREEN,
                                        size: 18,
                                      ),
                                      Text(
                                        route["route_rate"].toString(),
                                        style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                            color: GREEN),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        route["comments"].length.toString() +
                                            " comments".tr,
                                        style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                            fontSize: 10.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Money(
                              count: route["route_price"],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Stack(
                          children: [
                            Positioned(
                              child: Center(
                                child: Image.network(
                                  route["route_avatar"],
                                  fit: BoxFit.cover,
                                  height: 240.0,
                                  width: Get.width,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 220.0,
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    minHeight: Get.height / 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      topLeft: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: BG_COLOR,
                                              radius: 40.0,
                                              backgroundImage: NetworkImage(
                                                  route["cps"][0]["photo"]
                                                              .length >
                                                          0
                                                      ? route["cps"][0]["photo"]
                                                      : route["cps"][0]
                                                          ["ar_photo"]),
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Start CP".tr,
                                                  style: MAIN_TEXT_STYLE_BLACK
                                                      .copyWith(fontSize: 18.0),
                                                ),
                                                Row(
                                                  children: [
                                                    RoundedContainer(
                                                      height: 30.0,
                                                      color: BG_COLOR,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          horizontal: 10.0,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                "assets/icons/google_maps_logo.svg"),
                                                            SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            Text(
                                                              route["cps"][0]
                                                                  ["lat"],
                                                              style: MAIN_TEXT_STYLE_BLACK
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12.0),
                                                            ),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Text(
                                                              route["cps"][0]
                                                                  ["lng"],
                                                              style: MAIN_TEXT_STYLE_BLACK
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12.0),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        route["map_image"].length > 0
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      http.Response response =
                                                          await http.get(
                                                        Uri.parse(
                                                            route["map_image"]),
                                                      );

                                                      await WcFlutterShare
                                                          .share(
                                                        sharePopupTitle:
                                                            'share',
                                                        subject: 'Route map',
                                                        text:
                                                            'Map from route ${route["route_generated_name"]}',
                                                        fileName: 'map.png',
                                                        mimeType: 'image/png',
                                                        bytesOfFile:
                                                            response.bodyBytes,
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        color: BG_COLOR,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20.0),
                                                        ),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              route[
                                                                  "map_image"]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        SizedBox(
                                          height: 1.0,
                                          child: Container(
                                            color: BG_COLOR,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Center(
                                          child: Text(
                                            route["route_name"],
                                            style: MAIN_TEXT_STYLE_BLACK,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          route["route_description"],
                                          style: MAIN_TEXT_STYLE_BLACK,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
