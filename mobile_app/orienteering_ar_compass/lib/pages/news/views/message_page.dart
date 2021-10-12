import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_wrapper.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessagePage extends StatelessWidget {
  static String id = "/message";
  final String imageUrl;
  final String title;
  final String description;
  final DateTime created;

  MessagePage({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.created,
  });

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      header: Header(
        middleWidget: Text(
          "News".tr,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        rightWidget: InkWell(
          child: SvgPicture.asset(
            "assets/icons/share_icon.svg",
          ),
        ),
      ),
      children: [
        SizedBox(
          height: 24.0,
        ),
        Text(
          title,
          style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 20.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/clock_icon.svg",
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              timeago.format(created),
              style: MAIN_TEXT_STYLE_BLACK.copyWith(
                color: LIGHT_GRAY_TEXT,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          height: 240.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          description,
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
