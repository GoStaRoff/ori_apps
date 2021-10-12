import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_padding.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_athlete/pages/global_components/route_card.dart';
import 'package:orienteering_ar_athlete/pages/route/views/route_page.dart';
import 'package:orienteering_ar_athlete/pages/routes/controllers/routes_controller.dart';
import 'package:orienteering_ar_athlete/pages/routes/views/priority_dialog.dart';
import 'package:orienteering_ar_athlete/pages/routes/views/routes_filter_page.dart';
import 'package:orienteering_ar_athlete/pages/search/views/search_page.dart';
import 'package:orienteering_ar_athlete/pages/tariff/views/tariff_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class RoutesScreen extends StatelessWidget {
  RoutesController routesController = Get.put(RoutesController());
  MainController mainController = Get.find();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  showContainer() {
    Color color;
    switch (mainController.profileTariff.value) {
      case "FREE":
        color = LIGHT_GRAY;
        break;
      case "S":
        color = ORIENT_COLOR;
        break;
      case "M":
        color = ORANGE;
        break;
      case "L":
      default:
        color = LIGHT_RED;
        break;
    }
    return Container(
      width: 80.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      child: Center(
        child: Text(
          mainController.profileTariff.value,
          style: MAIN_TEXT_STYLE_WHITE,
        ),
      ),
    );
  }

  onRefresh() {
    routesController.loadRoutes();
    refreshController.refreshCompleted();
  }

  onLoading() {
    routesController.loadRoutes();
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: BG_COLOR,
        body: PagePadding(
          child: Column(
            children: [
              Obx(
                () => Header(
                  leftWidget: InkWell(
                    onTap: () {
                      Get.toNamed(RoutesFilterPage.id);
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 7.0,
                            bottom: 7.0,
                            right: 7.0,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/filter_icon.svg',
                            color: routesController.filteredCount.value > 0
                                ? GREEN
                                : null,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Visibility(
                            visible: routesController.filteredCount.value > 0,
                            child: CircleAvatar(
                              radius: 8.0,
                              backgroundColor: GREEN,
                              child: Text(
                                "${routesController.filteredCount.value}",
                                style: MAIN_TEXT_STYLE_WHITE.copyWith(
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  middleWidget: InkWell(
                    onTap: () {
                      Get.toNamed(TariffPage.id);
                    },
                    child: RoundedContainer(
                      height: 45.0,
                      width: 230.0,
                      child: Row(
                        children: [
                          Obx(
                            () => showContainer(),
                          ),
                          Expanded(
                            child: Center(
                              child: Text("Change plan\nto EARN MORE".tr),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  rightWidget: InkWell(
                    onTap: () {
                      Get.toNamed(SearchPage.id);
                    },
                    child: SvgPicture.asset('assets/icons/search_icon.svg'),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.dialog(PriorityDialog());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/sort_icon.svg"),
                        SizedBox(
                          width: 5.0,
                        ),
                        Obx(
                          () => Text(
                            routesController.priorityItems[
                                routesController.checkedPriority.value],
                            style: MAIN_TEXT_STYLE_BLACK,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Obx(
                () => Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullDown: true,
                    onRefresh: onRefresh,
                    onLoading: onLoading,
                    header: MaterialClassicHeader(
                      color: Colors.white,
                      backgroundColor: DARK_BROWN,
                    ),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: routesController.filteredRoutes.length,
                      itemBuilder: (_, i) => InkWell(
                        onTap: () {
                          Get.to(() => RoutePage(
                              routesController.filteredRoutes[i]["route_id"]));
                        },
                        child: RouteCard(
                          item: routesController.filteredRoutes[i],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 83,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
