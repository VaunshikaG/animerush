import 'package:animerush/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Account.dart';
import 'Home.dart';
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
    return WillPopScope(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: kIsWeb ? 1100 : MediaQuery.of(context).size.width,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: SafeArea(
              maintainBottomViewPadding: true,
              minimum: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        style: const TextStyle(fontSize: 16, color: Colors.white70),
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            CupertinoIcons.search,
                            size: 26,
                            color: Colors.white70,
                          ),
                          hintText: 'Search',
                          hintStyle: const TextStyle(fontSize: 16, color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white24,
                          contentPadding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent),
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
        ),
      ),
      onWillPop: () async {
        return false;
      },
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
              unselectedLabelColor: Colors.white70,
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
                const Home(), const Search(), const Wishlist(), const Account(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
