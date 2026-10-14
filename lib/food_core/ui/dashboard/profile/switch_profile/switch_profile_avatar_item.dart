import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/user.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/global.dart';

typedef SelectVoidFunction = void Function(User selected);

class SwitchProfileAvatarItem extends StatelessWidget {

  static const name_font_size = 14.0;
  static const avatar_border_width = 2.0;
  static const avatar_width = 120.0;
  static const avatar_radius = 80.0;

  final User item;
  final SelectVoidFunction selectCallback;

  final bool isEditingView;
  final bool selected;

  SwitchProfileAvatarItem(this.item, this.selectCallback, this.isEditingView, this.selected);

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        splashColor: Colors.transparent,
        child:
        Container(
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                width: avatar_width,
                height: avatar_width,
                child: CircleAvatar(
                  radius: avatar_radius,
                  backgroundColor: MyColors.silver,
                  backgroundImage: GlobalUtils.getAvatar(item.avatar).image,
                  child:  isEditingView ? CircleAvatar(radius: avatar_radius, backgroundColor: MyColors.darkGrey.withOpacity(0.8), child: Assets.edit) :
                  (selected ? CircleAvatar(radius: avatar_radius, backgroundColor: MyColors.white.withOpacity(0.6)) : null)
                ),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: new Border.all(
                    color: MyColors.silver,
                    width: avatar_border_width,
                  ),
                ),
              ),
              Center(child:
                Text(item.name, style: TextStyle(fontSize: name_font_size, color: selected ? MyColors.color01.withOpacity(0.5) : MyColors.color01, fontWeight: FontWeight.w600))
              ),
            ])
        ),
        onTap: () {
          this.selectCallback(item);
      });
  }
}


