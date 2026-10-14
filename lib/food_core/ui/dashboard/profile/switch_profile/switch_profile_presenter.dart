import 'package:food_core/food_core/repositories/user_repository.dart';
import 'package:food_core/food_core/service/local.dart';
import 'package:food_core/food_core/ui/dashboard/profile/switch_profile/switch_profile_view.dart';

abstract class SwitchProfilePresenter {
  set view(SwitchProfileView value);

  void dispose();
  void onSkip();
}

class BasicSwitchProfilePresenter implements SwitchProfilePresenter {

  SwitchProfileView _view;
  UserRepository _repository = UserRepository();

  Local _local = Local();

  BasicSwitchProfilePresenter() {
    getData();
  }

  @override
  set view(SwitchProfileView value) {
    _view = value;
  }

  void getData() async {

    try {
      var response = await _repository.fetchProfiles();
      _view.setDataView(response.profiles);
    } catch (e) {

    }
  }

  @override
  void dispose() async {
    _repository.dispose();
  }

  @override
  void onSkip() async {
    _local.setSkippedProfile(true);
    var onInterview = await _local.getSkippedInterview();
    if (!onInterview) {
      _view.onInterview();
      return;
    }
    _view.onDashboard();
  }
}