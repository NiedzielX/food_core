import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_core/food_core/extensions/styled_text_field.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_presenter.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_state.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_view.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/email_validator.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/message_dialog.dart';
import 'package:food_core/food_core/utils/strings.dart';

class PasswordRecoveryPage extends StatefulWidget {
  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage>
    implements RecoverPasswordView {
  static const FORM_ROW_SPACING_PADDING = EdgeInsets.fromLTRB(0, 0, 0, 15);
  static const ROW_SPACING = EdgeInsets.symmetric(vertical: 10);
  static const BODY_PADDING = EdgeInsets.all(20);

  var _formKey = GlobalKey<FormState>();
  final PasswordRecoveryPresenter _prPresenter =
      BasePasswordRecoveryPresenter();

  @override
  void initState() {
    super.initState();
    _prPresenter.setView(this);
  }

  @override
  void dispose() {
    _prPresenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: _buildPasswordRecoveryBody());
  }

  AppBar _buildAppBar() {
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
        backgroundColor:Colors.white,
        elevation: 0,
    );
  }

  Widget _buildPasswordRecoveryBody() {
    return GestureDetector(
      onTap: () {
        clearFocus();
      },
      child: SingleChildScrollView(
        padding: BODY_PADDING,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [Padding(padding: ROW_SPACING, child: Assets.logo)],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: ROW_SPACING,
                      child: Text(Strings.passwordRecovery,
                          textAlign: TextAlign.left,
                          style: GlobalUtils.darkHeadingText(context))),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                        padding: ROW_SPACING,
                        child: AutoSizeText(
                          Strings.passwordRecoveryDescription,
                          textAlign: TextAlign.left,
                          style: GlobalUtils.subHeadingText(context),
                        ))),
              ],
            ),
            Padding(padding: ROW_SPACING),
            Row(children: [
              Text(Strings.email,
                  textAlign: TextAlign.left,
                  style: GlobalUtils.textFieldStyle(context)),
            ]),
            Row(
              children: [
                Expanded(
                    child: Padding(
                        padding: FORM_ROW_SPACING_PADDING,
                        child: Form(key: _formKey, child: _emailFormField())))
              ],
            ),
            Padding(padding: ROW_SPACING * 2),
            Row(
              children: [Expanded(child: _sendButton())],
            )
          ],
        ),
      ),
    );
  }

  Widget _emailFormField() {
    return Stack(alignment: Alignment.topRight, children: [
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          _prPresenter.validateEmail(value);
        },
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if ((value == null || value.isEmpty)) {
            return (Strings.required);
          }
          if (!EmailValidator.isValid(value)) {
            return (Strings.incorrectEmail);
          }
          return null;
        },
        decoration: StyledTextField.styled(Strings.emailHint).copyWith(
            contentPadding:
                const EdgeInsets.only(top: 15, bottom: 15, right: 30.0)),
      ),
      Positioned(
          top: 17,
          child: ValueListenableBuilder<bool>(
              valueListenable: _prPresenter.getEmailNotifier(),
              builder: (context, value, child) =>
                  _buildEmailCorrectedImage(value)))
    ]);
  }

  Widget _sendButton() {
    return StreamBuilder<PasswordRecoveryState>(
      initialData: PasswordRecoveryState.IDLE,
      stream: _prPresenter.getPasswordRecoveryStream(),
      builder: (context, snapshot) {
        var state = snapshot.data;
        var inProgress = state == PasswordRecoveryState.IN_PROGRESS;
        return Stack(children: [
          Visibility(
            visible: !inProgress,
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onRecoveryPasswordClick(inProgress);
                },
                child: Text(
                  Strings.passwordRecoverySend.toUpperCase(),
                ),
              ),
            ),
          ),
          Visibility(
            visible: inProgress,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
          )
        ]);
      },
    );
  }

  void onRecoveryPasswordClick(bool inProgress) {
    if (inProgress) return;
    clearFocus();

    if (_formKey.currentState.validate()) {
      _prPresenter.recoveryPassword("email");
    }
  }

  Widget _buildEmailCorrectedImage(bool isEmailCorrected) {
    if (isEmailCorrected) {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Assets.textFormCorrected,
      );
    } else {
      return Container();
    }
  }

  void clearFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void onError(String errorMessage) {
    showMessageDialog(context, errorMessage);
  }

  @override
  void onSuccess(String message) {
    showMessageDialog(context, message);
  }
}
