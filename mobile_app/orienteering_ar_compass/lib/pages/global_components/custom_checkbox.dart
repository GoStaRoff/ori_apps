import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orienteering_ar_compass/constants/colors.dart';
import 'package:orienteering_ar_compass/constants/text_styles.dart';

// ignore: must_be_immutable
class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  var text;
  final Function onChanged;

  CustomCheckBox({required this.isChecked, this.text, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () {
          onChanged();
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: isChecked ? GREEN : BG_COLOR,
              child: CircleAvatar(
                backgroundColor: isChecked ? GREEN : Colors.white,
                child: isChecked
                    ? SvgPicture.asset('assets/icons/check_icon.svg')
                    : null,
                radius: 13,
              ),
            ),
            text != null
                ? Row(
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        text,
                        style: MAIN_TEXT_STYLE_BLACK,
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
