import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/avatar_item.dart';
import 'package:food_core/food_core/model/menu.dart';
import 'package:food_core/food_core/model/response.dart';
import 'package:food_core/food_core/ui/base/base_state.dart';
import 'package:food_core/food_core/ui/dashboard/profile/profile_list_item.dart';
import 'package:food_core/food_core/ui/dashboard/profile/profile_presenter.dart';
import 'package:food_core/food_core/ui/dashboard/profile/profile_view.dart';
import 'package:food_core/food_core/ui/dashboard/profile/switch_profile/switch_profile_component.dart';
import 'package:food_core/food_core/ui/interview/questions/interview_questions_component.dart';
import 'package:food_core/food_core/ui/login/login_component.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

class ProfileFragment extends StatefulWidget {
  @override
  _ProfileFragmentState createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends BaseState<ProfileFragment>
    implements ProfileView {
  static const avatar_size = 52.0;
  static const row_spacing_vertical = 30.0;
  static const container_spacing_vertical = 20.0;
  static const list_item_spacing_vertical = 15.0;
  static const user_name_font_size = 20.0;
  static const user_name_vertical_spacing = 10.0;

  ProfilePresenter presenter;

  bool viewLoaded = false;

  List<CustomMenuItem> items;
  AvatarItem userAvatar;

  _ProfileFragmentState() {
    presenter = new BasicProfilePresenter();
  }

  @override
  void initState() {
    super.initState();
    presenter.view = this;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getView();
  }

  Widget getView() {
    if (viewLoaded) {
      return Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: MediaQuery.of(context).size.height,
          child: ListView(
              padding:
                  EdgeInsets.symmetric(horizontal: list_item_spacing_vertical),
              children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.only(top: list_item_spacing_vertical)),
                    Container(
                      alignment: Alignment.center,
                      width: avatar_size,
                      child: CircleAvatar(
                        radius: avatar_size,
                        backgroundColor: MyColors.silver,
                        backgroundImage:
                            GlobalUtils.getAvatar(userAvatar?.image).image,
                      ),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: MyColors.silver,
                          width: 2,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: user_name_vertical_spacing),
                        child: Center(
                            child: Text(userAvatar?.name ?? "",
                                style: TextStyle(
                                    fontSize: user_name_font_size,
                                    color: MyColors.color01,
                                    fontWeight: FontWeight.bold)))),
                  ] +
                  buildMenu()));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  List<Widget> buildMenu() {
    List<Widget> _items = [];
    var i = 0;
    items.forEach((e) {
      if (i == (items.length - 2)) {
        _items
            .add(Padding(padding: EdgeInsets.only(top: row_spacing_vertical)));
      }
      _items.add(ProfileListItem(e, selectedElement));
      i++;
    });
    _items.add(
        Padding(padding: EdgeInsets.only(top: container_spacing_vertical)));
    return _items;
  }

  void selectedElement(CustomMenuItem menuItem) {
    switch (menuItem.action) {
      case MenuAction.nutritionalInterview:
        goToNutritionalInterview();
        break;
      case MenuAction.logout:
        goToLogout();
        break;
      case MenuAction.switchProfile:
        goToSwitchProfile();
        break;
      default:
        GlobalUtils.showSnack(context, Strings.buildMsg);
        break;
    }
  }

  void goToNutritionalInterview() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InterviewPage()));
  }

  void goToPreferences() {}

  void goToLogout() {
    presenter.logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void goToHistory() {}

  void goToPremium() {}

  void goToContact() {}

  void goToSwitchProfile() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SwitchProfilePage(false)));
  }

  @override
  void setViewData(List<CustomMenuItem> menu, {AvatarItem userAvatar}) {
    setState(() {
      this.items = menu;
      this.userAvatar = userAvatar;
      this.viewLoaded = true;
    });
  }

  @override
  void onError(Response response) {
    handleError(response);
  }
}
