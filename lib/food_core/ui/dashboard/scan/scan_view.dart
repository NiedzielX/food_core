import 'package:food_core/food_core/ui/base/base_view.dart';

abstract class ScanView extends BaseView {
  void setViewData();
  void goToProductDetails({int id});
}