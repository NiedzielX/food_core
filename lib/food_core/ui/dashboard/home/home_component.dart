import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:food_core/food_core/model/product.dart';
import 'package:food_core/food_core/model/product_item.dart';
import 'package:food_core/food_core/model/response.dart';
import 'package:food_core/food_core/ui/base/base_state.dart';
import 'package:food_core/food_core/ui/dashboard/home/home_presenter.dart';
import 'package:food_core/food_core/ui/dashboard/home/home_view.dart';
import 'package:food_core/food_core/ui/dashboard/home/views/category_scroller/category_scroller_component.dart';
import 'package:food_core/food_core/ui/product_details/product_details_component.dart';
import 'package:food_core/food_core/ui/product_list/product_list_component.dart';
import 'package:food_core/food_core/ui/product_list/product_list_page_parameters.dart';
import 'package:food_core/food_core/ui/views/product_scroller/product_scroller_component.dart';
import 'package:food_core/food_core/ui/views/search_bar/textfield_search.dart';
import 'package:food_core/food_core/utils/strings.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends BaseState<HomeFragment> implements HomeView {
  static const search_padding = EdgeInsets.fromLTRB(15, 10, 15, 10);
  static const row_spacing = EdgeInsets.only(top: 15.0);
  static const row_big_spacing = EdgeInsets.only(top: 20.0);

  HomePresenter presenter;

  bool viewLoaded = false;

  TextEditingController _searchField = new TextEditingController();

  var _formKey = GlobalKey<FormState>();

  List<Product> food = [];
  List<Product> exclusive = [];
  List<Product> bestsell = [];

  _HomeFragmentState() {
    presenter = new BasicHomePresenter();
  }

  @override
  void initState() {
    super.initState();
    presenter.view = this;
  }

  @override
  void dispose() {
    _searchField.dispose();
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getView();
  }

  Widget getView() {
    if (viewLoaded) {
      return Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: MediaQuery.of(context).size.height,
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            Padding(padding: row_spacing),
            getSearchView(),
            Padding(padding: row_spacing),
            getCategoryView(),
            Padding(padding: row_big_spacing),
            getProductExclusiveView(),
            Padding(padding: row_big_spacing),
            getProductBestSellView(),
            Padding(padding: row_big_spacing),
            getProductView(),
            Padding(padding: row_big_spacing),
          ]));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget getSearchView() {
    return getSearchInput();
  }

  Widget getSearchInput() {
    return Form(
        key: _formKey,
        child: Container(
            margin: search_padding,
            alignment: Alignment.topCenter,
            child: searchField(context)));
  }

  Widget searchField(BuildContext context) {
    return TextFieldSearch(
        searchPressed: goToSearchResult,
        controller: _searchField,
        getSelectedValue: (item) {
          goToSearchResult(item.value);
        },
        future: () {
          return presenter.suggestion(_searchField.text);
        });
  }

  void goToSearchResult(String phrase) {
    if (phrase.isEmpty) {
      _searchField.clear();
      return;
    }
    // TODO: SEARCH PAGE ADD
    goToAllProducts();
  }

  Widget getCategoryView() {
    return CategoryScrollerComponent();
  }

  Widget getProductView() {
    return ProductScrollerComponent(
        Strings.foodProducts,
        food
            .map((item) => ProductItem(
                onPressed: () {
                  goToProduct(item.id);
                },
                item: item))
            .toList(), onPressed: (() {
      goToAllProducts();
    }));
  }

  Widget getProductBestSellView() {
    return ProductScrollerComponent(
        Strings.bestSellProducts,
        bestsell
            .map((item) => ProductItem(
                onPressed: () {
                  goToProduct(item.id);
                },
                item: item))
            .toList(), onPressed: () {
      goToAllProducts();
    });
  }

  Widget getProductExclusiveView() {
    return ProductScrollerComponent(
        Strings.exclusiveProducts,
        exclusive
            .map((item) => ProductItem(
                onPressed: () {
                  goToProduct(item.id);
                },
                item: item))
            .toList(), onPressed: () {
      goToAllProducts();
    });
  }

  @override
  void setViewData(
      List<Product> food, List<Product> exclusive, List<Product> bestsell) {
    setState(() {
      this.food = food;
      this.exclusive = exclusive;
      this.bestsell = bestsell;
      this.viewLoaded = true;
    });
  }

  @override
  void onError(Response response) {
    handleError(response);
  }

  void goToProduct(int id) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetailsPage(id)));
  }

  void goToAllProducts() {
    var parameters = ProductListParameters(title: Strings.productListPageTitle);
    var page = ProductListPage(productListParameters: parameters);
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
