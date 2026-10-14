import 'package:food_core/food_core/repositories/scan_repository.dart';
import 'package:food_core/food_core/ui/dashboard/scan/scan_view.dart';

abstract class ScanPresenter {
  set view(ScanView value);
  void getData();
  void getProduct(String code);
  void dispose();
}

class BasicScanPresenter implements ScanPresenter {

  ScanView _view;
  ScanRepository _repository = ScanRepository();

  BasicScanPresenter();

  @override
  set view(ScanView value) {
    _view = value;
    getData();
  }

  getData() async {
    _view.setViewData();
  }

  void getProduct(String code) async {
    try {
      var response = await _repository.fetchScan(code);
      _view.goToProductDetails(id: response.id > 0 ? response.id : null);
    } catch (e) {
      _view.goToProductDetails();
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}