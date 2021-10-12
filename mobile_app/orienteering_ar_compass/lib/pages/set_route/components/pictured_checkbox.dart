import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';

// ignore: must_be_immutable
class PicturedCheckBox extends StatelessWidget {
  var onTap;
  bool checked;
  var picturePath;

  PicturedCheckBox({this.onTap, this.picturePath, this.checked = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: checked ? DARK_BROWN : LIGHT_GRAY_TEXT,
        radius: 26.0,
        child: CircleAvatar(
          backgroundColor: BG_COLOR,
          radius: 25.0,
          child: Center(
            child: SvgPicture.asset(
              picturePath,
              color: checked ? DARK_BROWN : LIGHT_GRAY_TEXT,
            ),
          ),
        ),
      ),
    );
  }
}
