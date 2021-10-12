import 'package:flutter/material.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';

// ignore: must_be_immutable
class CustomItemList extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  bool disabledLine;
  CustomItemList(
      {required this.child,
      required this.onPressed,
      this.disabledLine = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Container(
          child: Column(
            children: [
              Container(height: 55.0, child: child),
              disabledLine
                  ? SizedBox(
                      height: 5,
                    )
                  : Container(
                      height: 1,
                      color: BG_COLOR,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
