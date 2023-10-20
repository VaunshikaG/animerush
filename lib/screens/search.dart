import 'dart:developer';

import 'package:animerush/widgets/animeAnimation.dart';
import 'package:animerush/widgets/customSnackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import '../controllers/searchController.dart';
import '../model/rqModels.dart';
import '../utils/appConst.dart';
import '../widgets/customButtons.dart';
import '../widgets/loader.dart';
import '../widgets/noData.dart';
import '../widgets/similarList.dart';
import 'bottomBar.dart';
import 'auth.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

Search_Controller searchController = Get.put(Search_Controller());
ScrollController scrollController = ScrollController();

class _SearchState extends State<Search> with IronSourceBannerListener {
  List<Map<String, dynamic>> categoryData = [
    {'title': 'Movies', 'value': 'movies'},
    {'title': 'TV Series', 'value': 'tv'},
    {'title': 'OVAs', 'value': 'ova'},
    {'title': 'ONAs', 'value': 'ona'},
    {'title': 'Specials', 'value': 'specials'},
    {'title': 'Completed', 'value': 'completed-anime'},
    {'title': 'Ongoing', 'value': 'ongoing-anime'},
    {'title': 'Subbed', 'value': 'subbed-anime'},
    {'title': 'Dubbed', 'value': 'dubbed-anime'},
  ];
  List<Map<String, dynamic>> genreData = [
    {'title': 'Comedy', 'icon': 'assets/icons/comedy.png', 'value': 'comedy'},
    {'title': 'Sci-Fi', 'icon': 'assets/icons/scifi.png', 'value': 'scifi'},
    {'title': 'Horror', 'icon': 'assets/icons/horror.png', 'value': 'horror'},
    {'title': 'Romance', 'icon': 'assets/icons/love.png', 'value': 'romance'},
    {'title': 'Action', 'icon': 'assets/icons/action.png', 'value': 'action'},
    {
      'title': 'Fantasy',
      'icon': 'assets/icons/fantasy.png',
      'value': 'fantasy'
    },
    {'title': 'Cars', 'icon': 'assets/icons/cars.png', 'value': 'cars'},
    {'title': 'Space', 'icon': 'assets/icons/space.png', 'value': 'space'},
    {
      'title': 'Psychological',
      'icon': 'assets/icons/psycho.png',
      'value': 'psychological'
    },
    {'title': 'Music', 'icon': 'assets/icons/music.png', 'value': 'music'},
    {
      'title': 'Vampire',
      'icon': 'assets/icons/vampire.png',
      'value': 'vampire'
    },
  ];

  List<CategoryTitle> categoryNames = [];
  List<GenreTitle> genreNames = [];

  bool isBannerLoaded = false;
  bool bannerCapped = false;
  final size = IronSourceBannerSize.BANNER;

  @override
  void initState() {
    initAds();
    debugPrint(runtimeType.toString());
    searchController.value1 = "";
    searchController.categoryType = "";
    searchController.value2 = "";
    searchController.genreType = "";
    searchController.isTyping.value = false;
    searchController.noData.value = false;
    searchController.hasData.value = false;
    searchController.showLogin.value = false;
    searchController.showChips.value = true;

    //  text chip
    // genreNames = genreTitle.map((name) => GenreTitle(name)).toList();
    categoryNames = categoryData
        .map((map) => CategoryTitle(map['title'], map['value']))
        .toList();
    genreNames = genreData
        .map((map) => GenreTitle(map['title'], map['icon'], map['value']))
        .toList();

    // WidgetsBinding.instance.addPostFrameCallback((timestamp) {
    //     searchController.searchApiCall(
    //         pgName: "",
    //         searchModel: SearchModel(
    //           val: 'anime',
    //           searchKeywords: '',
    //           genres: '',
    //           pageId: '1',
    //           sort: '',
    //         ),
    //         ctx: context);
    // });
    super.initState();
  }

  Future<void> initAds() async {
    IronSource.setBannerListener(this);
    if (!bannerCapped) {
      bannerCapped = await IronSource.isBannerPlacementCapped('DefaultBanner');
      log('Banner DefaultBanner capped: $bannerCapped');
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
    log("onBannerAdClicked");
  }

  @override
  void onBannerAdLoadFailed(IronSourceError error) {
    log("onBannerAdLoadFailed Error:$error");
    if (mounted) {
      setState(() {
        isBannerLoaded = false;
      });
    }
  }

  @override
  void onBannerAdLoaded() {
    log("onBannerAdLoaded");
    if (mounted) {
      setState(() {
        isBannerLoaded = true;
      });
    }
  }

  @override
  void onBannerAdScreenDismissed() {
    log("onBannerAdScreenDismissed");
  }

  @override
  void onBannerAdScreenPresented() {
    log("onBannerAdScreenPresented");
  }

  @override
  void onBannerAdLeftApplication() {
    log("onBannerAdLeftApplication");
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.071),
              child: ListView(
                controller: scrollController,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom),
                children: [
                  (searchController.showLogin.value == true)
                      ? const SizedBox()
                      : CupertinoSearchTextField(
                          controller: searchController.searchText,
                          placeholder: 'Search',
                          placeholderStyle: appTheme.textTheme.titleMedium,
                          keyboardType: TextInputType.text,
                          onSubmitted: (value) {
                            searchController.animeList.clear();

                            setState(() {
                              if (value.isNotEmpty) {
                                searchController.searchApiCall(
                                    pgName: "searchField",
                                    searchModel: SearchModel(
                                      val: 'anime',
                                      searchKeywords: value,
                                      genres: '',
                                      pageId: '1',
                                      sort: '',
                                    ),
                                    context: context);
                              }
                            });

                            searchController.value1 = "";
                            searchController.categoryType = "";
                            searchController.value2 = "";
                            searchController.genreType = "";
                          },
                          style: appTheme.textTheme.titleMedium,
                          prefixIcon: Icon(
                            CupertinoIcons.search,
                            size: 23,
                            color: appTheme.primaryColor,
                          ),
                          suffixIcon: Icon(
                            CupertinoIcons.clear_circled_solid,
                            size: 20,
                            color: appTheme.iconTheme.color,
                          ),
                          onTap: () => searchController.isTyping.value = true,
                          backgroundColor: appTheme.splashColor.withOpacity(0.25),
                          suffixInsets: const EdgeInsets.only(right: 15),
                        ),
                  Obx(() => Visibility(
                        visible: searchController.showChips.value,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 20, 0, 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Anime Type",
                                style: appTheme.textTheme.labelMedium,
                              ),
                            ),
                            categoryChips(),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 15, 0, 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Genre",
                                style: appTheme.textTheme.labelMedium,
                              ),
                            ),
                            genreChips(),

                            /*ExpansionTile(
                        title: Text(
                          "Genre",
                          style: appTheme.textTheme.labelMedium,
                        ),
                        children: [
                          Wrap(
                            spacing: -5,
                            runSpacing: -15,
                            children: genreChips.toList(),
                          )
                        ],
                      ),*/
                          ],
                        ),
                      )),
                  Obx(() => Visibility(
                        visible: searchController.hasData.value,
                        child: searchController.animeList.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      searchController.displayName,
                                      style: appTheme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  SimilarList(
                                    pg: 'search',
                                    similarData: searchController.animeList,
                                  ),
                                  ListTile(
                                    leading: (searchController.previousPg ==
                                            searchController.currentPg)
                                        ? const SizedBox.shrink()
                                        : ElevatedButton.icon(
                                            onPressed: () {
                                              if (searchController.value1.isNotEmpty || searchController.value2.isNotEmpty) {
                                                if (searchController.isSelected.value == true) {
                                                  searchController.searchApiCall(
                                                      pgName: "pagination",
                                                      searchModel: SearchModel(
                                                        val: searchController.value1,
                                                        genres: searchController.value2,
                                                        searchKeywords: searchController.searchText.text,
                                                        pageId: searchController.previousPg.toString(),
                                                        sort: '',
                                                      ),
                                                      context: context);
                                                } else {
                                                  searchController.searchApiCall(
                                                      pgName: "pagination",
                                                      searchModel: SearchModel(
                                                        val: 'anime',
                                                        genres: searchController.value2,
                                                        searchKeywords: searchController.searchText.text,
                                                        pageId: searchController.previousPg.toString(),
                                                        sort: '',
                                                      ),
                                                      context: context);
                                                }
                                              } else if (searchController.searchText.text.isNotEmpty) {
                                                searchController.searchApiCall(
                                                    pgName: "searchField",
                                                    searchModel: SearchModel(
                                                      val: 'anime',
                                                      searchKeywords: searchController.searchText.text,
                                                      genres: '',
                                                      pageId: searchController.previousPg.toString(),
                                                      sort: '',
                                                    ),
                                                    context: context);
                                              }
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
                                              if (searchController.value1.isNotEmpty || searchController.value2.isNotEmpty) {
                                                  if (searchController.isSelected.value == true) {
                                                    searchController.searchApiCall(
                                                        pgName: "pagination",
                                                        searchModel: SearchModel(
                                                          val: searchController.value1,
                                                          genres:
                                                          searchController.value2,
                                                          searchKeywords:
                                                          searchController
                                                              .searchText.text,
                                                          pageId: searchController
                                                              .nextPg
                                                              .toString(),
                                                          sort: '',
                                                        ),
                                                        context: context);
                                                  } else {
                                                    searchController.searchApiCall(
                                                        pgName: "pagination",
                                                        searchModel: SearchModel(
                                                          val: 'anime',
                                                          genres: searchController.value2,
                                                          searchKeywords:
                                                          searchController
                                                              .searchText.text,
                                                          pageId: searchController
                                                              .nextPg
                                                              .toString(),
                                                          sort: '',
                                                        ),
                                                        context: context);
                                                  }
                                                } else if (searchController.searchText.text.isNotEmpty) {
                                                searchController.searchApiCall(
                                                    pgName: "searchField",
                                                    searchModel: SearchModel(
                                                      val: 'anime',
                                                      searchKeywords: searchController.searchText.text,
                                                      genres: '',
                                                      pageId: searchController.nextPg.toString(),
                                                      sort: '',
                                                    ),
                                                    context: context);
                                              }
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
                              )
                            : noData("Oops, no data found!"),
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // single chip selection
  Widget categoryChips() {
    final appTheme = Theme.of(context);
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryData.length,
        itemBuilder: (BuildContext context, int index) {
          final item = categoryData[index];
          return Container(
            margin: const EdgeInsets.only(right: 7),
            child: FilterChip(
              label: Text(item['title']),
              labelStyle: appTheme.textTheme.bodySmall,
              selected: searchController.categoryType.contains(item['title']),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    searchController.categoryType = item['title'];
                    if (searchController.categoryType == item['title']) {
                      searchController.value1 = item['value'];
                    }
                  } else {
                    searchController.categoryType = "";
                    searchController.value1 = "";
                  }
                  if (searchController.value1.isNotEmpty) {
                    searchController.isSelected.value = true;
                    searchController.searchApiCall(
                        pgName: "chips",
                        searchModel: SearchModel(
                          val: searchController.value1,
                          genres: searchController.value2,
                          pageId: '1',
                          sort: '',
                          searchKeywords: searchController.searchText.text,
                        ),
                        context: context);
                  }
                });
              },
              backgroundColor: appTheme.disabledColor,
              disabledColor: appTheme.disabledColor,
              selectedColor: appTheme.hoverColor,
              elevation: 2,
              showCheckmark: false,
              side: BorderSide.none,
              padding: const EdgeInsets.all(5),
            ),
          );
        },
      ),
    );
  }

  Widget genreChips() {
    final appTheme = Theme.of(context);
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genreData.length,
        itemBuilder: (BuildContext context, int index) {
          final item = genreData[index];
          return Container(
            margin: const EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
              color: appTheme.hintColor.withOpacity(0.6),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: FilterChip(
              label: SizedBox(
                width: 55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: appTheme.disabledColor,
                      radius: 28,
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Image.asset(item['icon']),
                      ),
                    ),
                    // Image.asset(item['icon'], height: 30,),
                    Text(
                      item['title'],
                      style: appTheme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              labelStyle: appTheme.textTheme.titleSmall,
              selected: searchController.genreType.contains(item['title']),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    searchController.genreType = item['title'];
                    if (searchController.genreType == item['title']) {
                      searchController.value2 = item['value'];
                    }
                    if (searchController.value2.isNotEmpty) {
                      if (searchController.isSelected.value == true) {
                        searchController.searchApiCall(
                            pgName: "chips",
                            searchModel: SearchModel(
                              val: searchController.value1,
                              genres: searchController.value2,
                              pageId: '1',
                              sort: '',
                              searchKeywords: searchController.searchText.text,
                            ),
                            context: context);
                      } else {
                        searchController.searchApiCall(
                            pgName: "chips",
                            searchModel: SearchModel(
                              val: 'anime',
                              genres: searchController.value2,
                              pageId: '1',
                              sort: '',
                              searchKeywords: searchController.searchText.text,
                            ),
                            context: context);
                      }
                    }
                  } else {
                    searchController.genreType = "";
                    searchController.value2 = "";
                  }
                });
              },
              backgroundColor: appTheme.disabledColor,
              disabledColor: appTheme.disabledColor,
              selectedColor: appTheme.hoverColor,
              visualDensity: const VisualDensity(vertical: 3),
              elevation: 2,
              showCheckmark: false,
              side: BorderSide.none,
              padding: const EdgeInsets.all(3),
            ),
          );
        },
      ),
    );
  }

  //  text chip
  Iterable<Widget> get genreChips1 sync* {
    final appTheme = Theme.of(context);

    for (GenreTitle item in genreNames) {
      yield Padding(
        padding: const EdgeInsets.all(5.3),
        child: FilterChip(
          label: Text(
            item.title,
            style: appTheme.textTheme.bodySmall,
            softWrap: true,
          ),
          selected: searchController.genreType.contains(item.title),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                searchController.genreType = item.title;
                if (searchController.genreType == item.title) {
                  searchController.value2 = item.value;
                }
              } else {
                searchController.genreType = "";
                searchController.value2 = "";
              }
              searchController.searchApiCall(
                  pgName: "drawer",
                  searchModel: SearchModel(
                    val: searchController.value1,
                    genres: searchController.value2,
                    pageId: '1',
                    sort: '',
                    searchKeywords: '',
                  ),
                  context: context);
            });
          },
          backgroundColor: appTheme.disabledColor,
          disabledColor: appTheme.disabledColor,
          selectedColor: appTheme.primaryColor,
          elevation: 2,
          showCheckmark: false,
          side: BorderSide.none,
        ),
      );
    }
  }

  //  icon chip
  Iterable<Widget> get genreChips2 sync* {
    final appTheme = Theme.of(context);

    for (GenreTitle item in genreNames) {
      yield Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        decoration: BoxDecoration(
          color: appTheme.hintColor.withOpacity(0.6),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: FilterChip(
          label: SizedBox(
            width: 55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: appTheme.disabledColor,
                  radius: 28,
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Image.asset(item.icon),
                  ),
                ),
                // Image.asset(item['icon'], height: 30,),
                Text(
                  item.title,
                  style: appTheme.textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
          labelStyle: appTheme.textTheme.titleSmall,
          selected: searchController.genreType.contains(item.title),
          onSelected: (bool selected) async {
            await showProgress(context, false);
            setState(() {
              if (selected) {
                searchController.genreType = item.title;
                if (searchController.genreType == item.title) {
                  searchController.value2 = item.value;
                }
              } else {
                searchController.genreType = "";
                searchController.value2 = "";
              }
              searchController.searchApiCall(
                  pgName: "drawer",
                  searchModel: SearchModel(
                    val: searchController.value1,
                    genres: searchController.value2,
                    pageId: '1',
                    sort: '',
                    searchKeywords: '',
                  ),
                  context: context);
            });
          },
          backgroundColor: appTheme.disabledColor,
          disabledColor: appTheme.disabledColor,
          selectedColor: const Color(0xFFFFB339),
          // selectedColor: appTheme.primaryColor.withOpacity(0.7),
          visualDensity: const VisualDensity(vertical: 3),
          elevation: 2,
          showCheckmark: false,
          side: BorderSide.none,
          padding: const EdgeInsets.all(3),
        ),
      );
    }
  }

  //  multiple chips selection
/*

  Widget categoryChips() {
    final appTheme = Theme.of(context);
    return SizedBox(
      height: 50,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width,
            crossAxisSpacing: 0,
            mainAxisSpacing: 5,
            childAspectRatio: 0.6,
          ),
          itemCount: categoryTitle.length,
          itemBuilder: (BuildContext ctx, index) {
            return FilterChip(
              label: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(categoryTitle[index]),
              ),
              labelStyle: appTheme.textTheme.bodySmall,
              selected: categoryFilter.contains(categoryTitle[index]),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    categoryFilter.add(categoryTitle[index]);
                  } else {
                    categoryFilter.removeWhere((String name) {
                      return name == categoryTitle[index];
                    });
                  }
                });
              },
              backgroundColor: appTheme.disabledColor,
              disabledColor: appTheme.disabledColor,
              selectedColor: appTheme.primaryColor,
              elevation: 2,
              showCheckmark: false,
              side: BorderSide.none,
            );
          }),
    );
  }

  Iterable<Widget> get genreChips sync* {
    final appTheme = Theme.of(context);

    for (GenreTitle genre in genreNames) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
              label: Text(genre.name),
              labelStyle: appTheme.textTheme.bodySmall,
          selected: genreFilter.contains(genre.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                genreFilter.add(genre.name);
              } else {
                genreFilter.removeWhere((String name) {
                  return name == genre.name;
                });
              }
            });
          },
          backgroundColor: appTheme.disabledColor,
          disabledColor: appTheme.disabledColor,
          selectedColor: appTheme.primaryColor,
          elevation: 2,
          showCheckmark: false,
          side: BorderSide.none,
        ),
      );
    }
  }
*/
}

//  text chip
class GenreTitle1 {
  const GenreTitle1(this.name);
  final String name;
}

//  icon chip
class GenreTitle {
  const GenreTitle(this.title, this.icon, this.value);
  final String title, icon, value;
}

class CategoryTitle {
  const CategoryTitle(this.title, this.value);
  final String title, value;
}
