import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/counter.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/loader_indicator.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_padding.dart';
import 'package:orienteering_ar_compass/pages/news/components/news_card.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class MessagesPage extends StatefulWidget {
  static String id = "/messages";

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  MainController mainController = Get.find();
  GetStorage box = GetStorage();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var messagesList = []; // Список загруженых сообщений
  bool messagesLoading = false; // Индикатор загрузки данных

  // Функция для загрузки новостей
  getMessages() async {
    setState(() {
      messagesLoading = true;
    });
    var result = await OriApi.pushNotifications(
        box.read("id")); // Запрос на получение всех сообщений для пользователя
    if (result.data[0]['error'].toString() != "true") {
      setState(() {
        // Проверка ответа на обработаную ошибку
        messagesList = result.data[0]
            ["notifications"]; // Присвоение удачного ответа к списку
        messagesLoading = false;
      });
    } else {
      Get.snackbar("Error".tr,
          result.data[0]['description']); // Вывод на ошибку корректности данных
    }
  }

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  onRefresh() {
    getMessages();
    refreshController.refreshCompleted();
  }

  onLoading() {
    getMessages();
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: SafeArea(
        child: PagePadding(
          child: Column(
            children: [
              Obx(
                () => Header(
                  middleWidget: Row(
                    children: [
                      Text(
                        "News".tr,
                        style: MAIN_TEXT_STYLE_BLACK,
                      ),
                      // ignore: unrelated_type_equality_checks
                      mainController.unreadMessages.value > 0
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 5.0,
                                ),
                                Counter(mainController.unreadMessages.value),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              messagesLoading
                  ? LoaderIndicator()
                  : Expanded(
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
                          itemCount: messagesList.length,
                          itemBuilder: (_, i) => NewsCard(
                            notifId: int.parse(messagesList[i]["notif_id"]),
                            imageUrl: messagesList[i]["photo"],
                            readed: messagesList[i]["readed"],
                            title: messagesList[i]["title"],
                            description: messagesList[i]["description"],
                            created:
                                DateTime.parse(messagesList[i]["create_date"]),
                            getMessages: getMessages,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
