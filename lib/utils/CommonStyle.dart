import 'package:animerush/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppConst.dart';

TextStyle titleStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontFamily: 'Quicksand',
  color: CustomTheme.white,
);

TextStyle subtitleStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  fontFamily: 'Quicksand',
  color: CustomTheme.grey2,
);

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

InputDecoration textFieldStyle({String labelText = "", String hintText = ""}) {
  return InputDecoration(
    label: Text(
      labelText,
      style: TextStyle(
        fontSize: 15,
        color: CustomTheme.black54,
        fontWeight: FontWeight.normal,
      ),
    ),
    hintText: hintText,
    hintStyle: TextStyle(
      fontSize: 15,
      color: CustomTheme.black54,
      fontWeight: FontWeight.normal,
    ),
    constraints: const BoxConstraints(maxWidth: 300),
    contentPadding: const EdgeInsets.only(left: 10),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: CustomTheme.grey,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: CustomTheme.grey,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: CustomTheme.grey,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: CustomTheme.grey,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: CustomTheme.grey,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

InputDecoration email_textFieldStyle({
  String labelText = "",
  String hintText = "",
}) {
  return InputDecoration(
    fillColor: CustomTheme.grey300,
    filled: true,
    label: Text(
      labelText,
      style: TextStyle(
        fontSize: 15,
        color: CustomTheme.black54,
        fontWeight: FontWeight.normal,
      ),
    ),
    hintText: hintText,
    hintStyle: TextStyle(
      fontSize: 15,
      color: CustomTheme.black54,
      fontWeight: FontWeight.normal,
    ),
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

InputDecoration password_textFieldStyle({
  String labelText = "",
  String hintText = "",
  required IconButton suffix,
}) {
  return InputDecoration(
    fillColor: CustomTheme.grey300,
    filled: true,
    suffixIcon: suffix,
    label: Text(
      labelText,
      style: TextStyle(
        fontSize: 15,
        color: CustomTheme.black54,
        fontWeight: FontWeight.normal,
      ),
    ),
    hintText: hintText,
    hintStyle: TextStyle(
      fontSize: 15,
      color: CustomTheme.black54,
      fontWeight: FontWeight.normal,
    ),
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

TextFormField readOnlyField({controller, String labelText = ""}) {
  return TextFormField(
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
      filled: true,
      fillColor: CustomTheme.black12,
      label: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          labelText,
          style: TextStyle(
            fontSize: 15,
            color: CustomTheme.black54,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 300),
      contentPadding: const EdgeInsets.only(left: 10),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}
