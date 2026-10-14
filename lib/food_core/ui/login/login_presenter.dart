import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/repositories/login_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/service/local.dart';
import 'package:food_core/food_core/ui/login/login_view.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_state.dart';
import 'package:food_core/food_core/utils/email_validator.dart';

abstract class LoginPresenter {
  Stream<PasswordRecoveryState> getStream();
  set view(LoginView value);

  void onLogin(String email, String password);
  void onForgetPassword();
  void onRegister();

  ValueNotifier<bool> getEmailNotifier();
  ValueNotifier<bool> getPasswordNotifier();
  ValueNotifier<bool> getPasswordTextObscureNotifier();

  void togglePasswordTextObscure();
  void validateEmail(String email);
  void validatePassword(String password);

  void dispose();
}

class BasicLoginPresenter implements LoginPresenter {
  StreamController<PasswordRecoveryState> _streamController =
  StreamController();

  final LoginRepository _repository = LoginRepository();

  final ValueNotifier<bool> _emailValueNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _passwordValueNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _pTextObscureNotifier = ValueNotifier(false);

  LoginView _view;

  Local local = Local();

  @override
  Stream<PasswordRecoveryState> getStream() {
    return _streamController.stream;
  }

  @override
  set view(LoginView value) {
    _view = value;
  }

  @override
  void onLogin(String email, String password) async {
    try {
      _streamController.add(PasswordRecoveryState.IN_PROGRESS);
      var response = await _repository.login(email, password);
      local.saveToken(response.token);
      getUserDetails(response.token);
    } catch (e) {
      handleError(e);
    }
  }

  void getUserDetails(String token) async {
    try {
      var response = await _repository.me(token);
      local.saveUser(response.user);
      var skipped = await local.getSkippedProfile();
      if (!skipped) {
        _view.onProfile();
        return;
      }
      var skippedInterview = await local.getSkippedInterview();
      if (!skippedInterview) {
        _view.onInterview();
        return;
      }
      _streamController.add(PasswordRecoveryState.COMPLETED);
      _view.onLogin();
    } catch (e) {
      handleError(e);
    }
  }

  @override
  void onForgetPassword() async {
    _view.onForgetPassword();
  }

  @override
  void onRegister() async {
    _view.onRegister();
  }

  @override
  ValueNotifier<bool> getEmailNotifier() {
    return _emailValueNotifier;
  }

  @override
  ValueNotifier<bool> getPasswordNotifier() {
    return _passwordValueNotifier;
  }

  @override
  ValueNotifier<bool> getPasswordTextObscureNotifier() {
    return _pTextObscureNotifier;
  }

  @override
  void togglePasswordTextObscure() {
    _pTextObscureNotifier.value = !_pTextObscureNotifier.value;
  }

  @override
  void validateEmail(String email) {
    _emailValueNotifier.value = EmailValidator.isValid(email);
  }

  @override
  void validatePassword(String password) {
    _passwordValueNotifier.value = password.isNotEmpty;
  }

  @override
  void dispose() {
    _streamController.close();
    _repository.dispose();
  }

  void handleError(e) {
    if (_isDisposed()) return;
    var errorResponseModel = ErrorHandler.of(e);
    var responseData = errorResponseModel.responseData;
    if (responseData == null) {
      _view.onError(errorResponseModel.errorMessage);
    } else {
      _view.onError(ErrorResponseDataModel.fromJson(responseData).message);
    }
    _streamController.add(PasswordRecoveryState.ERROR);
  }

  bool _isDisposed() => _streamController.isClosed;

}