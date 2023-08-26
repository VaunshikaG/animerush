import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/theme.dart';

class elevatedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

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
          fixedSize: const Size(200, 45),
          alignment: Alignment.center),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: appTheme.textTheme.labelSmall,
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
