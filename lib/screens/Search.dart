import 'package:animerush/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Account.dart';
import 'Details.dart';
import 'Wishlist.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {

  ScrollController scrollController = ScrollController();
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 4, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomTheme.transparent,
      body: SafeArea(
        maintainBottomViewPadding: true,
        minimum: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return false;
          },
          child: SingleChildScrollView(
            controller: scrollController,
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (text) {},
                    style: TextStyle(fontSize: 16, color: CustomTheme.white),
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        CupertinoIcons.search,
                        size: 26,
                        color: CustomTheme.white,
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 16, color: CustomTheme.white),
                      filled: true,
                      fillColor: CustomTheme.white24,
                      contentPadding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: CustomTheme.transparent),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: CustomTheme.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: CustomTheme.transparent),
                      ),
                    ),
                  ),
                ),
                _tabSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Wrap(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
            child:   TabBar(
              controller: _controller,
              automaticIndicatorColorAdjustment: true,
              isScrollable: true,
              unselectedLabelColor: CustomTheme.white,
              labelColor: CustomTheme.themeColor2,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomTheme.themeColor1,
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: 5),
              tabs: [
                Tab(
                  height: 35,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CustomTheme.themeColor1, width: 1),
                    ),
                    child: Center(
                      child: Text("Adventure"),
                    ),
                  ),
                ),
                Tab(
                  height: 35,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CustomTheme.themeColor1, width: 1),
                    ),
                    child: Center(
                      child: Text("Drama"),
                    ),
                  ),
                ),
                Tab(
                  height: 35,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CustomTheme.themeColor1, width: 1),
                    ),
                    child: Center(
                      child: Text("Romance"),
                    ),
                  ),
                ),
                Tab(
                  height: 35,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CustomTheme.themeColor1, width: 1),
                    ),
                    child: Center(
                      child: Text("Action"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.82,
            child: TabBarView(
              controller: _controller,
              children: [
                const Wishlist(), const Search(), const Wishlist(), const Account(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
