import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orienteering_ar_compass/pages/global_components/main_button.dart';
import 'package:orienteering_ar_compass/pages/global_components/rounded_container.dart';

class PhotoDialog extends StatelessWidget {
  final Uint8List photo;

  const PhotoDialog({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: RoundedContainer(
            height: Get.height / 1.5,
            width: Get.width / 1.2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.memory(
                        photo,
                        height: Get.height / 2,
                      ),
                    ),
                  ),
                  MainButton(
                      width: 150.0,
                      text: "OK",
                      onPressed: () {
                        Get.back();
                      },
                      isActive: true)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
