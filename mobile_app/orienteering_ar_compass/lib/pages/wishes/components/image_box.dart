import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';

class ImageBox extends StatelessWidget {
  final String path;
  final Function delete;
  ImageBox({required this.path, required this.delete});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      child: Stack(
        children: [
          Container(
            height: 85.0,
            width: 85.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
              onTap: () {
                delete();
              },
              child: CircleAvatar(
                radius: 13,
                backgroundColor: LIGHT_GRAY,
                child: Center(
                  child: SvgPicture.asset("assets/icons/cross_delete_icon.svg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
