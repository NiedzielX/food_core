import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/product_item.dart';
import 'package:food_core/food_core/ui/views/product_scroller/product_list_item.dart';
import 'package:food_core/food_core/utils/strings.dart';

enum Direction { LTR, RTL}

class ProductScroller extends StatefulWidget {

  final Color _parentEndColor;
  final List<ProductItem> _childrenData;
  final Direction _direction;
  final double _heightView;
  final String _description;
  final Function onPressed;

  ProductScroller(
      {Color parentStartColor = Colors.transparent,
        Color parentEndColor = Colors.transparent,
        @required double heightView,
        @required EdgeInsets buttonSpacing,
        @required double buttonSize,
        @required List<ProductItem> childrenData,
        @required String description,
        Direction direction = Direction.RTL,
        Function onPressed})
      : _parentEndColor = parentEndColor,
        _heightView = heightView,
        _childrenData = childrenData,
        _direction = direction,
        _description = description,
        onPressed = onPressed;

  @override
  State<StatefulWidget> createState() {
    return _ProductScrollerState();
  }
}

class _ProductScrollerState extends State<ProductScroller> {

  double viewHeight;
  double buttonSize;
  EdgeInsets buttonSpacing;
  String description;
  Function onPressed;

  static const title_font_size = 16.0;
  static const button_font_size = 14.0;
  static const title_horizontal_padding = EdgeInsets.only(left: 20);
  static const product_container_horizontal_padding = EdgeInsets.only(left: 15);

  @override
  initState() {
    viewHeight = widget._heightView;
    description = widget._description;
    onPressed = widget.onPressed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: title_horizontal_padding,
                child: Text(description, style: TextStyle(color: MyColors.color01, fontSize: title_font_size))
              ),
            ),
            allItemButton()
          ],
        ),
      Stack(
      alignment: widget._direction == Direction.LTR ? Alignment.bottomLeft : Alignment.bottomRight,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: product_container_horizontal_padding,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(viewHeight / 2)),
              color: widget._parentEndColor
          ),
          // height: viewHeight,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _generateMenuItems(),
              )),
        ),
      ],
    )
    ]);
  }

  Widget allItemButton() {
    if (onPressed == null) {
      return Container();
    }

    return TextButton(
      onPressed: (){
        onPressed();
      },
      child: Text(Strings.all, style: TextStyle(color: MyColors.skyBlue, fontSize: button_font_size))
    );
  }

  List<Widget> _generateMenuItems() {
    List<Widget> items = [];
    if (widget._childrenData != null && widget._childrenData.isNotEmpty) {
      for (int i = widget._childrenData.length; i > 0; i--) {
        items.add(_generateItem(widget._childrenData[i - 1], i));
      }
    }
    return items.reversed.toList();
  }

  Widget _generateItem(ProductItem item, int index) {
    return ProductListItem(item);
  }
}
