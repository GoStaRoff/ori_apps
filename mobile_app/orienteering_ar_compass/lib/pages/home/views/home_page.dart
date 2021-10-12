import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/bottom_nav_bar.dart';
import 'package:orienteering_ar_compass/pages/global_components/loader_indicator.dart';
import 'package:orienteering_ar_compass/pages/map/views/map_screen.dart';
import 'package:orienteering_ar_compass/pages/polygon/views/polygon_screen.dart';
import 'package:orienteering_ar_compass/pages/profile/views/profile_page.dart';
import 'package:orienteering_ar_compass/pages/routes/views/routes_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  static String id = '/home';
  MainController mainController = Get.find();

  var _list = [
    MapScreen(),
    PolygonScreen(),
    RoutesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: Obx(
        () => mainController.initProfileLoading.value
            ? Center(
                child: LoaderIndicator(),
              )
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  IndexedStack(
                    index: mainController.pageIndex.value,
                    children: _list,
                  ),
                  // _list[_page],
                  FABBottomAppBar(
                    color: Colors.grey,
                    selectedColor: DARK_BROWN,
                    onTabSelected: mainController.onChangePage,
                    items: [
                      FABBottomAppBarItem(
                          iconData: "assets/icons/pin_icon.svg",
                          text: 'Set point'),
                      FABBottomAppBarItem(
                          iconData: "assets/icons/map_nav_icon.svg",
                          text: 'Set route'),
                      FABBottomAppBarItem(
                          iconData: "assets/icons/route_icon.svg",
                          text: 'Routes'),
                      FABBottomAppBarItem(
                          iconData: "assets/icons/user_icon.svg",
                          text: 'Coach'),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
