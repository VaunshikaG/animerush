import 'dart:developer';

import 'package:animerush/screens/bottomBar.dart';
import 'package:animerush/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notix_inapp_flutter/notix.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/searchController.dart';
import '../model/rqModels.dart';
import '../utils/appConst.dart';
import '../widgets/customAppBar.dart';
import '../widgets/customButtons.dart';
import '../widgets/noData.dart';
import '../widgets/similarList.dart';
import 'auth.dart';

class Category extends StatefulWidget {
  final String category;
  const Category({Key? key, required this.category}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Search_Controller searchController = Get.put(Search_Controller());

  @override
  void initState() {
    debugPrint(runtimeType.toString());
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      searchCall();
    });
    super.initState();
  }

  Future<void> searchCall() async {
    final prefs = await SharedPreferences.getInstance();
    searchController.searchApiCall(
        pgName: "viewAll",
        searchModel: SearchModel(
          val: widget.category,
          genres: '',
          pageId: '1',
          sort: '',
          searchKeywords: '',
          deviceId: prefs.getString(AppConst.deviceId),
        ),
        context: context);
  }

  InterstitialData? interstitialData;
  Future<void> ads() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var loader = await Notix.Interstitial.createLoader(AppConst.ZONE_ID_5);
      loader.startLoading();
      interstitialData = await loader.next();
      DateTime? lastClicked = prefs.containsKey(AppConst.adTimeStamp5)
          ? DateTime.parse(prefs.getString(AppConst.adTimeStamp5)!)
          : null;

      if (lastClicked == null ||
          DateTime.now().difference(lastClicked) >=
              const Duration(minutes: 5)) {
        prefs.setString(AppConst.adTimeStamp5, DateTime.now().toString());
        Notix.Interstitial.show(interstitialData!);
      } else {
        log('Interstitial loaded within the last 5 mins. Not executing code1.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        Get.off(() => const BottomBar(currentIndex: 0, checkVersion: false));
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: CustomAppBar4(
            title: widget.category.toUpperCase(),
            backBtn: () => Get.off(
                () => const BottomBar(currentIndex: 0, checkVersion: false)),
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: Stack(
            children: [
              Container(
                // margin: (admob.bannerAd != null && admob.isBannerLoaded == true)
                //     ? EdgeInsets.only(
                //     bottom: MediaQuery.of(context).size.height * 0.071)
                //     : EdgeInsets.zero,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Obx(() => Visibility(
                            visible: searchController.hasData.value,
                            child: Container(
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                children: [
                                  SimilarList(
                                    pg: 'category',
                                    similarData: searchController.animeList,
                                  ),
                                  ListTile(
                                    leading: (searchController.previousPg ==
                                            searchController.currentPg)
                                        ? const SizedBox.shrink()
                                        : ElevatedButton.icon(
                                            onPressed: () async {
                                              final prefs = await SharedPreferences.getInstance();
                                              ads();
                                              searchController.searchApiCall(
                                                  pgName: "viewAll",
                                                  searchModel: SearchModel(
                                                    val: widget.category,
                                                    genres: '',
                                                    searchKeywords: '',
                                                    pageId: searchController
                                                        .previousPg
                                                        .toString(),
                                                    sort: '',
                                                    deviceId: prefs.getString(AppConst.deviceId),
                                                  ),
                                                  context: context);
                                            },
                                            label: Text(
                                              searchController.previousPg
                                                  .toString(),
                                              style:
                                                  appTheme.textTheme.titleSmall,
                                            ),
                                            icon: Icon(
                                              Icons.fast_rewind_outlined,
                                              size: 18,
                                              color: appTheme.iconTheme.color,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              side: BorderSide.none,
                                              backgroundColor:
                                                  appTheme.hintColor,
                                            ),
                                          ),
                                    title: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        side: BorderSide.none,
                                        backgroundColor:
                                            appTheme.scaffoldBackgroundColor,
                                      ),
                                      child: Text(
                                        searchController.currentPg.toString(),
                                        style: appTheme.textTheme.titleSmall,
                                      ),
                                    ),
                                    trailing: (searchController.maxPg ==
                                            searchController.currentPg)
                                        ? const SizedBox.shrink()
                                        : ElevatedButton.icon(
                                            onPressed: () async {
                                              final prefs = await SharedPreferences.getInstance();
                                              ads();
                                              searchController.searchApiCall(
                                                  pgName: "viewAll",
                                                  searchModel: SearchModel(
                                                    val: widget.category,
                                                    genres: '',
                                                    searchKeywords: '',
                                                    pageId: searchController
                                                        .nextPg
                                                        .toString(),
                                                    sort: '',
                                                    deviceId: prefs.getString(AppConst.deviceId),
                                                  ),
                                                  context: context);
                                            },
                                            label: Text(
                                              searchController.nextPg
                                                  .toString(),
                                              style:
                                                  appTheme.textTheme.titleSmall,
                                            ),
                                            icon: Icon(
                                              Icons.fast_forward_outlined,
                                              size: 18,
                                              color: appTheme.iconTheme.color,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              side: BorderSide.none,
                                              backgroundColor:
                                                  appTheme.hintColor,
                                            ),
                                          ),
                                    dense: true,
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Obx(() => Visibility(
                            visible: searchController.noData.value,
                            child: noData("Oops, failed to load data!"),
                          )),
                      Obx(() => Visibility(
                            visible: searchController.showLogin.value,
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
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child:
                // (admob.bannerAd != null && admob.isBannerLoaded == true)
                //     ? SizedBox(
                //   width: admob.bannerAd!.size.width.toDouble(),
                //   height: admob.bannerAd!.size.height.toDouble(),
                //   child: AdWidget(ad: admob.bannerAd!),
                // ) :
                SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
