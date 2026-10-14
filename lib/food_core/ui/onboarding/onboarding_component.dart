import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_core/food_core/model/onboarding_model.dart';
import 'package:food_core/food_core/ui/login/login_component.dart';
import 'package:food_core/food_core/ui/onboarding/onboarding_presenter.dart';
import 'package:food_core/food_core/ui/onboarding/onboarding_view.dart';
import 'package:food_core/food_core/utils/constants.dart';
import 'package:food_core/food_core/utils/global.dart';
import 'package:food_core/food_core/utils/strings.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    implements OnboardingView {
  final OnboardingPresenter _onboardingPresenter = BasicOnboardingPresenter();

  @override
  void initState() {
    super.initState();
    _onboardingPresenter.view = this;
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
      body: Column(
        children: [
          _skipButton(),
          pageView(),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  pageIndicator(),
                  SizedBox(height: 40),
                  nextPageButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _skipButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              style: GlobalUtils.textButtonStyle(),
              onPressed: () {
                _onboardingPresenter.skipOnboarding();
              },
              child: Text(
                Strings.onboardingSkip,
              )),
        ],
      ),
    );
  }

  Row pageIndicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _createPageIndicator());
  }

  Expanded pageView() {
    return Expanded(
      flex: 2,
      child: PageView(
        controller: _onboardingPresenter.getPageController(),
        scrollDirection: Axis.horizontal,
        children: _onboardingPresenter
            .getOnboardingPageList()
            .map((onboardingModel) => _OnboardingPageFragment(onboardingModel))
            .toList(),
      ),
    );
  }

  Widget nextPageButton() {
    return ElevatedButton(
      onPressed: () {
        _onboardingPresenter.setNextPage();
      },
      child: Text(
        Strings.onboardingNext.toUpperCase(),
      ),
    );
  }

  Widget _pageIndicator(int page) {
    bool isCurrent = page == _onboardingPresenter.getCurrentPage();
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => _onboardingPresenter.setPage(page),
      child: Container(
        height: 10,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCurrent ? Constants.buttonColor : Colors.grey[200],
          ),
        ),
      ),
    );
  }

  List<Widget> _createPageIndicator() {
    int pageCount = _onboardingPresenter.getPageCount();
    List<Widget> pageIndicators = [];
    for (int page = 0; page < pageCount; page++) {
      pageIndicators.add(_pageIndicator(page));
    }
    return pageIndicators;
  }

  @override
  onPageChange() {
    setState(() {});
  }

  @override
  goToDashboard() {}

  @override
  goToLogin() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: true));
  }
}

class _OnboardingPageFragment extends StatelessWidget {
  final OnboardingModel _onboardingModel;

  _OnboardingPageFragment(this._onboardingModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Expanded(
              child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: _onboardingModel.image)),
          SizedBox(height: 25),
          Text(_onboardingModel.title,
              style: GlobalUtils.darkHeadingText(context, 19),
              textAlign: TextAlign.center),
          SizedBox(height: 25),
          Text(_onboardingModel.description,
              style: GlobalUtils.subHeadingText(context, 13),
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
