import 'package:food_core/food_core/model/avatar_item.dart';
import 'package:food_core/food_core/model/menu.dart';
import 'package:food_core/food_core/service/local.dart';
import 'package:food_core/food_core/ui/dashboard/profile/profile_view.dart';

class ProfilePresenter {
  set view(ProfileView value) {}
  void getData() async {}
  void logout() {}
}

class BasicProfilePresenter implements ProfilePresenter {

  ProfileView _view;
  Local _local;

  BasicProfilePresenter() {
    _local = Local();
    getData();
  }

  @override
  set view(ProfileView value) {
    _view = value;
  }

  getData() async {
    var items = Menu.getItemsSettings();
    var user = await _local.getUser();
    AvatarItem userAvatar;
    if(user != null) {
      userAvatar = AvatarItem(user.name, image: user.avatar);
    }
    _view.setViewData(items, userAvatar: userAvatar);
  }

  @override
  void logout() {
    _local.saveUser(null);
  }
}