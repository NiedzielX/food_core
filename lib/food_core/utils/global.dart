import 'dart:io' show File, Platform;
import 'dart:ui';

import 'package:date_format/date_format.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:food_core/food_core/extensions/hex_color.dart';
import 'package:food_core/food_core/model/polish_locale.dart';
import 'package:food_core/food_core/utils/assets.dart';
import 'package:food_core/food_core/utils/file_validator.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalUtils {
  static const alert_duration = 4;
  static const alert_margin = 15.0;
  static const alert_border_radius = 8.0;
  static const alert_font_size = 13.0;
  static const alert_color = Colors.black;

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  static bool isEmpty(String em) {
    return em.isEmpty;
  }

  static String getNullableString(String text) {
    if (text != null) {
      return text;
    } else {
      return "";
    }
  }

  static bool isFile(String path) {
    return FileValidator.isValid(path);
  }

  static TextStyle pageTitleText([double fontSize = 20.0]) {
    return TextStyle(
        color: MyColors.white, fontSize: fontSize, fontWeight: FontWeight.w500);
  }

  static TextStyle greyTextStyle(double fontSize) {
    return TextStyle(fontSize: fontSize, color: Colors.grey);
  }

  static TextStyle greyTextStyleBold(double fontSize) {
    return TextStyle(
        fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.grey);
  }

  static TextStyle accentTextStyleBold(BuildContext context, double fontSize) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).accentColor);
  }

  static TextStyle accentTextStyle(BuildContext context, double fontSize) {
    return TextStyle(fontSize: fontSize, color: Theme.of(context).accentColor);
  }

  static TextStyle normalText(BuildContext context, [double fontSize = 14.0]) {
    return TextStyle(color: MyColors.lightGrey, fontSize: fontSize);
  }

  static TextStyle darkHeadingText(BuildContext context,
      [double fontSize = 24.0]) {
    return TextStyle(
        color: MyColors.darkGrey,
        fontSize: fontSize,
        fontWeight: FontWeight.bold);
  }

  static TextStyle headingText(BuildContext context, [double fontSize = 16.0]) {
    return TextStyle(color: MyColors.darkGrey, fontSize: fontSize);
  }

  static TextStyle subHeadingText(BuildContext context,
      [double fontSize = 16.0]) {
    return TextStyle(color: MyColors.lightGrey, fontSize: fontSize);
  }

  static TextStyle body1Text(BuildContext context, [double fontSize = 13.0]) {
    return TextStyle(color: MyColors.mediumGrey, fontSize: fontSize);
  }

  static TextStyle getHintStyle() {
    return TextStyle(
        color: MyColors.silver, fontSize: 16, fontWeight: FontWeight.w500);
  }

  static TextStyle getTextFormFieldStyle([double fontSize = 16.0]) {
    return TextStyle(
        color: MyColors.darkGrey,
        fontSize: fontSize,
        fontWeight: FontWeight.w500);
  }

  static TextStyle linkText(BuildContext context, [double fontSize = 14.0]) {
    return TextStyle(
        color: MyColors.darkGrey,
        fontSize: fontSize,
        decoration: TextDecoration.underline);
  }

  static TextStyle interviewBody1TextStyle([double fontSize = 14.0]) {
    return TextStyle(
        color: MyColors.graySecondary,
        fontSize: fontSize,
        fontWeight: FontWeight.w500);
  }

  static TextStyle categoryText(BuildContext context,
      [double fontSize = 16.0]) {
    return TextStyle(color: Colors.white, fontSize: fontSize);
  }

  static TextStyle buttonTextStyle(BuildContext context,
      [double fontSize = 16.0]) {
    return TextStyle(
        fontWeight: FontWeight.w500, fontSize: fontSize, color: MyColors.white);
  }

  static TextStyle buttonLinkTextStyle(BuildContext context,
      [double fontSize = 14.0]) {
    return TextStyle(fontSize: fontSize, color: MyColors.darkGrey);
  }

  static TextStyle buttonLinkRichTextStyle(BuildContext context) {
    return TextStyle(color: MyColors.skyBlue, fontWeight: FontWeight.bold);
  }

  static RoundedRectangleBorder buttonShapeStyle(BuildContext context,
      [double buttonRadius = 3.0]) {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(buttonRadius)));
  }

  static TextStyle newsHeadingText(BuildContext context,
      [double fontSize = 15.0]) {
    return TextStyle(
        color: MyColors.lightGrey,
        fontSize: fontSize,
        fontWeight: FontWeight.bold);
  }

  static TextStyle textFieldStyle(BuildContext context,
      [double fontSize = 14.0]) {
    return TextStyle(color: MyColors.lightGrey, fontSize: fontSize);
  }

  static TextStyle newsDateText(BuildContext context,
      [double fontSize = 15.0]) {
    return TextStyle(color: MyColors.lightGrey, fontSize: fontSize);
  }

  static TextStyle newsDescriptionText(BuildContext context,
      [double fontSize = 15.0]) {
    return newsDateText(context, fontSize);
  }

  static TextStyle formLabel([double fontSize = 20.0]) {
    return new TextStyle(fontSize: fontSize, color: Colors.white);
  }

  static TextStyle formSuccessMessage([double fontSize = 20.0]) {
    return new TextStyle(
        fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold);
  }

  static ButtonStyle textButtonStyle({double fontSize = 16.0}) {
    return TextButton.styleFrom(
        primary: MyColors.skyBlue, textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600));
  }

  static TextStyle blueButtonTextStyle([double fontSize = 14.0]) {
    return new TextStyle(
        color: MyColors.skyBlue, fontSize: fontSize, fontWeight: FontWeight.w600);
  }

  static Widget pageHeader(BuildContext context, String title) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Divider(
            thickness: 2,
            color: MyColors.darkGrey,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(title,
              textAlign: TextAlign.center,
              style: GlobalUtils.headingText(context)),
        ),
        Expanded(
          flex: 1,
          child: Divider(
            thickness: 2,
            color: MyColors.darkGrey,
          ),
        ),
      ],
    );
  }

  static getPhoto2(String tag, String photo) {
    return new Hero(
        tag: tag,
        child: Image.asset(
          'images/stamp.png',
        ));
  }

  static Image getAvatar(String url) {
    if (url != null && url.isNotEmpty) {
      if (GlobalUtils.isFile(url)) {
        File file = new File(url);
        return Image.file(file, fit: BoxFit.cover);
      } else {
        return Image.network(url, fit: BoxFit.cover);
      }
    } else {
      return Image(image: Assets.camera.image, width: 20, height: 20);
    }
  }

  static Image getPhoto(String url) {
    if (url != null && url.isNotEmpty) {
      return Image.network(url, fit: BoxFit.fill);
    } else {
      return Assets.camera;
    }
  }

  static bool compareDates(DateTime first, DateTime second) {
    return first.day == second.day &&
        first.month == second.month &&
        first.year == second.year;
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: false);
    } else {
      print("URL not opened" + url);
    }
  }

  static launchEmail(String email, String subject) async {
    var url = "mailto:" + email + "?subject=" + Uri.encodeComponent(subject);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("URL not opened" + url);
    }
  }

  static launchCall(String phone) async {
    var url = "tel://" + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("URL not opened" + url);
    }
  }

  static List chunk(List list, int chunkSize) {
    List chunks = [];
    int len = list.length;
    for (var i = 0; i < len; i += chunkSize) {
      int size = i + chunkSize;
      chunks.add(list.sublist(i, size > len ? len : size));
    }
    return chunks;
  }

  static String getLocaleCode() {
    if (Platform.localeName == null) {
      return 'pl';
    }
    return ['pl'].contains(Platform.localeName.split('_')[0])
        ? Platform.localeName.split('_')[0]
        : 'pl';
  }

  static Locale getLocaleDate() {
    return PolishLocale();
  }

  static DateTime dateFromString(String dateString) {
    return DateTime.parse(dateString);
  }

  static String formatStringDate(String dateString) {
    return formatDate(dateFromString(dateString), [d, ' ', MM, ' ', yyyy],
        locale: getLocaleDate());
  }

  static String getMonthString(int month) {
    var time = DateTime(DateTime.now().year, month);
    return formatDate(time, [M], locale: getLocaleDate());
  }

  static void showSnack(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: MyColors.skyBlue,
      duration: Duration(seconds: 2),
      content: Text(msg)
    ));
  }

  static void showFlashBanner(BuildContext context, String title, String text) {
    showFlash(
      context: context,
      duration: const Duration(seconds: alert_duration),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          margin: EdgeInsets.all(alert_margin),
          backgroundColor: Colors.white,
          borderColor: Colors.grey,
          boxShadows: kElevationToShadow[alert_border_radius],
          borderRadius: BorderRadius.circular(alert_border_radius),
          barrierDismissible: true,
          style: FlashStyle.floating,
          position: FlashPosition.top,
          child: FlashBar(
            title: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: alert_font_size,
                    color: alert_color)),
            message: Text(text,
                style:
                    TextStyle(fontSize: alert_font_size, color: alert_color)),
            showProgressIndicator: false,
          ),
        );
      },
    );
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '').trim();
  }
}
