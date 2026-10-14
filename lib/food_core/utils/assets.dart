import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';

class Assets {
  // Default
  static AssetImage cba = AssetImage('images/cba.png');
  static Image logoSplash =
      Image.asset('assets/images/splash.png', fit: BoxFit.fill);
  static Image logo =
      Image.asset('assets/images/logo.png', width: 180, height: 50);
  static Image home =
      Image.asset('assets/images/home.png', width: 24, height: 24);
  static Image notification =
      Image.asset('assets/images/notification.png', width: 24, height: 24);
  static Image scan =
      Image.asset('assets/images/scan.png', width: 24, height: 24);
  static Image profile =
      Image.asset('assets/images/profile.png', width: 24, height: 24);
  static Image favorite =
      Image.asset('assets/images/favorite.png', width: 24, height: 24);
  static Image upload =
      Image.asset('assets/images/upload.png', width: 18, height: 18);
  static Image backArrow =
      Image.asset('assets/images/arrow.png', width: 10, height: 18);
  static Image like =
      Image.asset('assets/images/like.png', width: 24, height: 24);
  static Image unLike =
      Image.asset('assets/images/un_like.png', width: 24, height: 24);
  static Image productIngredientsInfo =
      Image.asset('assets/images/ingredients_info.png', width: 10, height: 10);
  static Image whiteBackArrow =
      Image.asset('assets/images/white_arrow.png', width: 10, height: 18);
  static Image cancelIcon =
      Image.asset('assets/images/cancel_icon.png', width: 14, height: 14);

  /*onboarding*/
  static const String _onboardingAssets = 'assets/images/onboarding';

  static Image onboardingFirstPage =
      Image.asset('$_onboardingAssets/onboarding_page_01.png');
  static Image onboardingSecondPage =
      Image.asset('$_onboardingAssets/onboarding_page_02.png');
  static Image onboardingThirdPage =
      Image.asset('$_onboardingAssets/onboarding_page_03.png');

  static Image textFormCorrected = Image.asset(
      'assets/images/text_form_corrected.png',
      width: 24,
      height: 24);

  static Image homeActive = Image.asset('assets/images/home.png',
      width: 24, height: 24, color: MyColors.skyBlue);
  static Image scanActive = Image.asset('assets/images/scan.png',
      width: 24, height: 24, color: MyColors.skyBlue);
  static Image profileActive = Image.asset('assets/images/profile.png',
      width: 24, height: 24, color: MyColors.skyBlue);
  static Image favoriteActive = Image.asset('assets/images/favorite.png',
      width: 24, height: 24, color: MyColors.skyBlue);

  // Home
  static Image pizza = Image.asset('assets/images/pizza.png',
      color: MyColors.darkGrey, width: 36, height: 36);
  static Image lunch = Image.asset('assets/images/lunch.png',
      color: MyColors.darkGrey, width: 35, height: 24);
  static Image croissant = Image.asset('assets/images/croissant.png',
      color: MyColors.darkGrey, width: 35, height: 34);
  static Image iceCream = Image.asset('assets/images/icecream.png',
      color: MyColors.darkGrey, width: 20, height: 35);

  static Image banana = Image.asset('assets/images/mock/banana.png');
  static Image apple = Image.asset('assets/images/mock/apple.png');
  static Image imbir = Image.asset('assets/images/mock/imbir.png');

  static Image warning =
      Image.asset('assets/images/warning.png', width: 24, height: 24);
  static Image search =
      Image.asset('assets/images/search.png', width: 14, height: 14);

  // Profile

  static Image food =
      Image.asset('assets/images/food.png', width: 24, height: 24);
  static Image preferences =
      Image.asset('assets/images/preferences.png', width: 24, height: 24);
  static Image history =
      Image.asset('assets/images/history.png', width: 24, height: 24);
  static Image premium =
      Image.asset('assets/images/premium.png', width: 24, height: 24);
  static Image contact =
      Image.asset('assets/images/contact.png', width: 24, height: 24);
  static Image profileChange =
      Image.asset('assets/images/changeprofile.png', width: 24, height: 24);
  static Image logout =
      Image.asset('assets/images/logout.png', width: 24, height: 24);
  static Image arrow =
      Image.asset('assets/images/arrow.png', width: 9, height: 14);
  static Image edit =
      Image.asset('assets/images/pencil.png', width: 18, height: 18);
  static Image editDark = Image.asset('assets/images/pencil.png',
      width: 18, height: 18, color: MyColors.color03);
  static Image camera =
      Image.asset('assets/images/camera.png', width: 40, height: 40);
  static Image switchBlank =
      Image.asset('assets/images/userSwitch.png', width: 34, height: 34);
  static Image addButton =
      Image.asset('assets/images/addUser.png', width: 16, height: 16);
  static Image recycleBin =
      Image.asset('assets/images/recycle_bin.png', width: 30, height: 30);

  /*interview summary*/
  static const String _interviewAssets = 'assets/images/interview';

  static Image interviewSummaryImage =
      Image.asset('$_interviewAssets/interview_summary_image.png');
}
