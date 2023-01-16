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
            child: const Text(
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
            expandedStyle: const TextStyle(
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

  @override
  Widget _build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: FlexibleHeaderDelegate(
        backgroundColor: CustomTheme.themeColor2,
        actions: [
          FittedBox(
            fit: BoxFit.contain,
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  backgroundBlendMode: BlendMode.softLight,
                ),
                child: const Icon(
                  CupertinoIcons.bookmark,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
        leading: FittedBox(
          fit: BoxFit.contain,
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                backgroundBlendMode: BlendMode.softLight,
              ),
              child: const Icon(
                CupertinoIcons.left_chevron,
                color: Colors.white,
                size: 18,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        statusBarHeight: MediaQuery.of(context).padding.top,
        expandedHeight: 60,
      ),
    );
  }
}

class CustomAppBar2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: FlexibleHeaderDelegate(
        backgroundColor: CustomTheme.themeColor2,
        actions: [
          FittedBox(
            fit: BoxFit.contain,
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  backgroundBlendMode: BlendMode.softLight,
                ),
                child: const Icon(
                  CupertinoIcons.bookmark,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
        leading: FittedBox(
          fit: BoxFit.contain,
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                backgroundBlendMode: BlendMode.softLight,
              ),
              child: const Icon(
                CupertinoIcons.left_chevron,
                color: Colors.white,
                size: 18,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        statusBarHeight: MediaQuery.of(context).padding.top,
        expandedHeight: 60,
      ),
    );
  }
}