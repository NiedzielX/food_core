import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/favorite_product_model.dart';
import 'package:food_core/food_core/ui/favorites_products/favorites_products_presenter.dart';
import 'package:food_core/food_core/ui/favorites_products/favorites_products_state.dart';
import 'package:food_core/food_core/ui/product_details/product_details_component.dart';
import 'package:food_core/food_core/ui/views/list_separator.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/constants.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';
import 'package:intl/intl.dart';

class FavoritesProductsFragment extends StatefulWidget {
  @override
  FavoritesProductsFragmentState createState() =>
      FavoritesProductsFragmentState();
}

class FavoritesProductsFragmentState extends State<FavoritesProductsFragment> {
  final FavoritesProductsPresenter _fpPresenter =
      BaseFavoritesProductsPresenter();

  final double contentPadding = 15;

  @override
  void initState() {
    super.initState();
    _fpPresenter.fetchFavoritesProductsList();
  }

  @override
  void dispose() {
    _fpPresenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: MediaQuery.of(context).size.height,
        child: _buildFavoriteProductsStream());
  }

  Widget _buildFavoriteProductsStream() {
    return StreamBuilder<FavoritesProductsState>(
        initialData: FavoritesProductsState.LOADING,
        stream: _fpPresenter.getFavoritesProductsStream(),
        builder: (context, snapshot) => Column(children: [
              _buildSearchFrom(),
              _handleFavoriteProductState(snapshot.data)
            ]));
  }

  Widget _handleFavoriteProductState(FavoritesProductsState interviewState) {
    return Expanded(
      child: Stack(children: [
        _buildFavoriteProductsBody(),
        _buildLoadingFavoritesWidget(interviewState),
        _buildErrorWidget(interviewState)
      ]),
    );
  }

  Align _buildErrorWidget(FavoritesProductsState interviewState) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Visibility(
            visible: interviewState == FavoritesProductsState.ERROR,
            child: Text(_fpPresenter?.getErrorMessage() ?? "",
                style: GlobalUtils.body1Text(context))),
      ),
    );
  }

  Align _buildLoadingFavoritesWidget(FavoritesProductsState interviewState) {
    return Align(
      alignment: Alignment.topCenter,
      child: Visibility(
          visible: interviewState == FavoritesProductsState.LOADING,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          )),
    );
  }

  Widget _buildFavoriteProductsBody() {
    List<FavoriteProductModel> favoritesProductsList =
        _fpPresenter.getFavoritesProductsList();
    var length = favoritesProductsList?.length ?? 0;

    return ListView.separated(
      padding: EdgeInsets.all(contentPadding),
      separatorBuilder: (context, index) => CustomDivider(height: 30),
      itemCount: length,
      itemBuilder: (context, index) =>
          _buildFavoriteProductItem(favoritesProductsList[index]),
    );
  }

  _buildSearchFrom() {
    return Container(
      padding:
        EdgeInsets.only(top: 25, right: contentPadding, left: contentPadding),
      child: TextFormField(
      onChanged: (value) =>
        _fpPresenter.fetchFavoritesProductsList(searchValue: value),
      style: TextStyle(color: MyColors.darkGrey),
      cursorColor: Constants.cursorColor,
      decoration: InputDecoration(
        contentPadding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        border: new OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          )),
        hintText: Strings.favoritesProductsSearchHint,
        filled: true,
        hintStyle: TextStyle(color: MyColors.darkGrey, fontSize: 12),
        fillColor: Constants.fieldFormBackgroundColor,
        suffixIcon: Container(width: 20, alignment: Alignment.center, child: Image(image: Assets.search.image, width: 20, height: 20))
      )
    )
    );
  }

  Widget _buildFavoriteProductItem(FavoriteProductModel item) {
    final formatter = NumberFormat("#");
    return InkWell(
      onTap: () => goToProduct(item.productId),
      child: Row(
        children: [
          Image.network(item.image, height: 60, width: 60),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName,
                    style: GlobalUtils.headingText(context, 14)),
                Text(
                    "${formatter.format(item.weight)}${item.weightUnit}, ${item.brand}",
                    style: GlobalUtils.interviewBody1TextStyle(12))
              ],
            ),
          ))
        ],
      ),
    );
  }

  goToProduct(int productId) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetailsPage(productId)));
  }
}
