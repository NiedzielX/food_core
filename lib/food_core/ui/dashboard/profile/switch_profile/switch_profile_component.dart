import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/user.dart';
import 'package:food_core/food_core/ui/base/base_state.dart';
import 'package:food_core/food_core/ui/dashboard/dashboard_component.dart';
import 'package:food_core/food_core/ui/dashboard/profile/add_profile/add_profile_component.dart';
import 'package:food_core/food_core/ui/dashboard/profile/edit_switch_profile/edit_switch_profile_component.dart';
import 'package:food_core/food_core/ui/dashboard/profile/switch_profile/switch_profile_avatar_item.dart';
import 'package:food_core/food_core/ui/dashboard/profile/switch_profile/switch_profile_presenter.dart';
import 'package:food_core/food_core/ui/dashboard/profile/switch_profile/switch_profile_view.dart';
import 'package:food_core/food_core/ui/interview/questions/interview_questions_component.dart';
import 'package:food_core/food_core/ui/views/custom_appbar/custom_appbar.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/message_dialog.dart';
import 'package:food_core/food_core/utils/strings.dart';

class SwitchProfilePage extends StatefulWidget {
  final bool onSkip;

  SwitchProfilePage(this.onSkip);

  @override
  _SwitchProfilePageState createState() => _SwitchProfilePageState();
}

class _SwitchProfilePageState extends BaseState<SwitchProfilePage>
    implements SwitchProfileView {
  static const top_bar_height = 80.0;
  static const grid_padding = 20.0;
  static const cell_height = 180.0;
  static const _crossAxisSpacing = 8.0;
  static const _mainAxisSpacing = 10.0;
  static const _crossAxisCount = 2;
  static const button_more_font_size = 14.0;
  static const button_more_label_spacing = EdgeInsets.only(left: 5);

  SwitchProfilePresenter presenter;
  bool viewLoaded = false;
  bool isEditingView = false;
  bool onSkip = false;

  List<User> items = [];

  User selected;

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _SwitchProfilePageState() {
    presenter = new BasicSwitchProfilePresenter();
    presenter.view = this;
  }

  @override
  void initState() {
    this.onSkip = widget.onSkip ?? false;
    super.initState();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = cell_height;
    var _aspectRatio = _width / cellHeight;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            child: CustomAppBar(
                onSkip ? Strings.manageProfiles : Strings.switchProfile,
                actions: onSkip ? [] : editProfile()),
            preferredSize: Size.fromHeight(top_bar_height)),
        body: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topLeft,
            child: Column(children: <Widget>[
              addSkip(),
              GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.all(grid_padding),
                  crossAxisSpacing: _crossAxisSpacing,
                  mainAxisSpacing: _mainAxisSpacing,
                  crossAxisCount: _crossAxisCount,
                  childAspectRatio: _aspectRatio,
                  children: buildItems()),
              GestureDetector(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Assets.addButton,
                        Padding(padding: button_more_label_spacing),
                        Text(Strings.addMore,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: MyColors.skyBlue,
                                fontSize: button_more_font_size,
                                fontWeight: FontWeight.bold))
                      ]),
                  onTap: () {
                    goToAddProfile();
                  })
            ])));
  }

  List<Widget> editProfile() {
    return [
      IconButton(
          icon: ImageIcon(
              isEditingView ? Assets.cancelIcon.image : Assets.edit.image,
              size: isEditingView ? 16.0 : 20.0),
          color: MyColors.white,
          onPressed: () {
            setState(() {
              isEditingView = !isEditingView;
            });
          })
    ];
  }

  List<Widget> buildItems() {
    if (!viewLoaded) {
      return [Center(child: CircularProgressIndicator())];
    }
    return items
        .map((item) => SwitchProfileAvatarItem(item, selectedElement,
            isEditingView, selected != null && item.id == selected.id))
        .toList();
  }

  Widget addSkip() {
    if (!onSkip) {
      return Container();
    }
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15.0),
            child: TextButton(
                style: GlobalUtils.textButtonStyle(),
                onPressed: () {
                  presenter.onSkip();
                },
                child: Text(
                  Strings.onboardingNext,
                )),
          )
        ]);
  }

  void selectedElement(User selected) {
    if (isEditingView) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => EditSwitchProfilePage()));
    } else {
      setState(() {
        this.selected = selected;
      });
    }
  }

  void goToAddProfile() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddProfilePage()));
  }

  @override
  void onDashboard() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DashboardPage(), fullscreenDialog: true));
  }

  @override
  void onInterview() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => InterviewPage(
                interviewParameters: InterviewParameters(allowSkip: true)),
            fullscreenDialog: true));
  }

  @override
  void setDataView(List<User> items) {
    setState(() {
      this.items = items;
      this.selected = items.first;
      this.viewLoaded = true;
    });
  }

  @override
  void onError(String message) {
    showMessageDialog(context, message);
  }
}
