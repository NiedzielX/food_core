import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_core/food_core/model/error_response_data_model.dart';
import 'package:food_core/food_core/repositories/recovery_password_repository.dart';
import 'package:food_core/food_core/rest/error_handler.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_state.dart';
import 'package:food_core/food_core/ui/password_recovery/password_recovery_view.dart';
import 'package:food_core/food_core/utils/email_validator.dart';

abstract class PasswordRecoveryPresenter {
  Stream<PasswordRecoveryState> getPasswordRecoveryStream();

  setView(RecoverPasswordView recoverPasswordView);

  Future<void> recoveryPassword(String email);

  ValueNotifier<bool> getEmailNotifier();

  void validateEmail(String email);

  void dispose();
}

class BasePasswordRecoveryPresenter extends PasswordRecoveryPresenter {
  StreamController<PasswordRecoveryState> _streamController =
      StreamController();

  final RecoveryPasswordRepository _rpRepository = RecoveryPasswordRepository();

  final ValueNotifier<bool> _emailValueNotifier = ValueNotifier(false);

  RecoverPasswordView _recoverPasswordView;

  @override
  Stream<PasswordRecoveryState> getPasswordRecoveryStream() {
    return _streamController.stream;
  }

  @override
  Future<void> recoveryPassword(String email) async {
    try {
      _streamController.add(PasswordRecoveryState.IN_PROGRESS);
      var response = await _rpRepository.recoveryPassword(email);
      _streamController.add(PasswordRecoveryState.COMPLETED);
      _recoverPasswordView.onSuccess(response.message);
    } catch (e) {
      handleError(e);
    }
  }

  @override
  setView(RecoverPasswordView recoverPasswordView) {
    this._recoverPasswordView = recoverPasswordView;
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
  void dispose() {
    _streamController.close();
    _rpRepository.dispose();
  }

  void handleError(e) {
    if (_isDisposed()) return;
    var errorResponseModel = ErrorHandler.of(e);
    var responseData = errorResponseModel.responseData;
    if (responseData == null) {
      _recoverPasswordView.onError(errorResponseModel.errorMessage);
    } else {
      _recoverPasswordView
          .onError(ErrorResponseDataModel.fromJson(responseData).message);
    }
    _streamController.add(PasswordRecoveryState.ERROR);
  }

  bool _isDisposed() => _streamController.isClosed;
}
