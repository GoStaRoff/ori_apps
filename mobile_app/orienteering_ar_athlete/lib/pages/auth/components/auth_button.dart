import 'package:flutter/material.dart';
import 'package:orienteering_ar_athlete/constants/colors.dart';
import 'package:orienteering_ar_athlete/constants/text_styles.dart';

//--------------------------Кнопка авторизации--------------------------------
class AuthButton extends StatelessWidget {
  final String text; //Текст кнопки
  final Color backgroundColor; //Цвет фона
  final Widget rightChild; //Виджет справа
  final Function onTap; //Функция по нажатию

  //Конструктор
  AuthButton({
    required this.text,
    required this.backgroundColor,
    required this.onTap,
    required this.rightChild,
  });

  //Рендер
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          height: 58.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: backgroundColor == LIGHT_GRAY ||
                          backgroundColor == Colors.white
                      ? MAIN_TEXT_STYLE_BLACK
                      : MAIN_TEXT_STYLE_WHITE,
                ),
                rightChild,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
