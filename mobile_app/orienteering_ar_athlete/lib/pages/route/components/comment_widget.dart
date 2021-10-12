import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';

class CommentWidget extends StatefulWidget {
  final int rate;
  final String avatarLink;
  final DateTime date;
  final String login;
  final String comment;
  final bool owner;

  CommentWidget({
    required this.login,
    required this.date,
    required this.avatarLink,
    required this.comment,
    required this.rate,
    required this.owner,
  });

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30.0,
              backgroundImage: NetworkImage(widget.avatarLink),
            ),
            SizedBox(
              width: 14.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.login,
                    style: MAIN_TEXT_STYLE_BLACK.copyWith(fontSize: 18.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.owner
                          ? RoundedContainer(
                              borderEnabled: true,
                              borderColor: ORANGE,
                              color: BG_COLOR,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "owner",
                                  style: MAIN_TEXT_STYLE_BLACK.copyWith(
                                      color: ORANGE),
                                ),
                              ),
                            )
                          : Row(
                              children: [
                                ...List.generate(
                                  widget.rate,
                                  (i) => Icon(
                                    Icons.star,
                                    color: GREEN,
                                    size: 18,
                                  ),
                                ).toList(),
                                ...List.generate(
                                  5 - widget.rate,
                                  (i) => Icon(
                                    Icons.star,
                                    color: LIGHT_GRAY,
                                    size: 18,
                                  ),
                                ).toList(),
                              ],
                            ),
                      Text(
                        Jiffy(widget.date).format("dd.MM.yyyy, HH:mm"),
                        style: MAIN_TEXT_STYLE_BLACK.copyWith(
                          color: LIGHT_GRAY_TEXT,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          showMore || widget.comment.length < 150
              ? widget.comment
              : widget.comment.substring(0, 150),
          style: MAIN_TEXT_STYLE_BLACK,
        ),
        Visibility(
          visible: widget.comment.length > 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    showMore = !showMore;
                  });
                },
                child: Icon(
                  Icons.more_horiz,
                  size: 36.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 1.0,
          child: Container(
            color: LIGHT_GRAY,
          ),
        ),
      ],
    );
  }
}
