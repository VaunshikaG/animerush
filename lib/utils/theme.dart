import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  const CustomTheme();
  // f8b745 orange
  // 202125  black

  static Color themeColor1 = CupertinoColors.activeOrange.darkColor;
  static Color themeColor2 = CupertinoColors.black;

  //  white
  static Color transparent = Color(0x3C000000);
  static Color white = CupertinoColors.white;
  static Color white24 = Colors.white24;

  //  grey
  static Color grey1 = CupertinoColors.systemGrey6.darkColor;
  static Color grey2 = CupertinoColors.systemGrey5.darkHighContrastColor;
  static Color grey3 = CupertinoColors.systemGrey5.darkColor;

  //  blue
  static Color blue = Colors.blue.shade700;
  static Color blueGrey50 = Colors.blueGrey.shade50;

  //  black
  static Color img_blur = Color(0xB0000000);
  static Color black12 = Colors.black12;
  static Color black45 = Colors.black45;
  static Color black54 = Colors.black54;
  static Color black87 = Colors.black87;
}

List<Color> ColorList = [
  CupertinoColors.systemIndigo,
  CupertinoColors.systemYellow,
  CupertinoColors.systemPurple,
  CupertinoColors.systemPink,
  CupertinoColors.systemTeal,
  CupertinoColors.systemGreen,
  CupertinoColors.systemRed,
];
