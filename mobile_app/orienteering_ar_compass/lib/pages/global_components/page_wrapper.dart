import 'package:flutter/material.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/pages/global_components/page_padding.dart';

import 'custom_list_view.dart';

// ignore: must_be_immutable
class PageWrapper extends StatelessWidget {
  final List<Widget> children;
  var header;
  var fab;
  var controller;
  bool withListView;
  PageWrapper(
      {required this.children,
      this.fab,
      this.controller,
      this.header,
      this.withListView = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      floatingActionButton: fab,
      body: SafeArea(
        child: PagePadding(
          child: Column(
            children: [
              header == null ? Container() : header,
              Expanded(
                child: withListView
                    ? CustomListView(
                        controller: controller,
                        children: children,
                      )
                    : Column(
                        children: children,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
