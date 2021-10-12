import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/main_controller.dart';

import 'bottom_rounded_container.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconData, required this.text});
  String iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    required this.items,
    this.height: 60.0,
    this.iconSize: 24.0,
    required this.color,
    required this.selectedColor,
    required this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final double height;
  final double iconSize;
  final Color color;
  final Color selectedColor;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 3;
  MainController mainController = Get.find();

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      if (mainController.pageIndex.value == 4) {
        _selectedIndex = 2;
      } else
        _selectedIndex = mainController.pageIndex.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return BottomRoundedContainer(
      height: 80.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items,
      ),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => onPressed(index),
        child: SizedBox(
          height: widget.height,
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  item.iconData,
                  color: mainController.pageIndex.value == index ||
                          (index == 2 &&
                              mainController.pageIndex.value == 4 &&
                              mainController.passingRoute.value)
                      ? widget.selectedColor
                      : widget.color,
                  height: 30.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Obx(
                  () => Text(
                    item.text,
                    style: MAIN_TEXT_STYLE_WHITE.copyWith(
                      fontSize: 10.0,
                      color: mainController.pageIndex.value == index ||
                              (index == 2 &&
                                  mainController.pageIndex.value == 4 &&
                                  mainController.passingRoute.value)
                          ? widget.selectedColor
                          : widget.color,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
