import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomListView extends StatelessWidget {
  List<Widget> children;
  var controller;

  CustomListView({required this.children, this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      physics: BouncingScrollPhysics(),
      children: children,
    );
  }
}
