import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(int value) : super(value);

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class MyColors {
  static final Color lighterGrey = HexColor.fromHex('#E5E5E5');
  static final Color hintText = HexColor.fromHex('#AFAFAF');
  static final Color darkGrey = HexColor.fromHex('#384558');
  static final Color skyBlue = HexColor.fromHex('#4DA8C7');
  static final Color lightGrey = HexColor.fromHex('#6B6E7C');
  static final Color white = HexColor.fromHex('#FFFFFF');
  static final Color silver = HexColor.fromHex('#E2E2E2');
  static final Color silverDark = HexColor.fromHex('#969696');
  static final Color graySecondary = HexColor.fromHex('#6A6F7D');
  static final Color redSecondary = HexColor.fromHex('#F12C1F');
  static final Color textFieldSearch = HexColor.fromHex('#F1F2F6');
  static final Color color01 = HexColor.fromHex('#36455A');
  static final Color mediumGrey = HexColor.fromHex('#6A6F7D');
  static final Color accentGrey = HexColor.fromHex('#F1F2F6');

  static final Color color03 = HexColor.fromHex('#6A6F7D');
  static final Color warningColor = HexColor.fromHex('#DE4706');
  static final Color lightBlue = HexColor.fromHex('#F2FDFF');
  static final Color searchIcon = HexColor.fromHex('#798184');


}