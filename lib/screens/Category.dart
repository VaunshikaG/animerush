import 'dart:developer';

import 'package:animerush/screens/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/SearchController.dart';
import '../model/RqModels.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomButtons.dart';
import '../widgets/NoData.dart';
import '../widgets/SimilarList.dart';

class Category extends StatefulWidget {
  final String category;
  const Category({Key? key, required this.category}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Search_Controller searchController = Get.put(Search_Controller());
  ScrollController scrollController = ScrollController();
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
        Get.off(() => const BottomBar(currentIndex: 0));
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: CustomAppBar4(
            title: widget.category.toUpperCase(),
            backBtn: () => Get.off(() => const BottomBar(currentIndex: 0)),
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
            controller: scrollController,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SingleChildScrollView(
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
                            : SimilarList(
                          pg: 'category',
                          similarData: searchController.animeList,
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
      ),
    );
  }
}
