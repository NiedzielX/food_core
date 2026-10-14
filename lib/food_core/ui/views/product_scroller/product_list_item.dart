import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/product_item.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/global.dart';

class ProductListItem extends StatelessWidget {
  static const name_font_size = 14.0;

  final ProductItem item;

  ProductListItem(this.item);

  @override
  Widget build(BuildContext context) {
    var sizeContainer = (MediaQuery.of(context).size.width / 2) - 20;
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Stack(children: <Widget>[
          Container(
              width: sizeContainer,
              height: sizeContainer,
              margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: item.item.moreSugar
                      ? MyColors.warningColor
                      : MyColors.textFieldSearch,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        child: GlobalUtils.getPhoto(item.item.image)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                    child: Text(item.item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: MyColors.color01,
                            height: 1,
                            fontSize: name_font_size,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              )),
          sugarView()
        ]),
        onTap: () {
          item.onPressed();
        });
  }

  Widget sugarView() {
    if (!item.item.moreSugar) {
      return Container();
    }

    return Positioned(
        top: 0,
        right: 10,
        child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: MyColors.warningColor),
                borderRadius: BorderRadius.circular(20),
                color: MyColors.warningColor),
            child: Assets.warning));
  }
}
