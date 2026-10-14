import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/utils/assets.dart';

class SearchTextField {

  static InputDecoration styled(String str, {double topElement = 15, double bottomElement = 15, Widget icon, Color iconColor, onPressed: Function}) {
    var border = OutlineInputBorder(borderSide: BorderSide(color: MyColors.textFieldSearch, width: 1.0, style: BorderStyle.solid), borderRadius: BorderRadius.circular(10.0));

    var iconSearch =  Container(width: 20, height: 20, alignment: Alignment.center, child: icon != null ? icon : Image(image: Assets.search.image, width: 20, height: 20, color: iconColor != null ? iconColor : MyColors.searchIcon));

    var decoration = InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(15, topElement, 0, bottomElement),
      hintText: str,
      hintStyle: TextStyle(color: MyColors.color01, fontSize: 12.0),
      suffixIcon: GestureDetector(child: iconSearch, onTap: () {
        if(onPressed == null) return;
        onPressed();
      }),
      filled: true,
      fillColor: MyColors.textFieldSearch,
      focusedBorder: border,
      enabledBorder: border,
      border: border,

    );
    return decoration;
  }
}