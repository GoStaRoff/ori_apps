import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/pages/global_components/header.dart';
import 'package:orienteering_ar_athlete/pages/global_components/page_wrapper.dart';

class HelpPage extends StatelessWidget {
  static String id = "/help";

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      header: Header(
        middleWidget: Text(
          "Help".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
      ),
      children: [],
    );
  }
}
