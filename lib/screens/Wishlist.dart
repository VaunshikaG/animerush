import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/LoginController.dart';
import '../controllers/WatchListController.dart';
import '../widgets/CustomButtons.dart';
import '../widgets/Loader.dart';
import '../widgets/NoData.dart';
import '../widgets/SimilarList.dart';
import 'BottomBar.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> with SingleTickerProviderStateMixin {
  WatchListController wishListController = Get.put(WatchListController());
  LoginController loginController = Get.put(LoginController());

  bool showPassword = true;
  ScrollController scrollController = ScrollController();
  TabController? _controller;

  @override
  void initState() {
    log(runtimeType.toString());
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      loadData();
    });
    super.initState();
  }

  Future<void> loadData() async {
    await showProgress(context, true);
    wishListController.watchApi('00');
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        // maintainBottomViewPadding: true,
        minimum: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: SizedBox(
            height: (wishListController.showLogin.value == true) ? double.infinity
                : MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() => Visibility(
                    visible: wishListController.hasData.value,
                    child: _tabSection(),
                  )),
                  Obx(() => Visibility(
                        visible: wishListController.showLogin.value,
                        child: Center(
                          child: elevatedButton(
                            text: "Login →",
                            onPressed: () =>
                                Get.off(() => const BottomBar(currentIndex: 3)),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabSection() {
    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Wrap(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
            child: TabBar(
              controller: _controller,
              automaticIndicatorColorAdjustment: true,
              isScrollable: true,
              onTap: (index) {
                setState(() {
                  if (index == 0) {
                    wishListController.watchApi('00');
                  } else if (index == 1) {
                    wishListController.watchApi('01');
                  } else if (index == 2) {
                    wishListController.watchApi('02');
                  } else if (index == 3) {
                    wishListController.watchApi('03');
                  } else if (index == 4) {
                    wishListController.watchApi('04');
                  } else if (index == 5) {
                    wishListController.watchApi('05');
                  }
                });
              },
              tabs: [
                Tab(
                  height: 35,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text("All"),
                  ),
                ),
                Tab(
                  height: 35,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text("Watching"),
                  ),
                ),
                Tab(
                  height: 35,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text("On-Hold"),
                  ),
                ),
                Tab(
                  height: 35,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text("Plan to Watch"),
                  ),
                ),
                Tab(
                  height: 35,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text("Dropped"),
                  ),
                ),
                Tab(
                  height: 35,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text("Completed"),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.82,
            child: TabBarView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                wishList(),
                wishList(),
                wishList(),
                wishList(),
                wishList(),
                wishList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget wishList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: wishListController.noData.value ?
        noData(context) : SimilarList(
        dataLength: wishListController.dataLength,
        similarData: wishListController.animeList,
      ),
    );
  }
}
