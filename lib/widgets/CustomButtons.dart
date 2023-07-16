import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/theme.dart';

class elevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const elevatedButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomTheme.themeColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          fixedSize: const Size(300, 45),
        ),
        child: Text(
          text,
          style: appTheme.textTheme.headlineSmall,
        ),
      );
  }
}

class textButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const textButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: CustomTheme.themeColor1,
        ),
      ),
    );
  }
}