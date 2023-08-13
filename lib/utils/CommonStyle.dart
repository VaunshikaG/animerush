import 'package:animerush/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppConst.dart';

class CommonStyle {
  static InputDecoration textFieldStyle1(
      {String labelText = "", String hintText = ""}) {
    return InputDecoration(
      fillColor: CustomTheme.grey300,
      filled: true,
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      label: Text(
        labelText,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black54,
          fontWeight: FontWeight.normal,
        ),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 15,
        color: Colors.black54,
        fontWeight: FontWeight.normal,
      ),
      constraints: const BoxConstraints(maxWidth: 300),
      contentPadding: const EdgeInsets.all(10),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static InputDecoration email_textFieldStyle(
      {String labelText = "",
      String hintText = "",
      required TextStyle? style}) {
    return InputDecoration(
      fillColor: CustomTheme.grey300,
      filled: true,
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      label: Text(labelText, style: style),
      hintText: hintText,
      hintStyle: style,
      constraints: const BoxConstraints(maxWidth: 300),
      contentPadding: const EdgeInsets.only(left: 10),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  static InputDecoration password_textFieldStyle(
      {String labelText = "",
      String hintText = "",
      required IconButton suffix,
      required TextStyle? style}) {
    return InputDecoration(
      fillColor: CustomTheme.grey300,
      filled: true,
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      suffixIcon: suffix,
      label: Text(labelText, style: style),
      hintText: hintText,
      hintStyle: style,
      constraints: const BoxConstraints(maxWidth: 300),
      contentPadding: const EdgeInsets.only(left: 10),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.grey,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  static InputDecoration suffixTextField(
      {String labelText = "",
      String hintText = "",
      required IconButton suffix,
      required TextStyle? style,
      required bool theme}) {
    return InputDecoration(
      fillColor: theme ? CustomTheme.grey300 : CustomTheme.grey2,
      filled: false,
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      suffixIcon: suffix,
      label: Text(labelText, style: style),
      hintText: hintText,
      hintStyle: style,
      constraints: const BoxConstraints(maxWidth: 300),
      contentPadding: const EdgeInsets.only(left: 10),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  static InputDecoration searchTextField(
      {String labelText = "",
        String hintText = "",
        required Widget suffix,
        required Widget prefix,
        required TextStyle? style}) {
    return InputDecoration(
      filled: false,
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      prefixIcon: prefix,
      suffixIcon: suffix,
      label: Text(labelText),
      labelStyle: style,
      hintText: hintText,
      hintStyle: style,
      constraints: const BoxConstraints(maxWidth: 300),
      contentPadding: const EdgeInsets.only(left: 15),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  static InputDecoration prefixTextField(
      {String labelText = "", String hintText = "", String prefixText = ""}) {
    return InputDecoration(
      fillColor: CustomTheme.grey300,
      filled: true,
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      label: Text(
        labelText,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black54,
          fontWeight: FontWeight.normal,
        ),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 15,
        color: Colors.black54,
        fontWeight: FontWeight.normal,
      ),
      prefix: Text(
        prefixText,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black54,
          fontWeight: FontWeight.normal,
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 300),
      contentPadding: const EdgeInsets.all(10),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static TextFormField readOnlyField({controller, String labelText = ""}) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      enableInteractiveSelection: false,
      showCursor: false,
      enabled: false,
      readOnly: true,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
      decoration: InputDecoration(
        fillColor: CustomTheme.grey300,
        filled: true,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        label: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        constraints: const BoxConstraints(maxWidth: 300),
        contentPadding: const EdgeInsets.all(15),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

Widget customText({required String text1, required String text2}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            text1,
            softWrap: true,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: CustomTheme.white,
              fontWeight: FontWeight.bold,
              fontFamily: AppConst.FONT,
              fontSize: 13,
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Text(
            text2,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: CustomTheme.white,
              // fontWeight: FontWeight.bold,
              fontFamily: AppConst.FONT,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget customTile({required String text1, required String text2}) {
  return ListTile(
    title: Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Text(
        text1,
        style: TextStyle(
          fontSize: 15,
          color: CustomTheme.grey400,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    subtitle: Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        color: CustomTheme.grey300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text2,
        style: TextStyle(
          fontSize: 14,
          color: CustomTheme.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    contentPadding: EdgeInsets.zero,
  );
}
