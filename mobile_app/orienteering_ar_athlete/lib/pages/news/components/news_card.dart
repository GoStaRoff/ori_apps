import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';
import 'package:orienteering_ar_athlete/pages/news/views/message_page.dart';
import 'package:orienteering_ar_athlete/service/ori_api.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsCard extends StatefulWidget {
  final int notifId;
  final String imageUrl;
  final String title;
  final String description;
  final bool readed;
  final DateTime created;
  var getMessages;

  NewsCard({
    required this.notifId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.created,
    required this.readed,
    required this.getMessages,
  });

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  MainController mainController = Get.find();
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var result = await OriApi.notifReaded(
            box.read("id"), widget.notifId); // Запрос на прочитаную новость
        if (result.data[0]['error'].toString() != "true") {
          // Проверка ответа на обработаную ошибку
          mainController.unreadMessages.value =
              mainController.unreadMessages.value -
                  1; // Установка нового количества сообщений
          widget.getMessages(); // Загрузка новостей
        }

        Get.to(() => MessagePage(
              imageUrl: widget.imageUrl,
              title: widget.title,
              description: widget.description,
              created: widget.created,
            ));
      },
      child: RoundedContainer(
        height: 80.0,
        child: Row(
          children: [
            Container(
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: MAIN_TEXT_STYLE_BLACK,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/clock_icon.svg",
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              timeago.format(widget.created),
                              style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                color: LIGHT_GRAY_TEXT,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        widget.readed
                            ? Container()
                            : CircleAvatar(
                                radius: 5.0,
                                backgroundColor: ORIENT_COLOR,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
