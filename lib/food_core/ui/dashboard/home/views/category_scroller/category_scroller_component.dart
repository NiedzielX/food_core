import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/ui/dashboard/home/views/category_scroller/category_scroller.dart';
import 'package:food_core/food_core/ui/dashboard/home/views/category_scroller/category_scroller_presenter.dart';
import 'package:food_core/food_core/ui/dashboard/home/views/category_scroller/category_scroller_state.dart';
import 'package:food_core/food_core/utils/global.dart';

class CategoryScrollerComponent extends StatefulWidget {
  CategoryScrollerComponent();

  @override
  _CategoryScrollerComponentState createState() =>
      _CategoryScrollerComponentState();
}

class _CategoryScrollerComponentState extends State<CategoryScrollerComponent> {
  static const button_icons_size = 72.0;
  static const button_horizontal_spacing = EdgeInsets.symmetric(horizontal: 15);

  final CategoryScrollerPresenter _categoryScrollerPresenter =
      BaseCategoryScrollerPresenter();

  @override
  initState() {
    super.initState();
    _categoryScrollerPresenter.fetchCategories();
  }

  @override
  dispose() {
    _categoryScrollerPresenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _categoryScrollerPresenter.getCategoryStream(),
      initialData: CategoryScrollerState.LOADING,
      builder: (context, snapshot) => _buildWidget(snapshot),
    );
  }

  _buildWidget(AsyncSnapshot<CategoryScrollerState> snapshot) {
    var state = snapshot.data;
    switch (state) {
      case CategoryScrollerState.LOADING:
        return _buildLoadingWidget();
      case CategoryScrollerState.COMPLETED:
        return _buildCategoryScrollerWidget();
      case CategoryScrollerState.ERROR:
        return _buildErrorWidget();
    }
  }

  Widget _buildCategoryScrollerWidget() {
    var categories = _categoryScrollerPresenter.getCategories();
    return ValueListenableBuilder<int>(
      valueListenable: _categoryScrollerPresenter.getSelectedCategoryNotifier(),
      builder: (context, selectedItem, child) => CategoryScroller(
          description: "",
          parentEndColor: Colors.transparent,
          parentStartColor: Colors.transparent,
          heightView: button_icons_size,
          buttonSpacing: button_horizontal_spacing,
          buttonSize: button_icons_size,
          direction: Direction.LTR,
          childrenData: categories
              .map((categoryModel) => CategoryMenuItem(
                  selectedItem: selectedItem,
                  onPressed: (id) {
                    selectCategory(id);
                  },
                  id: categoryModel.id,
                  title: categoryModel.title,
                  icon: Image.network(categoryModel.image,
                      color: selectedItem == categoryModel.id
                          ? Colors.white
                          : MyColors.darkGrey,
                      width: 36,
                      height: 36)))
              .toList()),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
        height: button_icons_size,
        child: Center(child: CircularProgressIndicator()));
  }

  _buildErrorWidget() {
    var message = _categoryScrollerPresenter.getCategoryErrorMessage() ?? "";
    return Container(
        height: button_icons_size,
        child: Center(
            child: Text(message, style: GlobalUtils.body1Text(context))));
  }

  void selectCategory(int id) {
    _categoryScrollerPresenter.selectCategory(id);
  }
}
