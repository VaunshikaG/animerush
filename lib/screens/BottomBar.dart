import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Home.dart';
import 'HomeDrawer.dart';
import 'Search.dart';
import 'WatchList.dart';
import 'Account.dart';

class BottomBar extends StatefulWidget {
  final int currentIndex;
  final String? pg;

  const BottomBar({Key? key, required this.currentIndex, this.pg})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final _tabs = [
    const Home(),
    const Search(),
    const WatchList(pg: ''),
    const Account()
  ];
  int _selectedTab = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    log(runtimeType.toString());
    _selectedTab = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        // extendBody: true,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: appTheme.iconTheme.color),
          backgroundColor: appTheme.scaffoldBackgroundColor,
          titleSpacing: 5,
          title: FittedBox(
            fit: BoxFit.contain,
            child: Image.asset(
              height: 45,
              "assets/img/white_logo.png",
              fit: BoxFit.fitHeight,
              width: 100,
            ),
          ),
        ),
        drawerEdgeDragWidth: 50,
        endDrawer: const HomeDrawer(),
        body: SafeArea(child: _tabs[_selectedTab]),
        bottomNavigationBar: Container(
          color: appTheme.scaffoldBackgroundColor,
          padding: const EdgeInsets.all(8),
          child: GNav(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            duration: const Duration(milliseconds: 400),
            haptic: true,
            color: appTheme.iconTheme.color,
            activeColor: appTheme.primaryColor,
            hoverColor: appTheme.highlightColor,
            gap: 8,
            iconSize: 22,
            backgroundColor: appTheme.scaffoldBackgroundColor,
            tabBackgroundColor: appTheme.colorScheme.surface,
            tabs: const [
              GButton(
                icon: CupertinoIcons.house,
                text: 'Home',
              ),
              GButton(
                icon: CupertinoIcons.search,
                text: 'Search',
              ),
              GButton(
                icon: CupertinoIcons.bookmark,
                text: 'WatchList',
              ),
              GButton(
                icon: CupertinoIcons.person,
                text: 'Account',
              ),
            ],
            selectedIndex: _selectedTab,
            onTabChange: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
