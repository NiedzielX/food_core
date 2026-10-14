import 'package:flutter/material.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/strings.dart';

enum MenuAction {
  home, scan, favorite, profile, notification, nutritionalInterview, preferences, history, premium, contact, switchProfile, logout
}

class CustomMenuItem {

  String title;
  MenuAction action;
  Image icon;

  CustomMenuItem(this.title, this.action, {this.icon});
}

class Menu {

  static List<CustomMenuItem> items = [];
  static List<CustomMenuItem> itemsSettings = [];

  static List<CustomMenuItem> getItems() {
    List<CustomMenuItem> _items = [];
    _items.addAll([
      CustomMenuItem(Strings.home, MenuAction.home),
      CustomMenuItem(Strings.scan, MenuAction.scan),
      CustomMenuItem(Strings.favorite, MenuAction.favorite),
      CustomMenuItem(Strings.profile, MenuAction.profile),
    ]);
    items = _items;
    return _items;
  }

  static List<CustomMenuItem> getItemsSettings() {
    List<CustomMenuItem> _items = [];
    _items.addAll([
      CustomMenuItem(Strings.nutritionalInterview, MenuAction.nutritionalInterview, icon: Assets.food),
      CustomMenuItem(Strings.preferences, MenuAction.preferences, icon: Assets.preferences),
      CustomMenuItem(Strings.history, MenuAction.history, icon: Assets.history),
      CustomMenuItem(Strings.premium, MenuAction.premium, icon: Assets.premium),
      CustomMenuItem(Strings.contact, MenuAction.contact, icon: Assets.contact),
      CustomMenuItem(Strings.switchProfile, MenuAction.switchProfile, icon: Assets.profileChange),
      CustomMenuItem(Strings.logout, MenuAction.logout, icon: Assets.logout)
    ]);
    itemsSettings = _items;
    return _items;
  }
}