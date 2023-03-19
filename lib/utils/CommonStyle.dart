import 'package:animerush/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          softWrap: true,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
            fontSize: 14,
          ),
        ),
        Text(
          text2,
          softWrap: true,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

