import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';

enum Direction { LTR, RTL }

class CategoryScroller extends StatefulWidget {
  final Color _parentEndColor;
  final List<CategoryMenuItem> _childrenData;
  final Direction _direction;
  final double _heightView;

  CategoryScroller(
      {Color parentStartColor = Colors.transparent,
      Color parentEndColor = Colors.transparent,
      @required double heightView,
      @required EdgeInsets buttonSpacing,
      @required double buttonSize,
      @required List<CategoryMenuItem> childrenData,
      @required String description,
      Direction direction = Direction.RTL})
      : _parentEndColor = parentEndColor,
        _heightView = heightView,
        _childrenData = childrenData,
        _direction = direction;

  @override
  State<StatefulWidget> createState() {
    return _CategoryScrollerState();
  }
}

class CategoryMenuItem {
  final int selectedItem;
  final Function(int) onPressed;
  final Image icon;
  final int id;
  final String title;

  CategoryMenuItem(
      {this.selectedItem, this.onPressed, this.title, this.icon, this.id})
      : assert(icon != null);
}

class _CategoryScrollerState extends State<CategoryScroller> {
  double viewHeight;
  double buttonSize;
  EdgeInsets buttonSpacing;

  @override
  initState() {
    viewHeight = widget._heightView;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget._direction == Direction.LTR
          ? Alignment.bottomLeft
          : Alignment.bottomRight,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(viewHeight / 2)),
              color: widget._parentEndColor),
          // height: viewHeight,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _generateMenuItems(),
              )),
        ),
      ],
    );
  }

  List<Widget> _generateMenuItems() {
    List<Widget> items = [];
    if (widget._childrenData != null && widget._childrenData.isNotEmpty) {
      for (int i = widget._childrenData.length; i > 0; i--) {
        items.add(_toMenuItemView(widget._childrenData[i - 1], i));
      }
    }
    return items.reversed.toList();
  }

  Widget _toMenuItemView(CategoryMenuItem item, int index) {
    bool isSelected = item.selectedItem == item.id;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        item.onPressed(item.id);
      },
      child: Container(
          padding: EdgeInsets.only(right: 20),
          child: Column(
            children: [
              Container(
                  width: viewHeight,
                  height: viewHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? MyColors.skyBlue
                        : MyColors.textFieldSearch,
                    border: Border.all(
                      color: isSelected
                          ? MyColors.skyBlue
                          : MyColors.textFieldSearch,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: item.icon),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(item.title,
                  style: TextStyle(color: MyColors.mediumGrey, fontSize: 12.0))
            ],
          )),
    );
  }
}
