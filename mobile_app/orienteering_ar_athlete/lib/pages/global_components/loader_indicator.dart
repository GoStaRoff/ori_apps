import 'package:flutter/material.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';

class LoaderIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: DARK_BROWN,
      strokeWidth: 2.0,
    );
  }
}
