import 'package:flutter/material.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';

class CustomListItem extends StatelessWidget {
  final Widget leftChild;
  final Widget rightChild;

  CustomListItem({required this.rightChild, required this.leftChild});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leftChild,
              rightChild,
            ],
          ),
        ),
        Container(
          height: 1.0,
          color: BG_COLOR,
        ),
      ],
    );
  }
}
