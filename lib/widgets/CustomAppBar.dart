import 'package:animerush/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar(this.title);
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: FlexibleHeaderDelegate(
        backgroundColor: CustomTheme.themeColor2,
        leading: FittedBox(
          fit: BoxFit.contain,
          child: ElevatedButton(
            child: Text(
              "   <  Back",
              style: TextStyle(fontSize: 16, color: CustomTheme.themeColor1),
            ),
            style: ElevatedButton.styleFrom(
              primary: CustomTheme.themeColor2,
              foregroundColor: Colors.grey[350],
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        statusBarHeight: MediaQuery.of(context).padding.top,
        expandedHeight: 80,
        children: [
          FlexibleTextItem(
            text: title,
            textAlign: TextAlign.center,
            expandedStyle: TextStyle(
                fontSize: 18,
                color: CustomTheme.themeColor1,
                fontWeight: FontWeight.bold,
                wordSpacing: 3
            ),
            collapsedStyle:
            const TextStyle(fontSize: 16, color: Colors.black),
            expandedAlignment: Alignment.bottomLeft,
            collapsedAlignment: Alignment.center,
            expandedPadding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar2 extends StatefulWidget {
  // final String img;
  const CustomAppBar2({Key? key, }) : super(key: key);

  @override
  State<CustomAppBar2> createState() => _CustomAppBar2State();
}

class _CustomAppBar2State extends State<CustomAppBar2> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: CustomTheme.white.withOpacity(0),
      leading: FittedBox(
        fit: BoxFit.contain,
        child: IconButton(
          icon: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CustomTheme.grey3,
              // backgroundBlendMode: BlendMode.softLight,
            ),
            child: Icon(
              CupertinoIcons.left_chevron,
              color: CustomTheme.white,
              size: 18,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      actions: [
        FittedBox(
          fit: BoxFit.contain,
          child: IconButton(
            icon: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(6, 3, 6, 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomTheme.grey3,
                // backgroundBlendMode: BlendMode.softLight,
              ),
              child: Icon(
                CupertinoIcons.bookmark,
                size: 18,
                color: CustomTheme.white,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}