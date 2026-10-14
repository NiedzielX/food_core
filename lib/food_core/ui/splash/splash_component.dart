import 'package:flutter/material.dart';
import 'package:food_core/food_core/ui/login/login_component.dart';
import 'package:food_core/food_core/ui/onboarding/onboarding_component.dart';
import 'package:food_core/food_core/ui/splash/splash_presenter.dart';
import 'package:food_core/food_core/ui/splash/splash_view.dart';
import 'package:food_core/food_core/utils/assets.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> implements SplashView {
  SplashPresenter presenter;

  _SplashPageState() {
    presenter = new BasicSplashPresenter();
  }

  @override
  void initState() {
    super.initState();
    presenter.view = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Assets.logoSplash),
        ));
  }

  @override
  void goToDashboard() {
    /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DashboardPage(), fullscreenDialog: true));*/
  }

  @override
  void goToLogin() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  @override
  void goToOnboarding() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => OnboardingPage(), fullscreenDialog: true));
  }
}
