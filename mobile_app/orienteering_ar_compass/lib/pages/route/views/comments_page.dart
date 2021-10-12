import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';
import 'package:orienteering_ar_compass/main_controller.dart';
import 'package:orienteering_ar_compass/pages/global_components/header.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_wrapper.dart';
import 'package:orienteering_ar_compass/pages/route/components/comment_widget.dart';
import 'package:orienteering_ar_compass/pages/route/views/comment_page.dart';
import 'package:orienteering_ar_compass/pages/route/views/remove_comment_dialog.dart';
import 'package:orienteering_ar_compass/service/ori_api.dart';

// ignore: must_be_immutable
class CommentsPage extends StatefulWidget {
  static String id = "/comments";
  var comments;
  String routeId;

  CommentsPage({required this.comments, required this.routeId});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  MainController mainController = Get.find();
  ScrollController scrollController = ScrollController();

  scrollToStart() => scrollController.animateTo(0,
      duration: Duration(seconds: 1), curve: Curves.easeIn);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      withListView: false,
      controller: scrollController,
      fab: FloatingActionButton(
        backgroundColor: ORIENT_COLOR,
        onPressed: scrollToStart,
        child: Container(
          height: 20.0,
          width: 20.0,
          child: SvgPicture.asset("assets/icons/arrow_up_icon.svg"),
        ),
      ),
      header: Header(
        middleWidget: Text(
          "Comments",
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        rightWidget: InkWell(
          onTap: () async {
            await Get.to(CommentPage(
              routeId: widget.routeId,
            ));

            setState(() {});
          },
          child: SvgPicture.asset("assets/icons/add_icon.svg"),
        ),
      ),
      children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 0,
              );
            },
            itemCount: widget.comments.length,
            itemBuilder: (_, i) => Slidable(
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                InkWell(
                  onTap: () async {
                    await Get.dialog(RemoveCommentDialog(
                      remove: () async {
                        var result = await OriApi.deleteComment(
                            int.parse(widget.comments[i]["comment_id"]));
                        if (result.data[0]['error'].toString() != "true") {
                          mainController.updateRoute();
                          mainController.updateRoutes();
                          Get.back();
                        } else {
                          Get.snackbar(
                              "Error".tr,
                              result.data[0][
                                  'description']); // Вывод на ошибку корректности данных
                        }
                        Get.back();
                      },
                    ));
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.redAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              child: CommentWidget(
                rate: int.parse(widget.comments[i]["rate"]),
                avatarLink: widget.comments[i]["user_avatar"],
                date: Jiffy(widget.comments[i]["create_date"]).dateTime,
                login: widget.comments[i]["login"],
                comment: widget.comments[i]["text"],
                owner: widget.comments[i]["owner"] == "true",
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
