import 'package:food_core/food_core/model/user.dart';

abstract class SwitchProfileView {

  void setDataView(List<User> items);
  void onError(String message);
  void onDashboard();
  void onInterview();
}