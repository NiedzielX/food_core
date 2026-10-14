import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/repositories/user_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/ui/dashboard/profile/add_profile/add_profile_view.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_state.dart';
import 'package:food_core/food_core/utils/email_validator.dart';

abstract class AddProfilePresenter {
  set view(AddProfileView value) {}

  String getAvatar();

  void setAvatar(String path);

  void add(String email, String name);

  StreamController<PasswordRecoveryState> getStream();

  ValueNotifier<bool> getUserNameNotifier();

  ValueNotifier<bool> getEmailNotifier();

  void validateUserName(String name);

  void validateEmail(String email);

  void dispose();
}

class BasicAddProfilePresenter implements AddProfilePresenter {

  StreamController<PasswordRecoveryState> _streamController =
  StreamController();

  final ValueNotifier<bool> _userNameValueNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _emailValueNotifier = ValueNotifier(false);

  final UserRepository _repository = UserRepository();

  String avatar;

  AddProfileView _view;

  BasicAddProfilePresenter();

  @override
  set view(AddProfileView value) {
    _view = value;
  }

  @override
  void add(String email, String name) async {
    try {
      _streamController.add(PasswordRecoveryState.IN_PROGRESS);
      var response = await _repository.addProfile(email, name, avatar: avatar != null ? new File(getAvatar()) : null);
      _streamController.add(PasswordRecoveryState.COMPLETED);
      _view.onSuccess(response.message);
    } catch (e) {
      handleError(e);
    }
  }

  @override
  ValueNotifier<bool> getEmailNotifier() {
    return _emailValueNotifier;
  }

  @override
  String getAvatar() {
    return avatar;
  }

  @override
  void setAvatar(String path) {
    this.avatar = path;
  }

  @override
  StreamController<PasswordRecoveryState> getStream() {
    return _streamController;
  }

  @override
  ValueNotifier<bool> getUserNameNotifier() {
    return _userNameValueNotifier;
  }

  @override
  void validateEmail(String email) {
    _emailValueNotifier.value = EmailValidator.isValid(email);
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