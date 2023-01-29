import 'dart:ui';
import 'package:flutter/cupertino.dart';

class CustomTheme {
  const CustomTheme();
  // f8b745 orange
  // 202125  black

  static Color themeColor1 = CupertinoColors.activeOrange.darkColor;
  static Color themeColor2 = CupertinoColors.black;

  static Color white = CupertinoColors.white;
  static Color grey1 = CupertinoColors.systemGrey6.darkColor;
  static Color grey2 = CupertinoColors.systemGrey5.darkHighContrastColor;
  static Color grey3 = CupertinoColors.systemGrey5.darkColor;
  static Color transparent = Color(0x3C000000);
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
