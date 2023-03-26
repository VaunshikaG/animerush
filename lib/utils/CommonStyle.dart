import 'package:animerush/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

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
