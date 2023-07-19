import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/LoginController.dart';
import '../controllers/WishListController.dart';
import '../widgets/CustomButtons.dart';
import '../widgets/Loader.dart';
import 'BottomBar.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> with SingleTickerProviderStateMixin {
  WishListController wishListController = Get.put(WishListController());
  LoginController loginController = Get.put(LoginController());

  final _formKey1 = GlobalKey<FormState>();
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
    final prefs = await SharedPreferences.getInstance();
    await showProgress(context, "Please wait...", true);
    wishListController.watchApi('00');
  }

  @override
  Widget build(BuildContext context) {
    print(wishListController.showLogin);
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
            height: (wishListController.showLogin == true) ? double.infinity
                : MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() => Visibility(
                    visible: wishListController.noData.value,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/luffy1.png',
                            width: 200,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Oops, failed to load data!",
                            style: appTheme.textTheme.displayLarge,
                          ),
                        ],
                      ),
                    ),
                  )),
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
    final appTheme = Theme.of(context);

    return DefaultTabController(
      length: 6,
      child: Wrap(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
            child: TabBar(
              controller: _controller,
              automaticIndicatorColorAdjustment: true,
              isScrollable: true,
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
    return Column();
  }

}
