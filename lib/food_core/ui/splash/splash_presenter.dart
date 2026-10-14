import 'dart:async';

import 'package:food_core/food_core/repositories/onboarding_repository.dart';
import 'package:food_core/food_core/service/local.dart';
import 'package:food_core/food_core/ui/splash/splash_view.dart';

abstract class SplashPresenter {
  set view(SplashView value) {}

  Future<bool> isOnboardingEnabled();
}

class BasicSplashPresenter implements SplashPresenter {
  final OnboardingRepository _onboardingRepository = OnboardingRepository();

  SplashView _view;
  Local _local;

  BasicSplashPresenter() {
    this._local = Local();
  }

  @override
  set view(SplashView value) {
    _view = value;
    setTimer();
  }

  void setTimer() async {
    bool onboardingEnabled = await isOnboardingEnabled();
    _local.getUserStatus().then((result) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (onboardingEnabled) {
          _view.goToOnboarding();
          return;
        }

        if (!result.checkDate()) {
          _view.goToDashboard();
        } else {
          _view.goToLogin();
        }
      });
    });
  }

  @override
  Future<bool> isOnboardingEnabled() async {
    return _onboardingRepository.isOnboardingEnabled();
  }
}
