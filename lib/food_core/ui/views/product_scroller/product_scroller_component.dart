import 'package:flutter/material.dart';
import 'package:food_core/food_core/model/product_item.dart';
import 'package:food_core/food_core/ui/views/product_scroller/product_scroller.dart';

class ProductScrollerComponent extends StatefulWidget {

  final String _title;
  final List<ProductItem> items;
  final Function onPressed;

  ProductScrollerComponent(this._title, this.items, {this.onPressed});

  @override
  _ProductScrollerComponentState createState() => _ProductScrollerComponentState();
}

class _ProductScrollerComponentState extends State<ProductScrollerComponent> {

  static const button_icons_size = 72.0;
  static const button_horizontal_spacing = EdgeInsets.symmetric(horizontal: 15);

  String title;

  List<ProductItem> items;

  Function onPressed;

  @override
  initState() {
    this.title = widget._title;
    this.items = widget.items;
    this.onPressed = widget.onPressed;
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProductScroller(
        description: title,
        parentEndColor: Colors.transparent,
        parentStartColor: Colors.transparent,
        heightView: button_icons_size,
        buttonSpacing: button_horizontal_spacing,
        buttonSize: button_icons_size,
        direction: Direction.LTR,
        onPressed: onPressed,
        childrenData: this.items);
  }

}