import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';

class StyledTextField {

  static InputDecoration styled(String str, {double topElement = 15, double bottomElement = 15, Widget icon}) {

    var border = UnderlineInputBorder(borderSide: BorderSide(color: MyColors.silver, width: 1.0, style: BorderStyle.solid), borderRadius: BorderRadius.zero);

    var decoration = InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(0, topElement, 0, bottomElement),
        hintText: str,
        hintStyle: TextStyle(color: MyColors.hintText),
        prefixIcon: icon,
        filled: true,
        fillColor: Colors.white,

        focusedBorder: border,
        enabledBorder: border,
        border: border
    );
    return decoration;
  }
}