import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/avatar_item.dart';
import 'package:food_core/food_core/model/menu.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

typedef SelectVoidFunction = void Function(CustomMenuItem selected);

class CustomAppBar extends StatefulWidget {
  final SelectVoidFunction selectCallback;
  final List<Widget> actions;
  final String title;
  final AvatarItem userAvatar;

  final _CustomAppBarState appBarStare = _CustomAppBarState();

  CustomAppBar(this.title,
      {this.actions = const [], this.selectCallback, this.userAvatar});

  @override
  _CustomAppBarState createState() => appBarStare;

  void refresh() {
    appBarStare.refresh();
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  static const bar_radius = BorderRadius.vertical(bottom: Radius.circular(20));
  static const bar_height = 100.0;
  static const padding_container = EdgeInsets.fromLTRB(20, 40, 0, 0);
  static const avatar_size = 50.0;
  static const avatar_border_size = 2.0;
  static const padding_column = EdgeInsets.fromLTRB(10, 0, 0, 0);
  static const first_row_text_font_size = 16.0;
  static const second_row_text_font_size = 12.0;
  static const home_action_padding = EdgeInsets.only(top: 20);
  static const title_font_size = 20.0;

  SelectVoidFunction selectCallback;
  List<Widget> actions;
  String title;

  AvatarItem userAvatar;

  @override
  void didUpdateWidget(covariant CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    refresh();
  }

  @override
  initState() {
    this.selectCallback = widget.selectCallback;
    this.actions = widget.actions;
    this.title = widget.title != null ? widget.title : "";
    this.userAvatar = widget.userAvatar;
    super.initState();
  }

  void refresh() {
    setState(() {
      this.selectCallback = widget.selectCallback;
      this.actions = widget.actions;
      this.title = widget.title != null ? widget.title : "";
      this.userAvatar = widget.userAvatar;
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.transparent,
          offset: Offset.zero,
          blurRadius: 0,
        )
      ]),
      child: AppBar(
        centerTitle: true,
        brightness: Brightness.dark,
        backgroundColor: MyColors.skyBlue,
        elevation: 0,
        automaticallyImplyLeading: true,
        shape: RoundedRectangleBorder(
          borderRadius: bar_radius,
        ),
        flexibleSpace: title.isEmpty ? homeWidgets() : null,
        actions: title.isNotEmpty ? actions : homeActions(),
        title: title.isNotEmpty
            ? Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: title_font_size))
            : null,
      ),
    );
  }

  Widget homeWidgets() {
    var image = userAvatar == null ? "" : userAvatar.image;
    var name = userAvatar == null ? "" : userAvatar.name;
    return Container(
      padding: padding_container,
      height: bar_height,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: avatar_size,
            child: CircleAvatar(
              backgroundColor: MyColors.silver,
              radius: avatar_size,
              backgroundImage: GlobalUtils.getAvatar(image).image,
            ),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              border: new Border.all(
                color: MyColors.white,
                width: avatar_border_size,
              ),
            ),
          ),
          Padding(padding: padding_column),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      height: 1,
                      color: MyColors.white,
                      fontSize: first_row_text_font_size,
                      fontWeight: FontWeight.bold)),
              GestureDetector(
                child: Text(Strings.myAccount,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        height: 1.3,
                        color: MyColors.white,
                        fontSize: second_row_text_font_size)),
                onTap: () {
                  var item =
                      CustomMenuItem(Strings.profile, MenuAction.profile);
                  selectCallback(item);
                },
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> homeActions() {
    return [
      Padding(
          padding: home_action_padding,
          child: IconButton(
              icon: ImageIcon(Assets.notification.image),
              color: MyColors.white,
              onPressed: () {
                GlobalUtils.showSnack(context, Strings.buildMsg);
              }))
    ];
  }
}
