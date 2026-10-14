import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/global.dart';

class SimpleAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  static const double APP_BAR_SIZE = 80;

  final AppbarParameters appBarParameters;

  @override
  final Size preferredSize;

  SimpleAppBarWidget(this.appBarParameters)
      : preferredSize = Size.fromHeight(APP_BAR_SIZE),
        super();

  @override
  Widget build(BuildContext context) {
    return _buildAppBarWidget(context);
  }

  Widget _buildAppBarWidget(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _buildTitle(),
      leading: appBarParameters.onBack ? _buildLeadingButton(context) : null,
      shape: _buildAppBarShape(),
      brightness: Brightness.dark,
      backgroundColor: MyColors.skyBlue,
      elevation: 0,
    );
  }

  RoundedRectangleBorder _buildAppBarShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    );
  }

  IconButton _buildLeadingButton(BuildContext context) {
    return IconButton(
        icon: Assets.whiteBackArrow, onPressed: () => _onBackPressed(context));
  }

  Widget _buildTitle() {
    return AutoSizeText(appBarParameters.title, style: GlobalUtils.pageTitleText(20));
  }

  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class AppbarParameters {
  final String title;
  final bool onBack;

  AppbarParameters({this.title, this.onBack = true});
}
