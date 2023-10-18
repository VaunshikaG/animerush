import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';

import '../controllers/loginController.dart';
import '../controllers/watchListController.dart';
import '../utils/appConst.dart';
import '../widgets/customAppBar.dart';
import '../widgets/customButtons.dart';
import '../widgets/customSnackbar.dart';
import '../widgets/loader.dart';
import '../widgets/noData.dart';
import '../widgets/similarList.dart';
import 'bottomBar.dart';
import 'details.dart';
import 'auth.dart';

class WatchList extends StatefulWidget {
  final String? aId;
  final String pg;
  const WatchList({Key? key, required this.pg, this.aId}) : super(key: key);

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> with IronSourceBannerListener {
  WatchListController watchListController = Get.put(WatchListController());
  LoginController loginController = Get.put(LoginController());

  bool showPassword = true;
  ScrollController scrollController = ScrollController();
  TabController? _controller;

  bool isBannerLoaded = false;
  bool bannerCapped = false;
  final size = IronSourceBannerSize.BANNER;

  @override
  void initState() {
    initAds();
    debugPrint(runtimeType.toString());
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      loadData('00');
    });
    super.initState();
  }

  Future<void> loadData(String value) async {
    await showProgress(context, false);
    Future.delayed(const Duration(seconds: 1), () {
      watchListController.watchApi(value);
    });
  }

  Future<void> initAds() async {
    IronSource.setBannerListener(this);
    if (!bannerCapped) {
      bannerCapped = await IronSource.isBannerPlacementCapped('DefaultBanner');
      print('Banner DefaultBanner capped: $bannerCapped');
      // size.isAdaptive = true; // Adaptive Banner
      IronSource.loadBanner(
          size: size,
          position: IronSourceBannerPosition.Bottom,
          // verticalOffset: 40,
          verticalOffset: -(MediaQuery.of(context).size.height * 0.242).toInt(),
          placementName: 'DefaultBanner');
      log('banner displayed');
      IronSource.displayBanner();
    }
  }

  /// Banner listener ==================================================================================
  @override
  void onBannerAdClicked() {
    print("onBannerAdClicked");
  }

  @override
  void onBannerAdLoadFailed(IronSourceError error) {
    print("onBannerAdLoadFailed Error:$error");
    setState(() => isBannerLoaded = false);
  }

  @override
  void onBannerAdLoaded() {
    log("onBannerAdLoaded");
    setState(() => isBannerLoaded = true);
  }

  @override
  void onBannerAdScreenDismissed() {
    print("onBannerAdScreenDismissed");
  }

  @override
  void onBannerAdScreenPresented() {
    print("onBannerAdScreenPresented");
  }

  @override
  void onBannerAdLeftApplication() {
    print("onBannerAdLeftApplication");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        IronSource.destroyBanner();
        log('destroyBanner');
        Get.off(() => Details(id: widget.aId, epId: ''));
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: (widget.pg == 'detail')
              ? CustomAppBar4(
                  title: 'WatchList',
                  backBtn: () =>
                      Get.off(() => Details(id: widget.aId, epId: '')),
                )
              : const SizedBox(),
        ),
        body: SafeArea(
          // maintainBottomViewPadding: true,
          minimum: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size
                      .height * 0.06),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (widget.pg == 'detail')
                            ? const SizedBox(height: 10) : const SizedBox.shrink(),
                        Obx(() => Visibility(
                              visible: watchListController.hasData.value,
                              child: _tabSection(),
                            )),
                        Obx(() => Visibility(
                              visible: watchListController.noData.value,
                              child: noData("Oops, failed to load data!"),
                            )),
                        Obx(() => Visibility(
                              visible: watchListController.showLogin.value,
                              child: Center(
                                heightFactor: 13,
                                child: elevatedButton(
                                  text: "Login →",
                                  onPressed: () => Get.offAll(() => const Auth()),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    color: Colors.black,
                  ),
                ),
              ],
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
                  watchListController.animeList.clear();
                  if (index == 0) {
                    loadData('00');
                  } else if (index == 1) {
                    loadData('01');
                  } else if (index == 2) {
                    loadData('02');
                  } else if (index == 3) {
                    loadData('03');
                  } else if (index == 4) {
                    loadData('04');
                  } else if (index == 5) {
                    loadData('05');
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.82,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
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
    return ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          (watchListController.dataLength == 0)
              ? noData("Oops, no data found!")
              : Padding(
                padding:
                EdgeInsets.only(bottom: (widget.pg == 'detail') ? 10 :
                MediaQuery.of(context).size.height / 10),
                child: SimilarList(
              pg: 'watch',
              similarData: watchListController.animeList,
            ),
          )
        ],
      );
  }
}
