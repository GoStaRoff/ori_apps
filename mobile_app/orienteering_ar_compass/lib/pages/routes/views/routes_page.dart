import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/money.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_padding.dart';
import 'package:orienteering_ar_compass/pages/global_components/percent.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/global_components/route_card.dart';
import 'package:orienteering_ar_compass/pages/route/views/route_page.dart';
import 'package:orienteering_ar_compass/pages/routes/controllers/routes_controller.dart';
import 'package:orienteering_ar_compass/pages/routes/views/priority_dialog.dart';
import 'package:orienteering_ar_compass/pages/routes/views/routes_filter_page.dart';
import 'package:orienteering_ar_compass/pages/search/views/search_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class RoutesScreen extends StatefulWidget {
  static String id = '/routes';

  @override
  _RoutesScreenState createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  RoutesController routesController = Get.put(RoutesController());

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
                  middleWidget: RoundedContainer(
                    height: 45.0,
                    width: 230.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/people_count_icon.svg",
                              color: routesController.filteredCount.value > 0
                                  ? GREEN
                                  : DARK_BROWN,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "${routesController.sumPasses}",
                              style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                color: routesController.filteredCount.value > 0
                                    ? GREEN
                                    : DARK_BROWN,
                              ),
                            ),
                          ],
                        ),
                        RoundedContainer(
                          width: 100.0,
                          color: routesController.filteredCount.value > 0
                              ? GREEN
                              : DARK_BROWN,
                          child: Center(
                            child: Money(
                              count: routesController.sumSales.value
                                  .toStringAsFixed(2),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Percent(
                          color: routesController.filteredCount.value > 0
                              ? GREEN
                              : DARK_BROWN,
                          count: routesController.averageTips.value.toString(),
                        ),
                      ],
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
