import 'package:flutter/material.dart';
import 'package:food_core/food_core/model/product.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:intl/intl.dart';

class ProductListItemWidget extends StatelessWidget {
  final NumberFormat _formatter = NumberFormat("#");
  final Function(int) _productTap;
  final Product _product;

  ProductListItemWidget(this._product, this._productTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _productTap(_product.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: _buildContent(context),
      ),
    );
  }

  Row _buildContent(BuildContext context) {
    return Row(
      children: [
        Image.network(_product.image, height: 60, width: 60),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_product.title, style: GlobalUtils.headingText(context, 14)),
              _buildDescription()
            ],
          ),
        ))
      ],
    );
  }

  Text _buildDescription() {
    return Text(
        "${_formatter.format(_product.quantity)}${_product.unit}, ${_product.brand}",
        style: GlobalUtils.interviewBody1TextStyle(12));
  }
}
