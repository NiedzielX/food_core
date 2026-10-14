import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';

enum LanguageKeys {
  pl
}

enum CompanySizeKeys {
  none, range1, range2, range3, range4
}

class Constants {

  static int monthAfterShowScreenRegister = 3;

  static Color menuBgColor = MyColors.darkGrey;
  static Color subMenuBgColor = MyColors.darkGrey;
  static Color menuTextColor = MyColors.lightGrey;
  static Color menuCellColor = Colors.white;
  static Color buttonColor = MyColors.skyBlue;
  static Color cursorColor =Color(0xFF000000);
  static Color fieldFormBackgroundColor =Color(0xFFF1F2F6);
  static Color productIngredientWarningColor = MyColors.redSecondary;

  static double menuTextSize = 16.0;
  static Color lineBorderColor = MyColors.darkGrey;

  static Size newsImageSize = Size(115, 105);

  static double appBarSize = 80;


}