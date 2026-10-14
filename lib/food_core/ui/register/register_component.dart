import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/extensions/styled_text_field.dart';
import 'package:food_core/food_core/ui/base/base_state.dart';
import 'package:food_core/food_core/ui/dashboard/profile/switch_profile/switch_profile_component.dart';
import 'package:food_core/food_core/ui/login/login_component.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_state.dart';
import 'package:food_core/food_core/ui/register/register_presenter.dart';
import 'package:food_core/food_core/ui/register/register_view.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/email_validator.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/message_dialog.dart';
import 'package:food_core/food_core/utils/strings.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage>
    implements RegisterView {
  static const register_form_spacing =
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0);
  static const register_row_spacing =
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0);
  static const button_forget_password_padding =
      EdgeInsets.fromLTRB(0, 0, 0, 30);
  static const button_register_padding = EdgeInsets.fromLTRB(0, 20, 0, 10);
  static const form_row_spacing_padding = EdgeInsets.fromLTRB(0, 0, 0, 15);

  static const button_height = 50.0;

  RegisterPresenter presenter;
  bool _load = false;

  TextEditingController _emailField = new TextEditingController();
  TextEditingController _nameField = new TextEditingController();
  TextEditingController _passwordField = new TextEditingController();
  TextEditingController _repeatPasswordField = new TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _repeatPasswordFocus = FocusNode();

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

  _RegisterPageState() {
    presenter = new BasicRegisterPresenter();
    presenter.view = this;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          elevation: 0,
        ),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.topCenter,
                child: ModalProgressHUD(
                  color: MyColors.darkGrey,
                  child: ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: register_row_spacing, child: Assets.logo)
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: register_row_spacing,
                              child: Text(Strings.registerTitle,
                                  textAlign: TextAlign.left,
                                  style: GlobalUtils.darkHeadingText(context)))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: register_row_spacing,
                                child: AutoSizeText(Strings.registerDescription,
                                    textAlign: TextAlign.left,
                                    style:
                                        GlobalUtils.subHeadingText(context))),
                          )
                        ],
                      ),
                      Padding(padding: register_row_spacing),
                      registerForm(context)
                    ],
                  ),
                  inAsyncCall: _load,
                  opacity: 0.5,
                ))));
  }

  Container registerForm(BuildContext context) {
    return Container(
      margin: register_form_spacing,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Text(Strings.email,
                  textAlign: TextAlign.left,
                  style: GlobalUtils.textFieldStyle(context)),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: form_row_spacing_padding,
                        child: emailFormField(context)))
              ],
            ),
            Row(children: <Widget>[
              Text(Strings.nameSurname,
                  textAlign: TextAlign.left,
                  style: GlobalUtils.textFieldStyle(context)),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: form_row_spacing_padding,
                        child: nameFormField(context)))
              ],
            ),
            Row(children: <Widget>[
              Text(Strings.password,
                  textAlign: TextAlign.left,
                  style: GlobalUtils.textFieldStyle(context)),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: form_row_spacing_padding,
                        child: passwordFormField(context)))
              ],
            ),
            Row(children: <Widget>[
              Text(Strings.passwordRepeat,
                  textAlign: TextAlign.left,
                  style: GlobalUtils.textFieldStyle(context)),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: form_row_spacing_padding,
                        child: repeatPasswordFormField(context)))
              ],
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: button_forget_password_padding,
                          child: termsDescriptionButton(context)))
                ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Expanded(child: registerButton(context))],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Expanded(child: loginButton(context))],
            )
          ],
        ),
      ),
    );
  }

  Widget emailFormField(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          presenter.validateEmail(value);
        },
        controller: _emailField,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        focusNode: _emailFocus,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _emailFocus, _nameFocus);
        },
        validator: (value) {
          if ((value == null || value.isEmpty)) {
            return (Strings.required);
          }
          if (!EmailValidator.isValid(value)) {
            return (Strings.incorrectEmail);
          }
          return null;
        },
        decoration: StyledTextField.styled(Strings.emailHint),
      ),
      Positioned(
          top: 17,
          child: ValueListenableBuilder<bool>(
              valueListenable: presenter.getEmailNotifier(),
              builder: (context, value, child) =>
                  _buildTextFormValidImage(value)))
    ]);
  }

  Widget _buildTextFormValidImage(bool isVisible) {
    if (isVisible) {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Assets.textFormCorrected,
      );
    } else {
      return Container();
    }
  }

  Widget nameFormField(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          presenter.validateUserName(value);
        },
        controller: _nameField,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        focusNode: _nameFocus,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _nameFocus, _passwordFocus);
        },
        validator: (value) {
          if ((value == null || value.isEmpty)) {
            return (Strings.required);
          }
          return null;
        },
        decoration: StyledTextField.styled(Strings.nameSurnameHint),
      ),
      Positioned(
          top: 17,
          child: ValueListenableBuilder<bool>(
              valueListenable: presenter.getUserNameNotifier(),
              builder: (context, value, child) =>
                  _buildTextFormValidImage(value)))
    ]);
  }

  Widget passwordFormField(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: presenter.getPasswordTextObscureNotifier(),
      builder: (context, passwordVisible, child) => TextFormField(
        controller: _passwordField,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        obscureText: !passwordVisible,
        focusNode: _passwordFocus,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _passwordFocus, _repeatPasswordFocus);
        },
        validator: (value) {
          if ((value == null || value.isEmpty)) {
            return (Strings.required);
          }
          return null;
        },
        decoration: StyledTextField.styled(Strings.passwordHint).copyWith(
          suffixIcon: _buildPasswordTextObscureImage(passwordVisible),
        ),
      ),
    );
  }

  _buildPasswordTextObscureImage(passwordVisible) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Icon(
        passwordVisible ? Icons.visibility : Icons.visibility_off,
        color: MyColors.lighterGrey,
      ),
      onPressed: () {
        presenter.togglePasswordTextObscure();
      },
    );
  }

  Widget repeatPasswordFormField(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: presenter.getPasswordRepeatTextObscureNotifier(),
      builder: (context, passwordVisible, child) => TextFormField(
        controller: _repeatPasswordField,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        focusNode: _repeatPasswordFocus,
        obscureText: !passwordVisible,
        onFieldSubmitted: (term) {
          _emailFocus.unfocus();
        },
        validator: (value) {
          if ((value == null || value.isEmpty)) {
            return (Strings.required);
          }
          return null;
        },
        decoration: StyledTextField.styled(Strings.passwordRepeatHint).copyWith(
          suffixIcon: _buildPasswordRepeatTextObscureImage(passwordVisible),
        ),
      ),
    );
  }

  _buildPasswordRepeatTextObscureImage(passwordVisible) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Icon(
        passwordVisible ? Icons.visibility : Icons.visibility_off,
        color: MyColors.lighterGrey,
      ),
      onPressed: () {
        presenter.togglePasswordRepeatTextObscure();
      },
    );
  }

  Widget registerButton(BuildContext context) {
    return StreamBuilder<PasswordRecoveryState>(
      initialData: PasswordRecoveryState.IDLE,
      stream: presenter.getStream(),
      builder: (context, snapshot) {
        var state = snapshot.data;
        var inProgress = state == PasswordRecoveryState.IN_PROGRESS;
        return Stack(children: [
          Visibility(
            visible: !inProgress,
            child: Container(
              width: double.infinity,
              child: SizedBox(
                  height: button_height,
                  child: ElevatedButton(
                    child: Text(Strings.register.toUpperCase()),
                    onPressed: () {
                      if (inProgress) return;
                      if (_formKey.currentState.validate()) {
                        presenter.onRegister(_emailField.text,
                            _passwordField.text, _nameField.text);
                        FocusScope.of(context).requestFocus(new FocusNode());
                      }
                    },
                  )),
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

  Widget termsDescriptionButton(BuildContext context) {
    return RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            text: Strings.termsDescription,
            style: GlobalUtils.buttonLinkTextStyle(context),
            children: [
              TextSpan(
                  text: Strings.termsOfUse,
                  style: GlobalUtils.buttonLinkRichTextStyle(context),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      //TODO: hyperlink to terms of use
                    }),
              TextSpan(
                text: Strings.and,
              ),
              TextSpan(
                  text: Strings.privacyPolicy,
                  style: GlobalUtils.buttonLinkRichTextStyle(context),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      //TODO: hyperlink to terms of use
                    }),
            ]));
  }

  Widget loginButton(BuildContext context) {
    return Padding(
        padding: button_register_padding,
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: GlobalUtils.buttonLinkTextStyle(context),
                children: [
                  TextSpan(
                    text: Strings.accountGet,
                  ),
                  TextSpan(
                      text: Strings.loginBtn,
                      style: GlobalUtils.buttonLinkRichTextStyle(context),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          presenter.onLogin();
                        }),
                ])));
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void onLogin() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  @override
  void onRegister() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (context) => SwitchProfilePage(true), fullscreenDialog: true)
    );
  }

  @override
  void setDataView() {
    setState(() {});
  }

  @override
  void onError(String errorMessage) {
    showMessageDialog(context, errorMessage);
  }
}
