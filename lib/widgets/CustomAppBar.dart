import 'package:animerush/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//  details pg
Widget CustomAppBar({
  required String title,
  required String img,
  required void Function() backBtn,
  required void Function() wishlist,
}) {
  var top = 0.0;

  return SliverAppBar(
    pinned: true,
    elevation: 4,
    expandedHeight: 300,
    backgroundColor: CustomTheme.themeColor2,
    leading: FittedBox(
      fit: BoxFit.contain,
      child: IconButton(
        icon: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
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
          backBtn();
        },
      ),
    ),
    actions: [
      FittedBox(
        fit: BoxFit.contain,
        child: IconButton(
          icon: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CustomTheme.grey3,
              // backgroundBlendMode: BlendMode.softLight,
            ),
            child: Icon(
              CupertinoIcons.bookmark,
              size: 19,
              color: CustomTheme.white,
            ),
          ),
          onPressed: () {
            wishlist();
          },
        ),
      ),
    ],
    scrolledUnderElevation: 10,
    flexibleSpace: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        top = constraints.biggest.height;
        return FlexibleSpaceBar(
          centerTitle: true,
          expandedTitleScale: 1.3,
          title: Visibility(
            visible: (top == 88.0) ? true : false,
            // visible: true,
            child: Text(
              // top.toString(),
              title,
              style: TextStyle(
                fontSize: 14,
                color: CustomTheme.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
          ),
          background: Image.network(
            img,
            width: double.infinity,
            height: 400,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        );
      },
    ),
  );
}


//  details pg - blur_img
Widget CustomAppBar2({
  required void Function() backBtn,
  required void Function() wishlist,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: CustomTheme.white.withOpacity(0),
    leading: FittedBox(
      fit: BoxFit.contain,
      child: IconButton(
        icon: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
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
          backBtn();
        },
      ),
    ),
    actions: [
      FittedBox(
        fit: BoxFit.contain,
        child: IconButton(
          icon: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CustomTheme.grey3,
              // backgroundBlendMode: BlendMode.softLight,
            ),
            child: Icon(
              CupertinoIcons.bookmark,
              size: 19,
              color: CustomTheme.white,
            ),
          ),
          onPressed: () {
            wishlist();
          },
        ),
      ),
    ],
  );
}


//  episode pg
Widget CustomAppBar3({
  required String title,
  required void Function() backBtn,
  required void Function() wishlist,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: CustomTheme.themeColor2,
    leading: FittedBox(
      fit: BoxFit.contain,
      child: IconButton(
        icon: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
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
          backBtn();
        },
      ),
    ),
    title: Text(
      title,
      softWrap: true,
      maxLines: 2,
      style: TextStyle(
        fontSize: 14,
        color: CustomTheme.white,
      ),
    ),
    actions: [
      FittedBox(
        fit: BoxFit.contain,
        child: IconButton(
          icon: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CustomTheme.grey3,
              // backgroundBlendMode: BlendMode.softLight,
            ),
            child: Icon(
              CupertinoIcons.bookmark,
              size: 19,
              color: CustomTheme.white,
            ),
          ),
          onPressed: () {
            wishlist();
          },
        ),
      ),
    ],
  );
}
