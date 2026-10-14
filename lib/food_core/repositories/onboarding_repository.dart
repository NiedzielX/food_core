import 'package:shared_preferences/shared_preferences.dart';

class OnboardingRepository {
  static const ONBOARDING_KEY = "onboarding_key";

  Future<bool> isOnboardingEnabled() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(ONBOARDING_KEY) ?? true;
  }

  Future<void> disableOnboarding() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(ONBOARDING_KEY, false);
  }
}
