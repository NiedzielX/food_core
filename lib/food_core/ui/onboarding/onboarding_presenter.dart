import 'package:flutter/material.dart';
import 'package:food_core/food_core/model/onboarding_model.dart';
import 'package:food_core/food_core/repositories/onboarding_repository.dart';
import 'package:food_core/food_core/service/local.dart';
import 'package:food_core/food_core/ui/onboarding/onboarding_view.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/strings.dart';
import 'package:logger/logger.dart';

abstract class OnboardingPresenter {
  set view(OnboardingView value);

  List<OnboardingModel> getOnboardingPageList();

  PageController getPageController();

  Future<void> skipOnboarding();

  void setNextPage();

  void setPage(int page);

  int getCurrentPage();

  int getPageCount();
}

class BasicOnboardingPresenter implements OnboardingPresenter {
  final OnboardingRepository _onboardingRepository = OnboardingRepository();
  final PageController _pageController = PageController();
  final Logger _logger = Logger();
  final Local _local = Local();

  int _currentPage = 0;

  OnboardingView _view;

  final List<OnboardingModel> onboardingPageList = [
    OnboardingModel(
        image: Assets.onboardingFirstPage,
        title: Strings.onboardingTitleFirstPage,
        description: Strings.onboardingDescFirstPage),
    OnboardingModel(
        image: Assets.onboardingSecondPage,
        title: Strings.onboardingTitleSecondPage,
        description: Strings.onboardingDescSecondPage),
    OnboardingModel(
        image: Assets.onboardingThirdPage,
        title: Strings.onboardingTitleThirdPage,
        description: Strings.onboardingDescThirdPage),
  ];

  BasicOnboardingPresenter() {
    _pageController.addListener(() {
      _currentPage = _pageController.page.round();
      _view.onPageChange();
    });
  }

  @override
  set view(OnboardingView value) {
    _view = value;
  }

  @override
  void setPage(int page) {
    _pageController.animateToPage(page,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  PageController getPageController() {
    return _pageController;
  }

  @override
  List<OnboardingModel> getOnboardingPageList() {
    return onboardingPageList;
  }

  @override
  int getCurrentPage() {
    return _currentPage;
  }

  @override
  Future<void> skipOnboarding() async {
    await disableOnboarding();

    _local.getUserStatus().then((result) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!result.checkDate()) {
          _view.goToDashboard();
        } else {
          _view.goToLogin();
        }
      });
    });

    _logger.i("Skip onboarding");
  }

  Future<void> disableOnboarding() async {
    await _onboardingRepository.disableOnboarding();
  }

  @override
  void setNextPage() {
    int pageCount = getPageCount();
    if (getCurrentPage() != pageCount - 1) {
      _pageController.animateToPage(_pageController.page.toInt() + 1,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      skipOnboarding();
    }
  }

  @override
  int getPageCount() {
    return onboardingPageList.length;
  }
}
