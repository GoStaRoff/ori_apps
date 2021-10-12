import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/pages/global_components/custom_input.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/main_button.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_athlete/pages/wishes/controller/wishes_controller.dart';

class WishesPage extends StatelessWidget {
  static String id = '/wishes';

  @override
  Widget build(BuildContext context) {
    WishesController wishesController = Get.put(WishesController());

    return PageWrapper(
      header: Header(
        middleWidget: Text(
          "Wishlist".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
      ),
      children: [
        SizedBox(
          height: 20.0,
        ),
        CustomInput(
          controller: wishesController.wishEditingController.value,
          hintText: "What would you change in this app?".tr,
          height: 220,
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "UPLOAD PHOTOS".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 10.0,
        ),
        Obx(
          () => Wrap(
            spacing: 42.0,
            runSpacing: 20.0,
            children: [
              wishesController.showAddButton()
                  ? InkWell(
                      onTap: wishesController.getImage,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                              "assets/icons/dashed_border_icon.svg"),
                          Positioned(
                            left: 30.0,
                            top: 30.0,
                            child: SvgPicture.asset(
                                "assets/icons/photo_add_icon.svg"),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              ...wishesController.images.values.toList(),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Obx(
          () => Align(
            alignment: Alignment.center,
            child: MainButton(
              width: 150.0,
              text: "Send".tr,
              isActive: wishesController.enabledSendButton.value,
              onPressed: wishesController.sendWish,
            ),
          ),
        ),
      ],
    );
  }
}
