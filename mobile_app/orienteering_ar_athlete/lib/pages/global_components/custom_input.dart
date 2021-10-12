import 'package:flutter/material.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';
import 'package:orienteering_ar_athlete/pages/global_components/rounded_container.dart';

// ignore: must_be_immutable
class CustomInput extends StatelessWidget {
  var hintText;
  double height;
  bool borderEnabled;
  bool isPassword;
  var controller;
  var color;
  var keyboardType;
  var inputFormatters;
  var onChanged;
  var initialValue;
  var style;

  CustomInput(
      {this.hintText,
      this.color,
      this.height = 45,
      this.borderEnabled = false,
      this.isPassword = false,
      this.controller,
      this.inputFormatters,
      this.keyboardType,
      this.onChanged,
      this.initialValue,
      this.style = MAIN_TEXT_STYLE_BLACK});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: color == null ? Colors.white : color,
      borderEnabled: borderEnabled,
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: isPassword,
          maxLines: isPassword ? 1 : 10,
          style: style,
          cursorColor: DARK_BROWN,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: MAIN_TEXT_STYLE_BLACK.copyWith(
              color: LIGHT_GRAY_TEXT,
            ),
            border: InputBorder.none,
          ),
          controller: controller,
          onChanged: onChanged,
          initialValue: initialValue,
        ),
      ),
    );
  }
}
