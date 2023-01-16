import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
import 'Home.dart';
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

  final _tabs = [const Home(), const Search(), const Wishlist(), const Account()];
  int _selectedTab = 0;

  @override
  void initState() {
    _selectedTab = widget.currentIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: kIsWeb ? 1100 : MediaQuery.of(context).size.width,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomTheme.themeColor2,
          extendBody: true,
          body: _tabs[_selectedTab],
          bottomNavigationBar: DotNavigationBar(
            itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            paddingR: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            curve: Curves.easeInCirc,
            borderRadius: 15,
            backgroundColor: Colors.white12,
            currentIndex: _selectedTab,
            dotIndicatorColor: Colors.transparent,
            onTap: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
            items: [
              DotNavigationBarItem(
                icon: Icon(
                  (_selectedTab == 0) ? CupertinoIcons.house_fill : CupertinoIcons.house,
                ),
                unselectedColor: Colors.white70,
                selectedColor: CustomTheme.themeColor1,
              ),

              DotNavigationBarItem(
                icon: const Icon(
                  CupertinoIcons.search,
                ),
                unselectedColor: Colors.white70,
                selectedColor: CustomTheme.themeColor1,
              ),

              DotNavigationBarItem(
                icon: Icon(
                  (_selectedTab == 2) ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                ),
                unselectedColor: Colors.white70,
                selectedColor: CustomTheme.themeColor1,
              ),

              DotNavigationBarItem(
                icon: Icon(
                  (_selectedTab == 3) ? CupertinoIcons.person_fill : CupertinoIcons.person,
                ),
                unselectedColor: Colors.white70,
                selectedColor: CustomTheme.themeColor1,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
