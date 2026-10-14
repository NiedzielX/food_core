import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/menu.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/strings.dart';

typedef SelectVoidFunction = void Function(CustomMenuItem selected);

class CustomBottomBar extends StatefulWidget {

  final SelectVoidFunction selectCallback;

  final _CustomBottomBarState bottomBarStare = _CustomBottomBarState();

  final int currentIndex;

  CustomBottomBar(this.selectCallback, this.currentIndex);

  @override
  _CustomBottomBarState createState() =>  bottomBarStare;
}

class _CustomBottomBarState extends State<CustomBottomBar> {

  static const bar_radius = 20.0;
  static const tab_font_size = 10.0;
  static const bar_shadow_spread = 5.0;
  static const bar_shadow_blur = 30.0;
  static const bar_radius_container = 30.0;

  SelectVoidFunction selectCallback;

  int _currentIndex = 0;

  @override
  void initState() {
    this.selectCallback = widget.selectCallback;
    this._currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      this._currentIndex = widget.currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(bar_radius_container),
          topLeft: Radius.circular(bar_radius_container)
        ),
        boxShadow: [
          BoxShadow(color: MyColors.silver, spreadRadius: bar_shadow_spread, blurRadius: bar_shadow_blur),
        ]),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(bar_radius),
          topRight: Radius.circular(bar_radius),
        ),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedFontSize: tab_font_size,
          unselectedFontSize: tab_font_size,
          selectedItemColor: MyColors.skyBlue,
          unselectedItemColor: MyColors.silverDark,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(label: Strings.home, icon: Assets.home, activeIcon: Assets.homeActive),
            BottomNavigationBarItem(label: Strings.scan, icon: Assets.scan, activeIcon: Assets.scanActive),
            BottomNavigationBarItem(label: Strings.favorite, icon: Assets.favorite, activeIcon: Assets.favoriteActive),
            BottomNavigationBarItem(label: Strings.profile, icon: Assets.profile, activeIcon: Assets.profileActive)
          ].toList(),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            selectCallback(Menu.getItems()[index]);
          },
          currentIndex: _currentIndex,
        )
      )
    );
  }
}