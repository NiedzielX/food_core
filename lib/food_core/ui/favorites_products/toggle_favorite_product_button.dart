import 'package:flutter/material.dart';
import 'package:food_core/food_core/ui/favorites_products/toggle_favorite_product_presenter.dart';
import 'package:food_core/food_core/ui/favorites_products/toggle_favorite_product_state.dart';
import 'package:food_core/food_core/utils/assets.dart';

class ToggleFavoriteProductButton extends StatefulWidget {
  final bool isFavorite;
  final int productId;

  ToggleFavoriteProductButton(
      {@required this.isFavorite, @required this.productId});

  @override
  ToggleFavoriteProductButtonState createState() =>
      ToggleFavoriteProductButtonState();
}

class ToggleFavoriteProductButtonState
    extends State<ToggleFavoriteProductButton> {
  ToggleFavoriteProductPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = BaseToggleFavoritesProductsPresenter(
        widget.isFavorite, widget.productId);
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ToggleFavoriteProductState>(
        initialData: ToggleFavoriteProductState.IDLE,
        stream: _presenter.getStream(),
        builder: (context, snapshot) => _buildBody(snapshot.data));
  }

  _buildBody(ToggleFavoriteProductState snapshot) {
    return Stack(
      children: [
        InkWell(
          onTap: () => _presenter.toggleFavoriteProduct(),
          child: Visibility(
              visible: snapshot != ToggleFavoriteProductState.SAVING,
              child: _presenter.isFavorite() ? Assets.unLike : Assets.like),
        ),
        Visibility(
            visible: snapshot == ToggleFavoriteProductState.SAVING,
            child: Container(
                width: 24, height: 24, child: CircularProgressIndicator()))
      ],
    );
  }
}
