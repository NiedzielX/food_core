import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/product_details_model.dart';
import 'package:food_core/food_core/model/product_item.dart';
import 'package:food_core/food_core/ui/favorites_products/toggle_favorite_product_button.dart';
import 'package:food_core/food_core/ui/product_details/product_details_presenter.dart';
import 'package:food_core/food_core/ui/product_details/product_details_state.dart';
import 'package:food_core/food_core/ui/product_details/product_details_view.dart';
import 'package:food_core/food_core/ui/views/list_separator.dart';
import 'package:food_core/food_core/ui/views/product_scroller/product_scroller_component.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/constants.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;

  ProductDetailsPage(this.productId);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState(productId);
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with TickerProviderStateMixin
    implements ProductDetailsView {
  final double _dividerHeight = 30;
  final double _contentSpace = 20;

  bool _pNutritionalValuesVisibility = false;
  bool _pDescriptionsVisibility = false;
  bool _pIngredientsVisibility = false;

  ProductDetailsPresenter _pDetailsPresenter;

  _ProductDetailsPageState(int productId) {
    _pDetailsPresenter = BaseProductDetailsPresenter(productId);
  }

  @override
  void dispose() {
    _pDetailsPresenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: StreamBuilder<ProductDetailsState>(
        initialData: ProductDetailsState.LOADING,
        stream: _pDetailsPresenter.getProductStreamController(),
        builder: (context, snapshot) => _buildProductDetailsBody(snapshot),
      ),
    );
  }

  Widget _buildProductDetailsBody(AsyncSnapshot<ProductDetailsState> snapshot) {
    switch (snapshot.data) {
      case ProductDetailsState.SUCCESS:
        return _buildProductDetailsList();
      case ProductDetailsState.LOADING:
        return Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        );
      case ProductDetailsState.ERROR:
        return _buildErrorWidget();
      default:
        return Container();
    }
  }

  ListView _buildProductDetailsList() {
    return ListView(
      children: [
        _buildHeaderImage(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              _buildProductTitle(),
              _buildCustomDivider(),
              _buildProductDescription(),
              _buildCustomDivider(),
              _buildProductIngredients(),
              _buildCustomDivider(),
              _buildProductNutritionalValues(),
              _buildAlternativesProducts()
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCustomDivider() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomDivider(height: _dividerHeight),
      );

  Column _buildAlternativesProducts() {
    return Column(
      children: [SizedBox(height: _contentSpace), _getAlternativesProducts()],
    );
  }

  Widget _getAlternativesProducts() {
    return ProductScrollerComponent(
        Strings.productDetailsAlternatives,
        _getProductDetailsModel()
            .alternatives
            .map((item) => ProductItem(
                onPressed: () {
                  goToProduct(item.id);
                },
                item: item))
            .toList());
  }

  Widget _buildProductDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          toggleProductDescriptionVisibility();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.productDetailsDescription,
                  style: GlobalUtils.darkHeadingText(context, 16),
                ),
                RotatedBox(
                    quarterTurns: _pDescriptionsVisibility ? 1 : 0,
                    child:
                        Container(width: 14, height: 14, child: Assets.arrow))
              ],
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              vsync: this,
              child: Visibility(
                visible: _pDescriptionsVisibility,
                child: Column(
                  children: [
                    SizedBox(height: _contentSpace),
                    Text(
                      _getProductDetailsModel().description,
                      style: GlobalUtils.body1Text(context, 13),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProductIngredients() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          toggleProductIngredientsVisibility();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    Strings.productDetailsIngredients,
                    style: GlobalUtils.darkHeadingText(context, 16),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: MyColors.accentGrey,
                    child: Text(
                      _getProductDetailsModel().weight,
                      style: GlobalUtils.body1Text(context, 9),
                    ),
                  ),
                ),
                SizedBox(width: 40),
                RotatedBox(
                    quarterTurns: _pIngredientsVisibility ? 1 : 0,
                    child:
                        Container(width: 14, height: 14, child: Assets.arrow))
              ],
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              vsync: this,
              child: Visibility(
                visible: _pIngredientsVisibility,
                child: _buildProductIngredientsList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _buildProductIngredientsList() {
    var productDetails = _pDetailsPresenter.getProductDetailsModel();
    var ingredients = productDetails.ingredients;
    var length = ingredients.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < length; i++) _buildIngredientItem(ingredients[i])
      ],
    );
  }

  Widget _buildIngredientItem(ProductIngredient ingredient) {
    bool hasInfo = ingredient.info != null;
    var tooltipKey = new GlobalKey();
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            ingredient.name,
            style: hasInfo
                ? TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Constants.productIngredientWarningColor)
                : GlobalUtils.body1Text(context, 13),
          ),
        ),
        Visibility(
          visible: hasInfo,
          child: Tooltip(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(10),
            showDuration: Duration(seconds: 1),
            key: tooltipKey,
            verticalOffset: 20,
            textStyle: TextStyle(color: Colors.white, fontSize: 12),
            decoration: BoxDecoration(
              color: Constants.buttonColor,
              borderRadius: BorderRadius.circular(5),
            ),
            message: ingredient.info ?? "",
            preferBelow: false,
            child: InkWell(
              onTap: () {
                final dynamic tooltip = tooltipKey.currentState;
                tooltip.ensureTooltipVisible();
              },
              child: Container(
                  padding: EdgeInsets.all(7),
                  child: Assets.productIngredientsInfo),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProductNutritionalValues() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          toggleProductNutritionalValuesVisibility();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.productDetailsNutritionalValues,
                  style: GlobalUtils.darkHeadingText(context, 16),
                ),
                RotatedBox(
                    quarterTurns: _pNutritionalValuesVisibility ? 1 : 0,
                    child:
                        Container(width: 14, height: 14, child: Assets.arrow))
              ],
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              vsync: this,
              child: Visibility(
                visible: _pNutritionalValuesVisibility,
                child: Column(
                  children: [
                    SizedBox(height: _contentSpace),
                    _buildNutritionalValuesList()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildNutritionalValuesList() {
    var productDetails = _pDetailsPresenter.getProductDetailsModel();
    var nutritionalValues = productDetails.nutritionalValues;
    var length = nutritionalValues.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < length; i++)
          _buildNutritionalValueItem(nutritionalValues[i])
      ],
    );
  }

  _buildNutritionalValueItem(ProductNutritionalValue nutritionalValue) {
    return Row(children: [
      Flexible(
        fit: FlexFit.loose,
        child: Text(
          nutritionalValue.name,
          style: GlobalUtils.body1Text(context, 13),
        ),
      ),
    ]);
  }

  Widget _buildProductTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getProductDetailsModel().title,
                  style: GlobalUtils.darkHeadingText(context, 20),
                ),
                Text(
                  "${_getProductDetailsModel().weight} , ${_getProductDetailsModel().brand}",
                  style: GlobalUtils.subHeadingText(context, 12),
                )
              ],
            ),
          ),
          ToggleFavoriteProductButton(
              isFavorite: _getProductDetailsModel().isFavorite,
              productId: _getProductDetailsModel().id)
        ],
      ),
    );
  }

  ClipRRect _buildHeaderImage() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Container(
          height: 180,
          padding: EdgeInsets.only(bottom: 20),
          color: MyColors.accentGrey,
          child: Image.network(
            _getProductDetailsModel().image,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                ),
              );
            },
          )),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
        leading: RotatedBox(
          quarterTurns: 2,
          child: IconButton(
              icon: Assets.backArrow,
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        brightness: Brightness.light,
        backgroundColor: MyColors.accentGrey,
        elevation: 0,
        actions: <Widget>[IconButton(icon: Assets.upload, onPressed: () {})]);
  }

  void toggleProductDescriptionVisibility() {
    setState(() {
      _pDescriptionsVisibility = !_pDescriptionsVisibility;
    });
  }

  void toggleProductIngredientsVisibility() {
    setState(() {
      _pIngredientsVisibility = !_pIngredientsVisibility;
    });
  }

  void toggleProductNutritionalValuesVisibility() {
    setState(() {
      _pNutritionalValuesVisibility = !_pNutritionalValuesVisibility;
    });
  }

  ProductDetailsModel _getProductDetailsModel() {
    return _pDetailsPresenter.getProductDetailsModel();
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Text(_pDetailsPresenter.getErrorMessage(),
          style: GlobalUtils.body1Text(context)),
    );
  }

  void goToProduct(int id) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => ProductDetailsPage(id)));
  }
}
