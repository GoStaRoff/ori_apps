import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SalesController extends GetxController {
  var scrollController = ScrollController();

  scrollToStart() => scrollController.animateTo(0,
      duration: Duration(seconds: 1), curve: Curves.easeIn);
}
