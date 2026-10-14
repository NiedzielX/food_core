import 'dart:math';

import 'package:food_core/food_core/model/avatar_item.dart';
import 'package:food_core/food_core/model/menu.dart';
import 'package:food_core/food_core/service/local.dart';
import 'package:food_core/food_core/ui/dashboard/dashboard_view.dart';
import 'package:food_core/food_core/ui/dashboard/dashboard_viewmodel.dart';
abstract class DashboardPresenter {
  set view(DashboardView value);
  int indexOfMenuAction(CustomMenuItem element);
}

class BasicDashboardPresenter implements DashboardPresenter{
  DashboardViewModel _viewModel;
  DashboardView _view;

  Local _local;

  BasicDashboardPresenter() {
    this._local = Local();
    this._viewModel = DashboardViewModel();
    initView();
  }

  @override
  set view(DashboardView value) {
    _view = value;
  }

  void initView() async {
    var menu = Menu.getItems();
    _viewModel.items = menu;

    var user = await _local.getUser();
    if(user != null) {
      var userAvatar = AvatarItem(user.name, image: user.avatar);
      _view.setViewData(menu, userAvatar: userAvatar);
    } else {
      _view.setViewData(menu);
    }
  }

  int indexOfMenuAction(CustomMenuItem element) {
    if(element == null) return 0;
    return max(_viewModel.items.indexWhere((ele) => element.action == ele.action),0);
  }
}