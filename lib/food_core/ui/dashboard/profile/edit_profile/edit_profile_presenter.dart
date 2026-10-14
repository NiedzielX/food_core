import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/repositories/user_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/service/local.dart';
import 'package:food_core/food_core/ui/dashboard/profile/edit_profile/edit_profile_view.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_state.dart';
import 'package:food_core/food_core/utils/email_validator.dart';

abstract class EditProfilePresenter {
  set view(EditProfileView value) {}

  String getEmail();
  String getName();
  String getAvatar();

  void setAvatar(String path);

  void edit(String email, String name, StreamController<PasswordRecoveryState> streamController);

  StreamController<PasswordRecoveryState> getStream();
  StreamController<PasswordRecoveryState> getStreamUserName();
  StreamController<PasswordRecoveryState> getStreamAvatar();

  ValueNotifier<bool> getUserNameNotifier();

  ValueNotifier<bool> getEmailNotifier();

  void validateUserName(String name);

  void validateEmail(String email);

  void dispose();

  void updateAvatar(String file);
}

class BasicEditProfilePresenter implements EditProfilePresenter {

  StreamController<PasswordRecoveryState> _streamController =
  StreamController();

  StreamController<PasswordRecoveryState> _streamControllerUserName =
  StreamController();

  StreamController<PasswordRecoveryState> _streamControllerAvatar =
  StreamController();

  final ValueNotifier<bool> _userNameValueNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _emailValueNotifier = ValueNotifier(false);

  final UserRepository _repository = UserRepository();

  String email;
  String userName;
  String avatar;
  int id;

  EditProfileView _view;
  Local _local;

  BasicEditProfilePresenter() {
    this._local = Local();
    getData();
  }

  @override
  set view(EditProfileView value) {
    _view = value;
  }

  void getData() async {
    var user = await _local.getUser();
    this.email = user.email;
    this.userName = user.name;
    this.avatar = user.avatar;
    this.id = user.id;

    _view.setDataView();
  }

  @override
  void edit(String email, String name, StreamController<PasswordRecoveryState> streamController) async {
    try {
      streamController.add(PasswordRecoveryState.IN_PROGRESS);
      var response = await _repository.editProfile(this.id, email, name);
      streamController.add(PasswordRecoveryState.COMPLETED);
      _local.saveUser(response.user);
      _view.onSuccess(response.message);
    } catch (e) {
      handleError(e, streamController);
    }
  }

  @override
  String getEmail() {
    return email;
  }

  @override
  ValueNotifier<bool> getEmailNotifier() {
    return _emailValueNotifier;
  }

  @override
  String getName() {
    return userName;
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
  StreamController<PasswordRecoveryState> getStreamUserName() {
    return _streamControllerUserName;
  }

  @override
  StreamController<PasswordRecoveryState> getStreamAvatar() {
    return _streamControllerAvatar;
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
  void updateAvatar(String file) async {
    try {
      _streamControllerAvatar.add(PasswordRecoveryState.IN_PROGRESS);
      await _repository.updateAvatar(this.id, new File(file));
      _streamControllerAvatar.add(PasswordRecoveryState.COMPLETED);
    } catch (e) {
      handleError(e, _streamControllerAvatar);
    }
  }

  @override
  void dispose() {
    _streamControllerAvatar.close();
    _streamController.close();
    _streamControllerUserName.close();
    _repository.dispose();
  }

  void handleError(e, StreamController<PasswordRecoveryState> streamController) {
    if (_isDisposed()) return;
    var errorResponseModel = ErrorHandler.of(e);
    var responseData = errorResponseModel.responseData;
    if (responseData == null) {
      _view.onError(errorResponseModel.errorMessage);
    } else {
      _view.onError(ErrorResponseDataModel.fromJson(responseData).message);
    }
    streamController.add(PasswordRecoveryState.ERROR);
  }

  bool _isDisposed() => _streamController.isClosed;
}