import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Home.dart';
import 'HomeDrawer.dart';
import 'Search.dart';
import 'Wishlist.dart';
import 'Account.dart';

class BottomBar extends StatefulWidget {
  final int currentIndex;

  const BottomBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final _tabs = [
    const Home(),
    const Search(),
    const Wishlist(),
    const Account()
  ];
  int _selectedTab = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _selectedTab = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: appTheme.iconTheme.color),
        backgroundColor: appTheme.colorScheme.background,
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
      body: _tabs[_selectedTab],
      bottomNavigationBar: Container(
        color: appTheme.colorScheme.background,
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
          backgroundColor: appTheme.colorScheme.background,
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
    );
  }
}
