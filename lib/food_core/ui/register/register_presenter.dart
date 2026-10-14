import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/repositories/login_repository.dart';
import 'package:food_core/food_core/repositories/register_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/service/local.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_state.dart';
import 'package:food_core/food_core/ui/register/register_view.dart';
import 'package:food_core/food_core/utils/email_validator.dart';

abstract class RegisterPresenter {

  Stream<PasswordRecoveryState> getStream();

  ValueNotifier<bool> getPasswordRepeatTextObscureNotifier();

  ValueNotifier<bool> getPasswordTextObscureNotifier();

  ValueNotifier<bool> getUserNameNotifier();

  ValueNotifier<bool> getEmailNotifier();

  void validateUserName(String name);

  void validateEmail(String email);

  void togglePasswordRepeatTextObscure();

  void togglePasswordTextObscure();

  set view(RegisterView value) {}

  void onLogin() {}

  void onRegister(String email, String password, String name) {}

  void dispose() {}
}

class BasicRegisterPresenter implements RegisterPresenter {

  StreamController<PasswordRecoveryState> _streamController =
  StreamController();

  final ValueNotifier<bool> _pRepeatTextObscureNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _pTextObscureNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _userNameValueNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _emailValueNotifier = ValueNotifier(false);

  final RegisterRepository _repository = RegisterRepository();
  final LoginRepository _loginRepository = LoginRepository();

  RegisterView _view;

  Local _local;

  BasicRegisterPresenter() {
    this._local = Local();
  }

  @override
  set view(RegisterView value) {
    _view = value;
  }

  @override
  Stream<PasswordRecoveryState> getStream() {
    return _streamController.stream;
  }

  @override
  void onLogin() async {
    _view.onLogin();
  }

  @override
  void onRegister(String email, String password, String name) async {
    try {
      _streamController.add(PasswordRecoveryState.IN_PROGRESS);
      var response = await _repository.register(email, password, name);
      _local.saveToken(response.token);
      getUserDetails(response.token);
    } catch (e) {
      handleError(e);
    }
  }

  void getUserDetails(String token) async {
    try {
      var response = await _loginRepository.me(token);
      _local.saveUser(response.user);
      _local.setSkippedProfile(false);
      _local.setSkippedInterview(false);
      _streamController.add(PasswordRecoveryState.COMPLETED);
      _view.onRegister();
    } catch (e) {
      handleError(e);
    }
  }

  @override
  ValueNotifier<bool> getEmailNotifier() {
    return _emailValueNotifier;
  }

  @override
  void validateEmail(String email) {
    _emailValueNotifier.value = EmailValidator.isValid(email);
  }

  @override
  ValueNotifier<bool> getUserNameNotifier() {
    return _userNameValueNotifier;
  }

  @override
  void validateUserName(String name) {
    try {
      _userNameValueNotifier.value = (name != null && name.isNotEmpty);
    } catch (e) {
      _userNameValueNotifier.value = false;
    }
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
  ValueNotifier<bool> getPasswordRepeatTextObscureNotifier() {
    return _pRepeatTextObscureNotifier;
  }

  @override
  void togglePasswordRepeatTextObscure() {
    _pRepeatTextObscureNotifier.value = !_pRepeatTextObscureNotifier.value;
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
