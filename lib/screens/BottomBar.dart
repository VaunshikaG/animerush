import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../theme.dart';
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
    _selectedTab = widget.currentIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomTheme.themeColor2,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: CustomTheme.white),
        backgroundColor: CustomTheme.themeColor2,
      ),
      drawerEdgeDragWidth: 50,
      // drawerScrimColor: Colors.transparent,
      drawer: const HomeDrawer(),
      body: _tabs[_selectedTab],
      bottomNavigationBar: Container(
        color: CustomTheme.themeColor2,
        padding: const EdgeInsets.all(8),
        child: GNav(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          duration: const Duration(milliseconds: 400),
          haptic: true,
          color: CustomTheme.white,
          activeColor: CustomTheme.themeColor1,
          hoverColor: Colors.blueGrey[50]!,
          gap: 8,
          iconSize: 22,
          backgroundColor: CustomTheme.themeColor2,
          tabBackgroundColor: CustomTheme.grey2,
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
