import 'package:food_core/food_core/model/product.dart';

class ProductItem {
  final Function onPressed;
  final Product item;

  ProductItem({this.onPressed, this.item});
}