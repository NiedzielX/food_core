import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';

class CustomDivider extends StatelessWidget {
  final double height;

  CustomDivider({this.height = 20});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: MyColors.accentGrey,
      height: height,
      thickness: 1,
    );
  }
}
