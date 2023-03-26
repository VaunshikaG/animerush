import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class CustomSnackBar {
  CustomSnackBar(BuildContext context, Widget content,
      {SnackBarAction? snackBarAction, Color? backgroundColor}) {
    final SnackBar snackBar = SnackBar(
        action: snackBarAction,
        backgroundColor: backgroundColor ?? CustomTheme.black,
        content: content,
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
