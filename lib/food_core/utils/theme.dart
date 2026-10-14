import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';

import '../extensions/hex_color.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: MyColors.white,
    primaryColor: MyColors.lightGrey,
    buttonColor: MyColors.skyBlue,
    accentColor: MyColors.skyBlue,
    hintColor: MyColors.skyBlue,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) =>
                states.contains(MaterialState.disabled)
                    ? Colors.white
                    : Colors.white,
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
          backgroundColor: MaterialStateProperty.all<Color>(MyColors.skyBlue)),
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(MyColors.skyBlue))),
    unselectedWidgetColor: MyColors.lightGrey,
    fontFamily: 'Poppins');

ThemeData darkTheme =
    lightTheme.copyWith(unselectedWidgetColor: MyColors.lightGrey);
