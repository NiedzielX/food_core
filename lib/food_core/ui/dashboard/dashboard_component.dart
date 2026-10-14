import 'dart:core';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/avatar_item.dart';
import 'package:food_core/food_core/model/menu.dart';
import 'package:food_core/food_core/model/response.dart';
import 'package:food_core/food_core/ui/base/base_state.dart';
import 'package:food_core/food_core/ui/dashboard/dashboard_presenter.dart';
import 'package:food_core/food_core/ui/dashboard/dashboard_view.dart';
import 'package:food_core/food_core/ui/dashboard/home/home_component.dart';
import 'package:food_core/food_core/ui/dashboard/profile/edit_profile/edit_profile_component.dart';
import 'package:food_core/food_core/ui/dashboard/profile/profile_component.dart';
import 'package:food_core/food_core/ui/dashboard/scan/scan_component.dart';
import 'package:food_core/food_core/ui/favorites_products/favorites_products_component.dart';
import 'package:food_core/food_core/ui/views/custom_appbar/custom_appbar.dart';
import 'package:food_core/food_core/ui/views/custom_bottombar/custom_bottombar.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/strings.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends BaseState<DashboardPage> implements DashboardView {

  final inactiveButtonColor = MyColors.darkGrey;
  final activeButtonColor = MyColors.darkGrey;
  final borderColorAlertNoConnection = MyColors.lightGrey;

  static const alert_padding_margin_no_connection = 15.0;
  static const alert_color_no_connection = Colors.white;
  static const border_width_no_connection = 2.0;
  static const border_radius_no_connection = 8.0;
  static const box_shadow_no_connection = 2;
  static const font_color_no_connection = Colors.black;
  static const font_size_no_connection = 12.0;
  static const top_bar_height = 80.0;

  DashboardPresenter presenter;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  CustomMenuItem _currentItem;
  int currentIndex = 0;

  String title = "";
  List<Widget> actions = [];
  AvatarItem userAvatar;

  var currentFragment;

  _DashboardPageState() {
    presenter = new BasicDashboardPresenter();
  }

  @override
  void initState() {
    super.initState();
    presenter.view = this;
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: ConnectivityWidgetWrapper(
        alignment: Alignment.topCenter,
        stacked: true,
        disableInteraction: true,
        offlineWidget: SafeArea(
          child: Container(
              padding: EdgeInsets.all(alert_padding_margin_no_connection),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: alert_color_no_connection,
                  border: Border.all(color: borderColorAlertNoConnection, width: border_width_no_connection),
                  borderRadius: BorderRadius.all(Radius.circular(border_radius_no_connection)),
                  boxShadow: kElevationToShadow[box_shadow_no_connection]
              ),
              child: Text(
                  Strings.noConnection,
                  style: TextStyle(
                    color: font_color_no_connection,
                    fontSize: font_size_no_connection,
                  )
              )
          ),
        ),
        child: getView(),
      ),
      drawerEnableOpenDragGesture: false,
      drawerEdgeDragWidth: 0.0,
      bottomNavigationBar: CustomBottomBar(selectedElement, currentIndex),
      drawerScrimColor: Colors.transparent,
      floatingActionButton: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar:  PreferredSize(
        child: reloadNav(),
        preferredSize: Size.fromHeight(top_bar_height)
      )
    );
  }

  Widget reloadNav() {
    return CustomAppBar(title, selectCallback: selectedElement, actions: actions, userAvatar: userAvatar);
  }

  void selectedElement(CustomMenuItem selected){
    selectView(selected);
  }

  Widget renderTabBar() {
    return Container();
  }

  Widget editProfile() {
    return IconButton(
      icon: ImageIcon(Assets.edit.image),
      color: MyColors.white,
      onPressed: () {
        goToEditProfile();
      }
    );
  }

  selectView(CustomMenuItem currentItem) {
    setState(() {
      this._currentItem = currentItem;
    });
  }

  getView() {
    return Container (
        child: getFragment()
    );
  }

  getFragment() {
    setNavTitle(_currentItem?.action == MenuAction.home ? "" : _currentItem?.title ?? "", actions: setNavActions(_currentItem?.action ?? MenuAction.home));
    changeBottomBarTabIfNeeded();

    switch (_currentItem?.action ?? MenuAction.home) {
      case MenuAction.home:
        return HomeFragment();
      case MenuAction.profile:
        return ProfileFragment();
      case MenuAction.scan:
        return ScanFragment();
      case MenuAction.favorite:
        return FavoritesProductsFragment();
      default:
        return HomeFragment();
    }
  }

  List<Widget> setNavActions(MenuAction action) {
    List<Widget> actions = [];
    switch (action) {
      case MenuAction.profile:
        actions.add(editProfile());
      break;
      default: break;
    }
    return actions;
  }

  void setNavTitle(String title, {List<Widget> actions = const[]}) {
    setState(() {
      this.actions = actions;
      this.title = title;
    });
  }

  void changeBottomBarTabIfNeeded() {
    var newIndex = presenter.indexOfMenuAction(_currentItem);
    if (newIndex != currentIndex) {
      setState(() {
        currentIndex = newIndex;
      });
    }
  }

  void goToEditProfile() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
  }

  @override
  void setViewData(List<CustomMenuItem> menu, {AvatarItem userAvatar}) {
    _currentItem = menu.first;
    setState(() {
      this.userAvatar = userAvatar;
    });
  }

  @override
  void onError(Response response) {
    handleError(response);
  }
}