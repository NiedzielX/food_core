import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:food_core/food_core/service/asset_loader.dart';

extension StringTranslateExtension on String {
  /// {@macro tr}
  String tr(
      {List<String> args}) =>
      AppLocalizations.tr(this, args: args);
}

class AppLocalizations {

  AppLocalizations();

  Locale locale;

  final RegExp _replaceArgRegex = RegExp(r'{}');

  static var supportedLocales = [Locale('pl')];
  static var defaultLocale = Locale('pl');

  var path = 'assets/translations';
  var assetLoader = RootBundleAssetLoader();

  static AppLocalizations _instance;
  static AppLocalizations get instance => _instance ?? (_instance = AppLocalizations());

  Map<String, String> _translations = {};

  Locale _getLocale() {
    if(locale == null) {
      locale = defaultLocale;
      return locale;
    }
    if (supportedLocales.map((e) => e.languageCode).contains(locale.languageCode)) {
      return locale;
    }
    return defaultLocale;
  }

  static String tr(String key, {List<String> args}) {
    final resource = AppLocalizations.instance._translations[key];
    if (resource == null) {
      return key;
    }
    return _replaceArgs(resource, args);
  }

  static String _replaceArgs(String res, List<String> args) {
    if (args == null || args.isEmpty) return res;
    args.forEach((String str) => res = res.replaceFirst(AppLocalizations.instance._replaceArgRegex, str));
    return res;
  }

  Future loadTranslations() async {
    var data = await assetLoader.load(path, Locale(_getLocale().languageCode));
    _translations = new Map<String, String>.from(data);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    if(ui.window.locale != null) {
      AppLocalizations.instance.locale = ui.window.locale;
    } else {
      AppLocalizations.instance.locale = locale;
    }
    AppLocalizations.instance.loadTranslations();
    return SynchronousFuture<AppLocalizations>(AppLocalizations.instance);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return true;
  }
}