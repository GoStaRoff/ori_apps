import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/cps/views/cps_page.dart';
import 'package:orienteering_ar_athlete/pages/find/views/find_page.dart';
import 'package:orienteering_ar_athlete/pages/global_components/bottom_nav_bar.dart';
import 'package:orienteering_ar_athlete/pages/global_components/loader_indicator.dart';
import 'package:orienteering_ar_athlete/pages/locator/views/locator_page.dart';
import 'package:orienteering_ar_athlete/pages/profile/views/profile_page.dart';
import 'package:orienteering_ar_athlete/pages/routes/views/routes_page.dart';

class HomePage extends StatefulWidget {
  static String id = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainController mainController = Get.find();
  int pageIndex = 3;

  @override
  Widget build(BuildContext context) {
    var _list = [
      LocatorPage(),
      FindPage(),
      RoutesScreen(),
      ProfileScreen(),
      CPSPage()
    ];
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: Obx(
        () => mainController.initProfileLoading.value
            ? Center(child: LoaderIndicator())
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
                          iconData: "assets/icons/locator_icon.svg",
                          text: 'Locator'),
                      FABBottomAppBarItem(
                          iconData: "assets/icons/ar_icon.svg",
                          text: 'Find AR'),
                      FABBottomAppBarItem(
                          iconData: "assets/icons/route_icon.svg",
                          text: !mainController.passingRoute.value
                              ? 'Routes'
                              : "CPS"),
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
