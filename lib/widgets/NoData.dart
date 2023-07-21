import 'package:flutter/material.dart';

Widget noData(BuildContext context) {
    final appTheme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/img/luffy1.png',
          width: 200,
        ),
        const SizedBox(height: 10),
        Text(
          "Oops, failed to load data!",
          style: appTheme.textTheme.displayMedium,
        ),
      ],
    );
  }
