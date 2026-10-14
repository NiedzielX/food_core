import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/response.dart';
import 'package:food_core/food_core/ui/base/base_state.dart';
import 'package:food_core/food_core/ui/dashboard/scan/scan_presenter.dart';
import 'package:food_core/food_core/ui/dashboard/scan/scan_view.dart';
import 'package:food_core/food_core/ui/product_details/product_details_component.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanFragment extends StatefulWidget {
  @override
  _ScanFragmentState createState() => _ScanFragmentState();
}

class _ScanFragmentState extends BaseState<ScanFragment> implements ScanView {

  static const scan_border_radius = 10.0;
  static const scan_border_length = 50.0;
  static const scan_border_width = 10.0;
  static const scan_margin_horizontal = 60.0;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  ScanPresenter presenter;

  bool viewLoaded = true;
  bool scanInProgress = false;

  _ScanFragmentState() {
    presenter = new BasicScanPresenter();
  }

  @override
  void initState() {
    super.initState();
    presenter.view = this;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: MyColors.skyBlue,
          borderRadius: scan_border_radius,
          borderLength: scan_border_length,
          borderWidth: scan_border_width,
          cutOutSize: MediaQuery.of(context).size.width - scan_margin_horizontal),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
        if(scanInProgress) {
          return;
        }

        scanInProgress = true;
        presenter.getProduct(scanData.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildQrView(context);
  }

  Widget getView() {
    if (viewLoaded) {
      return Column(
        children: <Widget>[
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
      )]);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  void setViewData() {
    setState(() {
      this.viewLoaded = true;
    });
  }

  @override
  void goToProductDetails({int id}) async {
    if(id == null) {
      scanInProgress = false;
      return;
    }

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetailsPage(id)));

    scanInProgress = false;
  }

  @override
  void onError(Response response) {
    handleError(response);
  }
}
