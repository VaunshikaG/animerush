import 'dart:developer';

import 'package:animerush/screens/bottomBar.dart';
import 'package:animerush/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

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
  // ScrollController scrollController = ScrollController();
  Search_Controller searchController = Get.put(Search_Controller());

  @override
  void initState() {
    log(runtimeType.toString());
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      searchController.searchApiCall(
          pgName: "searchField",
          searchModel: SearchModel(
            val: widget.category,
            genres: '',
            pageId: '1',
            sort: '',
            searchKeywords: '',
          ),
          ctx: context);
    });
    super.initState();
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
                              leading: (searchController.previousPg == '1')
                                  ? const SizedBox.shrink()
                                  : ElevatedButton.icon(
                                      onPressed: () {
                                        searchController.searchApiCall(
                                            pgName: "pagination",
                                            searchModel: SearchModel(
                                              val: searchController.value1,
                                              genres: searchController.value2,
                                              searchKeywords: searchController
                                                  .searchText.text,
                                              pageId: searchController
                                                  .previousPg
                                                  .toString(),
                                              sort: '',
                                            ),
                                            ctx: context);
                                      },
                                      label: Text(
                                        searchController.previousPg.toString(),
                                        style: appTheme.textTheme.titleSmall,
                                      ),
                                      icon: Icon(
                                        Icons.fast_rewind_outlined,
                                        size: 18,
                                        color: appTheme.iconTheme.color,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        side: BorderSide.none,
                                        backgroundColor: appTheme.hintColor,
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
                                      onPressed: () {
                                        searchController.searchApiCall(
                                            pgName: "pagination",
                                            searchModel: SearchModel(
                                              val: searchController.value1,
                                              genres: searchController.value2,
                                              searchKeywords: searchController
                                                  .searchText.text,
                                              pageId: searchController.nextPg
                                                  .toString(),
                                              sort: '',
                                            ),
                                            ctx: context);
                                      },
                                      label: Text(
                                        searchController.nextPg.toString(),
                                        style: appTheme.textTheme.titleSmall,
                                      ),
                                      icon: Icon(
                                        Icons.fast_forward_outlined,
                                        size: 18,
                                        color: appTheme.iconTheme.color,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        side: BorderSide.none,
                                        backgroundColor: appTheme.hintColor,
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
      ),
    );
  }
}
