import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/extensions/styled_text_field.dart';
import 'package:food_core/food_core/ui/base/base_state.dart';
import 'package:food_core/food_core/ui/dashboard/dashboard_component.dart';
import 'package:food_core/food_core/ui/dashboard/profile/switch_profile/switch_profile_component.dart';
import 'package:food_core/food_core/ui/interview/questions/interview_questions_component.dart';
import 'package:food_core/food_core/ui/login/login_presenter.dart';
import 'package:food_core/food_core/ui/login/login_view.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_component.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_state.dart';
import 'package:food_core/food_core/ui/register/register_component.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/email_validator.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/message_dialog.dart';
import 'package:food_core/food_core/utils/strings.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> implements LoginView {
  static const register_form_spacing =
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0);
  static const register_row_spacing =
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0);
  static const button_forget_password_padding =
      EdgeInsets.fromLTRB(0, 0, 0, 30);
  static const button_register_padding = EdgeInsets.fromLTRB(0, 20, 0, 10);
  static const form_row_spacing_padding = EdgeInsets.fromLTRB(0, 0, 0, 15);

  static const button_height = 50.0;

  LoginPresenter presenter;
  bool _load = false;

  TextEditingController _emailField = new TextEditingController();
  TextEditingController _passwordField = new TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

  _LoginPageState() {
    presenter = new BasicLoginPresenter();
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
                              child: Text(Strings.login,
                                  textAlign: TextAlign.left,
                                  style: GlobalUtils.darkHeadingText(context)))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                                  padding: register_row_spacing,
                                  child: AutoSizeText(
                                    Strings.loginDescription,
                                    textAlign: TextAlign.left,
                                    style: GlobalUtils.subHeadingText(context),
                                  ))),
                        ],
                      ),
                      Padding(padding: register_row_spacing),
                      loginForm(context)
                    ],
                  ),
                  inAsyncCall: _load,
                  opacity: 0.5,
                ))));
  }

  Container loginForm(BuildContext context) {
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
            Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: button_forget_password_padding,
                          child: forgetPasswordButton(context)))
                ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Expanded(child: loginButton(context))],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Expanded(child: registerButton(context))],
            )
          ],
        ),
      ),
    );
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

  Widget emailFormField(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          presenter.validateEmail(value);
        },
        controller: _emailField,
        focusNode: _emailFocus,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _emailFocus, _passwordFocus);
        },
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
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
              valueListenable: presenter.getEmailNotifier(),
              builder: (context, value, child) =>
                  _buildEmailCorrectedImage(value)))
    ]);
  }

  Widget passwordFormField(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: presenter.getPasswordTextObscureNotifier(),
      builder: (context, passwordVisible, child) => TextFormField(
        controller: _passwordField,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        obscureText: !passwordVisible,
        focusNode: _passwordFocus,
        onFieldSubmitted: (term) {
          _passwordFocus.unfocus();
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

  Widget loginButton(BuildContext context) {
    return StreamBuilder<PasswordRecoveryState>(
      initialData: PasswordRecoveryState.IDLE,
      stream: presenter.getStream(),
      builder: (context, snapshot) {
        var state = snapshot.data;
        var inProgress = state == PasswordRecoveryState.IN_PROGRESS;
        var isVisible = state == PasswordRecoveryState.IDLE ||
            state == PasswordRecoveryState.ERROR;
        return Stack(children: [
          Visibility(
            visible: isVisible,
            child: Container(
              width: double.infinity,
              child: SizedBox(
                  height: button_height,
                  child: ElevatedButton(
                    child: Text(Strings.loginBtn.toUpperCase()),
                    onPressed: () {
                      if (inProgress) return;
                      if (_formKey.currentState.validate()) {
                        presenter.onLogin(
                            _emailField.text, _passwordField.text);
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

  Widget forgetPasswordButton(BuildContext context) {
    return GestureDetector(
        child: Text(Strings.forgetPassword,
            textAlign: TextAlign.right,
            style: GlobalUtils.buttonLinkTextStyle(context)),
        onTap: () {
          presenter.onForgetPassword();
        });
  }

  Widget registerButton(BuildContext context) {
    return Padding(
        padding: button_register_padding,
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: GlobalUtils.buttonLinkTextStyle(context),
                children: [
                  TextSpan(
                    text: Strings.noAccount,
                  ),
                  TextSpan(
                      text: Strings.register,
                      style: GlobalUtils.buttonLinkRichTextStyle(context),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          presenter.onRegister();
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
            builder: (context) => DashboardPage(), fullscreenDialog: true));
  }

  @override
  void onForgetPassword() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PasswordRecoveryPage()));
  }

  @override
  void onRegister() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPage(), fullscreenDialog: true));
  }

  @override
  void onProfile() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SwitchProfilePage(true), fullscreenDialog: true));
  }

  @override
  void onInterview() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InterviewPage(interviewParameters: InterviewParameters(allowSkip: true)), fullscreenDialog: true)
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
