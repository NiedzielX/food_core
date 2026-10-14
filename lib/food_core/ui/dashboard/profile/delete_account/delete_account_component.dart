import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/user.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

class DeleteAccountWidget {
  final double contentPadding = 20;
  double position = 0;

  final BuildContext context;

  OverlayEntry _overlayEntry;

  Function deleteAccountCallback;

  User user;

  DeleteAccountWidget(this.context, this.user);

  show() {
    this._overlayEntry = _createSuggestionsOverlay();
    Overlay.of(context).insert(this._overlayEntry);
  }

  OverlayEntry _createSuggestionsOverlay() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    return OverlayEntry(
        builder: (context) => Material(
              color: Color(0x90000000),
              child: InkWell(
                onTap: () => dismiss(),
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: _buildContentWidget(size, context),
                ),
              ),
            ));
  }

  Widget _buildContentWidget(Size size, BuildContext context) {
    return Stack(children: [
      Positioned(
        bottom: position,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
            child: GestureDetector(
              onTap: () {},
              onVerticalDragUpdate: (DragUpdateDetails details) {
                position -= details.delta.dy;
                if (position > 0) {
                  position = 0;
                }
                if (position.abs() > 200) {
                  dismiss();
                } else {
                  _overlayEntry.markNeedsBuild();
                }
              },
              child: Container(
                padding: EdgeInsets.all(contentPadding),
                color: MyColors.white,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () => dismiss(), child: Assets.cancelIcon),
                    ),
                    Text(Strings.deleteAccountWidgetTitle,
                        style: GlobalUtils.darkHeadingText(context, 22)),
                    SizedBox(height: 20),
                    _buildUserInfoWidget(context),
                    SizedBox(height: 20),
                    Text(
                      Strings.deleteAccountDescription,
                      style: GlobalUtils.body1Text(context),
                    ),
                    SizedBox(height: 40),
                    _buildConfirmDeleteAccountButton(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _buildConfirmDeleteAccountButton() {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    side: BorderSide(
                        color: MyColors.redSecondary,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5))),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
            backgroundColor: MaterialStateProperty.all<Color>(MyColors.white)),
        onPressed: () {
          dismiss();
          deleteAccountCallback.call();
        },
        child: Text(
          Strings.confirmDeleteAccount.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: MyColors.redSecondary),
        ));
  }

  ClipRRect _buildUserInfoWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: Container(
        padding: EdgeInsets.all(12),
        color: Color(0x1006ABCC),
        child: Row(
          children: [
            Container(
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: new Border.all(
                  color: MyColors.white,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                  radius: 52,
                  backgroundColor: MyColors.silver,
                  backgroundImage: GlobalUtils.getAvatar(user.avatar).image),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                user.name,
                style: GlobalUtils.darkHeadingText(context, 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool dismiss() {
    if (_overlayEntry == null) {
      return true;
    } else {
      _overlayEntry.remove();
      _overlayEntry = null;
      return false;
    }
  }
}
