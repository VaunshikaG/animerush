import 'package:flutter/material.dart';

Widget noData(String text) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/img/luffy1.png',
          width: 160,
        ),
        const SizedBox(height: 20),
        Text(
          (text.isEmpty) ? "Oops, failed to load data!" : text,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
