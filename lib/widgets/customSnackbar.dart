import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/theme.dart';

class CustomSnackBar {
  CustomSnackBar(String content) {
    Get.rawSnackbar(
      messageText: Text(
        content,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: CustomTheme.black,
        ),
      ),
      icon: Icon(
        Icons.info_outline,
        color: CustomTheme.black,
      ),
      borderRadius: 10,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:
          Color.alphaBlend(const Color(0x26FFFFFF), CustomTheme.themeColor1),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      isDismissible: true,
      duration: const Duration(seconds: 5),
    );
  }
}

class ActionSnackBar {
  ActionSnackBar(String content, String actionTxt, void Function() onPressed) {
    Get.rawSnackbar(
      messageText: Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: CustomTheme.black,
        ),
      ),
      icon: Icon(
        Icons.info_outline,
        color: CustomTheme.black,
      ),
      mainButton: TextButton(
        onPressed: onPressed,
        child: Text(actionTxt),
      ),
      borderRadius: 10,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:
          Color.alphaBlend(const Color(0x26FFFFFF), CustomTheme.themeColor1),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      isDismissible: false,
      duration: const Duration(seconds: 10),
    );
  }
}
