import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/custom_list_item.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_padding.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_compass/pages/route/views/route_page.dart';
import 'package:orienteering_ar_compass/pages/search/controllers/search_controller.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  static String id = "/search";
  SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            PagePadding(
              child: RoundedContainer(
                height: 45.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: MAIN_TEXT_STYLE_BLACK,
                          cursorColor: DARK_BROWN,
                          controller:
                              searchController.searchEditingController.value,
                          decoration: InputDecoration(
                            hintText: "Search".tr,
                            hintStyle: MAIN_TEXT_STYLE_BLACK.copyWith(
                              color: LIGHT_GRAY_TEXT,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Obx(
                        () => Visibility(
                          visible: searchController.clearButtonVisible.value,
                          child: InkWell(
                            onTap: searchController.onClearClick,
                            child: SvgPicture.asset(
                                "assets/icons/delete_icon.svg"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Obx(
                        () => InkWell(
                          onTap: searchController.searchButtonEnabled.value
                              ? searchController.onSearchClick
                              : null,
                          child: Container(
                            width: 70.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: searchController.searchButtonEnabled.value
                                  ? ORIENT_COLOR
                                  : LIGHT_GRAY,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: SvgPicture.asset(
                                  "assets/icons/search_white_icon.svg",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Obx(()=>Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: searchController.routes.length,
                  itemBuilder: (_, i) => InkWell(
                    onTap: () {
                      Get.to(
                        RoutePage(
                          searchController.routes[i]["route_id"],
                        ),
                      );
                    },
                    child: CustomListItem(
                      rightChild: SvgPicture.asset(
                        "assets/icons/arrow_icon.svg",
                        color: LIGHT_GRAY,
                        height: 15.0,
                      ),
                      leftChild: Text(
                        searchController.routes[i]["route_generated_name"],
                        style: MAIN_TEXT_STYLE_BLACK,
                      ),
                    ),
                  ),
                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }
}
