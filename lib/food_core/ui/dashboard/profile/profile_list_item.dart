import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/menu.dart';
import 'package:food_core/food_core/utils/assets.dart';

typedef SelectVoidFunction = void Function(CustomMenuItem selected);

class ProfileListItem extends StatelessWidget {

  static const name_font_size = 14.0;
  static const image_icon_height = 40.0;
  static const image_corner_radius = 12.0;
  static const row_spacing = EdgeInsets.only(top: 10);
  static const title_horizontal_spacing = EdgeInsets.only(left: 15);

  final CustomMenuItem item;
  final SelectVoidFunction selectCallback;

  ProfileListItem(this.item, this.selectCallback);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:
        Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child:
          Column (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: row_spacing),
              Row(
                children: <Widget>[
                  Container(width: image_icon_height, height: image_icon_height, alignment: Alignment.center, decoration: BoxDecoration(color: MyColors.silver, borderRadius: BorderRadius.circular(image_corner_radius)), child: item.icon),
                  Padding(padding: title_horizontal_spacing),
                  Expanded(child: Text(item.title, style: TextStyle(fontSize: name_font_size, color: MyColors.color01), textAlign: TextAlign.left)),
                  Assets.arrow
                ],
              ),
              Padding(padding: row_spacing),
              Divider(color: MyColors.color01, height: 1),
            ],
          )
        ),
        onTap: () {
          selectCallback(item);
      });
  }
}