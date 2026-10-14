import 'package:flutter/material.dart';
import 'package:food_core/food_core/ui/product_details/product_details_component.dart';
import 'package:food_core/food_core/ui/product_list/product_list_item.dart';
import 'package:food_core/food_core/ui/product_list/product_list_page_parameters.dart';
import 'package:food_core/food_core/ui/product_list/product_list_presenter.dart';
import 'package:food_core/food_core/ui/product_list/product_list_stream.dart';
import 'package:food_core/food_core/ui/views/custom_appbar/simple_appbar.dart';
import 'package:food_core/food_core/ui/views/list_separator.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

class ProductListPage extends StatefulWidget {
  final ProductListParameters productListParameters;

  ProductListPage({@required this.productListParameters});

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductListPage> {
  static of(BuildContext context) =>
      context.findAncestorStateOfType<ProductListState>();

  final ProductListPresenter _pListPresenter = BaseProductListPresenter();
  final double _contentPadding = 15;

  @override
  void initState() {
    super.initState();
    _pListPresenter.fetchProductList();
  }

  @override
  void dispose() {
    _pListPresenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarWidget(),
      body: _buildBodyStreamWidget(),
    );
  }

  Widget _buildAppBarWidget() {
    return SimpleAppBarWidget(_getAppBarParameters());
  }

  Widget _buildBodyStreamWidget() {
    return StreamBuilder<ProductListStream>(
        initialData: ProductListStream.LOADING,
        stream: _pListPresenter.getProductListStream(),
        builder: (context, snapshot) => _buildBodyWidget(snapshot.data));
  }

  Widget _buildBodyWidget(ProductListStream state) {
    return Stack(children: [
      _buildProductListWidget(),
      _buildLoadingWidget(state),
      _buildErrorWidget(state)
    ]);
  }

  Widget _buildProductListWidget() {
    var productList = _pListPresenter?.getProductList();
    return ListView.separated(
      padding: EdgeInsets.all(_contentPadding),
      separatorBuilder: (context, index) => CustomDivider(height: 1),
      itemCount: productList?.length ?? 0,
      itemBuilder: (context, index) => ProductListItemWidget(
          productList[index], (productId) => goToProduct(productId)),
    );
  }

  Widget _buildLoadingWidget(ProductListStream state) {
    return Align(
      alignment: Alignment.center,
      child: Visibility(
          visible: state == ProductListStream.LOADING,
          child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorWidget(ProductListStream interviewState) {
    return Align(
      alignment: Alignment.center,
      child: Visibility(
          visible: interviewState == ProductListStream.ERROR,
          child: Text(_pListPresenter.getProductListError(),
              style: GlobalUtils.body1Text(context))),
    );
  }

  AppbarParameters _getAppBarParameters() {
    return AppbarParameters(
        title:
            widget.productListParameters.title ?? Strings.productListPageTitle);
  }

  goToProduct(int productId) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ProductDetailsPage(productId)));
  }
}
