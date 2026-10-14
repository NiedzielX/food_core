import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/services.dart';

Locale localeFromString(String localeString) {
  final localeList = localeString.split('_');
  switch (localeList.length) {
    case 2:
      return Locale(localeList.first, localeList.last);
    case 3:
      return Locale.fromSubtags(
          languageCode: localeList.first,
          scriptCode: localeList[1],
          countryCode: localeList.last);
    default:
      return Locale(localeList.first);
  }
}

String localeToString(Locale locale, {String separator = '_'}) {
  return locale.toString().split('_').join(separator);
}

abstract class AssetLoader {
  const AssetLoader();
  Future<Map<String, dynamic>> load(String path, Locale locale);
}

class RootBundleAssetLoader extends AssetLoader {
  const RootBundleAssetLoader();

  String getLocalePath(String basePath, Locale locale) {
    return '$basePath/${localeToString(locale, separator: "-")}.json';
  }

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    var localePath = getLocalePath(path, locale);
    log('Load asset from $path', name: 'Localizations');
    return json.decode(await rootBundle.loadString(localePath));
  }
}