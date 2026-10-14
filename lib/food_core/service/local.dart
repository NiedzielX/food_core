import 'dart:async';
import 'dart:convert';

import 'package:food_core/food_core/extensions/enum_to_string.dart';
import 'package:food_core/food_core/model/user.dart';
import 'package:food_core/food_core/model/user_status.dart';
import 'package:food_core/food_core/utils/constants.dart';
import 'package:food_core/food_core/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Local {

  static const String LANG_KEY = "lang[]";
  static const String TOKEN = "token";
  static const String USER = "user";
  static const String API_CONFIG = "api_config";
  static const String NOTIFICATION = "notification";
  static const String ARTICLE_LANGUAGE = "article_language";
  static const String USER_STATUS = "user_status";
  static const String NOTIFICATION_PERMISSION = "notificationperm";
  static const String PROFILE_SKIPPED = "PROFILE_SKIPPED";
  static const String INTERVIEW_SKIPPED = "INTERVIEW_SKIPPED";

  void saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(TOKEN, token);
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String data = preferences.getString(TOKEN);
    if (data != null) {
      return data;
    } else {
      return "";
    }
  }

  Future<User> saveUser(User user) async {
    try {
      String json = jsonEncode(user);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(USER, json);
    } catch (error) {
      print(user);
    }
    return user;
  }

  Future<User> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String data = preferences.getString(USER);
    Map<String, dynamic> t = jsonDecode(data);
    if (data != null) {
      return User.fromJson(t);
    } else {
      return null;
    }
  }

  saveApiConfig(Map<String, dynamic> parsedJson) async {
    try {
      String json = jsonEncode(parsedJson);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(API_CONFIG, json);
    } catch (error) {
      print(parsedJson);
    }
  }

  void setNotification(bool enabled) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(NOTIFICATION, enabled);
  }

  Future<bool> getNotification() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool data = preferences.getBool(NOTIFICATION);
    if (data != null) {
      return data;
    } else {
      return true;
    }
  }

  void setSkippedProfile(bool enabled) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(PROFILE_SKIPPED, enabled);
  }

  Future<bool> getSkippedProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool data = preferences.getBool(PROFILE_SKIPPED);
    if (data != null) {
      return data;
    } else {
      return false;
    }
  }

  void setSkippedInterview(bool enabled) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(INTERVIEW_SKIPPED, enabled);
  }

  Future<bool> getSkippedInterview() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool data = preferences.getBool(INTERVIEW_SKIPPED);
    if (data != null) {
      return data;
    } else {
      return false;
    }
  }

  void setNotificationIOS(bool enabled) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(NOTIFICATION_PERMISSION, enabled);
  }

  Future<bool> getNotificationIOS() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool data = preferences.getBool(NOTIFICATION_PERMISSION);
    if (data != null) {
      return data;
    } else {
      return false;
    }
  }

  void setArticleLanguage(List<String> selected) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList(ARTICLE_LANGUAGE, selected);
  }

  Future<List<String>> getArticleLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> data = preferences.getStringList(ARTICLE_LANGUAGE);
    if (data != null) {
      return data;
    } else {
      List<String> lang = [];
      getPreferencesLanguage().forEach((key, _) {
        lang.add(key);
      });
      return lang;
    }
  }

  Future<Map<String, dynamic>> getLanguages() async {
    var languages = await getArticleLanguage();
    Map<String, dynamic> params = Map();
    params[LANG_KEY] = languages.map((lang)=> lang.toString());
    return params;
  }

  Future<UserStatus> saveUserStatus(UserStatus status) async {
    try {
      String json = jsonEncode(status);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(USER_STATUS, json);
    } catch (error) {
      print(error);
    }
    return status;
  }

  Future<UserStatus> getUserStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String data = preferences.getString(USER_STATUS);
    if (data != null) {
      Map<String, dynamic> t = jsonDecode(data);
      return UserStatus.fromJson(t);
    } else {
      var userStatus = UserStatus(type: UserStatusType.none, date: DateTime.now());
      return  userStatus;
    }
  }

  Map<String, String> getPreferencesLanguage() {
    Map<String, String> result = Map();
    result[EnumToString.parse(LanguageKeys.pl)]= Strings.polish;
    return result;
  }
}