import 'dart:developer';

import 'package:animerush/screens/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../controllers/searchController.dart';
import '../model/rqModels.dart';
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

ScrollController scrollController = ScrollController();

class _CategoryState extends State<Category> {
  Search_Controller searchController = Get.put(Search_Controller());
  int _pageNumber = 0;

  void _scrollListener() {
    if (scrollController.position.extentAfter == 0) {
      setState(() {
        _pageNumber++;
        searchController.isListLoading.value = true;
        searchController.searchApiCall(
            pgName: "category",
            searchModel: SearchModel(
              val: widget.category,
              genres: '',
              pageId: _pageNumber.toString(),
              sort: '',
              searchKeywords: '',
            ),
            ctx: context);
      });
    }
  }

  @override
  void initState() {
    log(runtimeType.toString());
    _pageNumber = 1;
    searchController.isListLoading.value = false;
    scrollController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      searchController.searchApiCall(
          pgName: "searchField",
          searchModel: SearchModel(
            val: widget.category,
            genres: '',
            pageId: _pageNumber.toString(),
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
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: CustomAppBar4(
            title: widget.category.toUpperCase(),
            backBtn: () => Get.off(() => const BottomBar(currentIndex: 0, checkVersion: false)),
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: Scrollbar(
            scrollbarOrientation: ScrollbarOrientation.right,
            thumbVisibility: true,
            interactive: true,
            // controller: scrollController,
            child: SingleChildScrollView(
              // controller: scrollController,
              child: Column(
                children: [
                  Center(
                    child: Obx(() => Visibility(
                      visible: searchController.hasData.value,
                      child: searchController.isPageLoading.value
                          ? SizedBox(
                            height: 55,
                            width: 30,
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: RefreshProgressIndicator(
                                backgroundColor: Colors.transparent,
                                color: appTheme.primaryColor,
                              ),
                            ),
                          )
                          : Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: SimilarList(
                        pg: 'category',
                        similarData: searchController.animeList,
                      ),
                          ),
                    )),
                  ),
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
      ),
    );
  }
}
