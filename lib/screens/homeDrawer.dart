import 'dart:math';

import 'package:animerush/screens/account.dart';
import 'package:animerush/screens/search.dart';
import 'package:animerush/screens/watchList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/searchController.dart';
import '../model/rqModels.dart';
import '../utils/theme.dart';
import '../widgets/customSnackbar.dart';
import 'bottomBar.dart';
import 'details.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  // Search_Controller searchController = Get.put(Search_Controller());

  List<String> menu = [
    "Anime",
    "Popular",
    "Random",
  ];
  List<IconData> menuIcon = [
    CupertinoIcons.square_grid_2x2_fill,
    CupertinoIcons.star_fill,
    CupertinoIcons.shuffle,
  ];

  List<String> title = [
    "Home",
    "Movies",
    "TV Series",
    "OVAs",
    "ONAs",
    "Specials",
    "Completed",
    "Ongoing",
    "Subbed Anime",
    "Dubbed Anime",
    "Genre",
  ];
  List<String> genre = [
    "Comedy",
    "Harem",
    "Romance",
    "School",
    "Seinen",
    "Action",
    "Fantasy",
    "Shoujo",
    "Parody",
    "Shounen",
    "Super Power",
    "Slice Of Life",
    "Kids",
    "Mecha",
    "Police",
    "Psychological",
    "Sci-Fi",
    "Sports",
    "Drama",
    "Mystery",
    "Supernatural",
    "Vampire",
  ];

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
    {"title": "Comedy", "value": "comedy"},
    {"title": "Harem", "value": "harem"},
    {"title": "Romance", "value": "romance"},
    {"title": "School", "value": "school"},
    {"title": "Seinen", "value": "seinen"},
    {"title": "Action", "value": "action"},
    {"title": "Fantasy", "value": "fantasy"},
    {"title": "Shoujo", "value": "shoujo"},
    {"title": "Parody", "value": "parody"},
    {"title": "Shounen", "value": "shounen"},
    {"title": "Super Power", "value": "super-power"},
    {"title": "Slice Of Life", "value": "slice-of-life"},
    {"title": "Kids", "value": "kids"},
    {"title": "Mecha", "value": "mecha"},
    {"title": "Police", "value": "police"},
    {"title": "Psychological", "value": "psychological"},
    {"title": "Sci-Fi", "value": "scifi"},
    {"title": "Sports", "value": "sports"},
    {"title": "Drama", "value": "drama"},
    {"title": "Mystery", "value": "mystery"},
    {"title": "Supernatural", "value": "supernatural"},
    {"title": "Vampire", "value": "vampire"},
    {"title": "Cgdct", "value": "cgdct"},
    {"title": "Music", "value": "music"},
    {"title": "Magic", "value": "magic"},
    {"title": "Demons", "value": "demons"},
    {"title": "Ecchi", "value": "ecchi"},
    {"title": "Adventure", "value": "adventure"},
    {"title": "Military", "value": "military"},
    {"title": "Historical", "value": "historical"},
    {"title": "Martial Arts", "value": "martial-arts"},
    {"title": "Horror", "value": "horror"},
    {"title": "Mythology", "value": "mythology"},
    {"title": "Isekai", "value": "isekai"},
    {"title": "Space", "value": "space"},
    {"title": "Game", "value": "game"},
    {"title": "Josei", "value": "josei"},
    {"title": "Thriller", "value": "thriller"},
    {"title": "Reincarnation", "value": "reincarnation"},
    {"title": "Iyashikei", "value": "iyashikei"},
    {"title": "Family", "value": "family"},
    {"title": "Comic", "value": "comic"},
    {"title": "Romantic Subtext", "value": "romantic-subtext"},
    {"title": "Gore", "value": "gore"},
    {"title": "Shoujo Ai", "value": "shoujo-ai"},
    {"title": "Childcare", "value": "childcare"},
    {"title": "Gag Humor", "value": "gag-humor"},
    {"title": "Adult Cast", "value": "adult-cast"},
    {"title": "Organized Crime", "value": "organized-crime"},
    {"title": "Boys Love", "value": "boys-love"},
    {"title": "Erotica", "value": "erotica"},
    {"title": "Team Sports", "value": "team-sports"},
    {"title": "Performing Arts", "value": "performing-arts"},
    {"title": "Detective", "value": "detective"},
    {"title": "Dementia", "value": "dementia"},
    {"title": "Strategy Game", "value": "strategy-game"},
    {"title": "Shounen Ai", "value": "shounen-ai"},
    {"title": "Dub", "value": "dub"},
    {"title": "Anthropomorphic", "value": "anthropomorphic"},
    {"title": "Gourmet", "value": "gourmet"},
    {"title": "Time Travel", "value": "time-travel"},
    {"title": "Delinquents", "value": "delinquents"},
    {"title": "Samurai", "value": "samurai"},
    {"title": "Medical", "value": "medical"},
    {"title": "Suspense", "value": "suspense"},
    {"title": "Mahou Shoujo", "value": "mahou-shoujo"},
    {"title": "Work Life", "value": "work-life"},
    {"title": "Crime", "value": "crime"},
    {"title": "Gender Bender", "value": "gender-bender"},
    {"title": "Cars", "value": "cars"},
    {"title": "Yaoi", "value": "yaoi"},
    {"title": "Yuri", "value": "yuri"},
    {"title": "Avant Garde", "value": "avant-garde"},
    {"title": "High Stakes Game", "value": "high-stakes-game"},
    {"title": "Magical Sex Shift", "value": "magical-sex-shift"},
    {"title": "Pets", "value": "pets"},
    {"title": "Workplace", "value": "workplace"},
    {"title": "Visual Arts", "value": "visual-arts"},
    {"title": "Survival", "value": "survival"},
    {"title": "Racing", "value": "racing"},
  ];

  List<String> categoryFilter = [];

  @override
  void initState() {
    print(runtimeType.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return SafeArea(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Container(
          alignment: Alignment.topRight,
          height: MediaQuery.of(context).size.height,
          width: 250,
          child: Drawer(
            shape: const Border.symmetric(vertical: BorderSide()),
            // backgroundColor: appTheme.colorScheme.surface,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15, top: 10),
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appTheme.colorScheme.error,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                        ),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                CupertinoIcons.chevron_left,
                                size: 16,
                                color: appTheme.iconTheme.color,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Close menu",
                                style: appTheme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: appTheme.scaffoldBackgroundColor,
                        child: Image.asset(
                          "assets/img/profile.png",
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Account',
                        style: appTheme.textTheme.titleSmall,
                      ),
                      onTap: () {
                        Get.off(() => const Account());
                      },
                      dense: true,
                      tileColor: appTheme.hintColor,
                      style: ListTileStyle.drawer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      title: Text(
                        'Search',
                        style: appTheme.textTheme.titleSmall,
                      ),
                      onTap: () {
                        Get.off(() => const Search());
                      },
                      dense: true,
                      tileColor: appTheme.hintColor,
                      style: ListTileStyle.drawer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      title: Text(
                        'Watchlist',
                        style: appTheme.textTheme.titleSmall,
                      ),
                      onTap: () {
                        Get.off(() => const WatchList(pg: ''));
                      },
                      dense: true,
                      tileColor: appTheme.hintColor,
                      style: ListTileStyle.drawer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),*/
                    const SizedBox(height: 15),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              searchController.searchApiCall(
                                  pgName: "drawer",
                                  searchModel: SearchModel(
                                    val: 'anime',
                                    genres: '',
                                    pageId: '',
                                    sort: '',
                                    searchKeywords: '',
                                  ),
                                  ctx: context);
                            },
                            color: appTheme.hintColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 17),
                            disabledColor: appTheme.disabledColor,
                            pressedOpacity: 0.6,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.square_grid_2x2_fill,
                                    color: appTheme.iconTheme.color,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Anime',
                                    style: appTheme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          CupertinoButton(
                            onPressed: () {
                              searchController.searchApiCall(
                                  pgName: "drawer",
                                  searchModel: SearchModel(
                                    val: 'popular',
                                    genres: '',
                                    pageId: '',
                                    sort: '',
                                    searchKeywords: '',
                                  ),
                                  ctx: context);
                              },
                            color: appTheme.hintColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 17),
                            disabledColor: appTheme.disabledColor,
                            pressedOpacity: 0.6,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.star_fill,
                                    color: appTheme.iconTheme.color,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Popular',
                                    style: appTheme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          CupertinoButton(
                            onPressed: () {
                              var rng = Random();
                              int min = 1;
                              int max = 13000;
                              int randomNumber = min + rng.nextInt(max - min);
                              Get.offAll(
                                      () => Details(id: randomNumber.toString()));
                              },
                            color: appTheme.hintColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 17),
                            disabledColor: appTheme.disabledColor,
                            pressedOpacity: 0.6,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.shuffle,
                                    color: appTheme.iconTheme.color,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Random',
                                    style: appTheme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ExpansionTile(
                        title: Text(
                          'Anime types',
                          style: appTheme.textTheme.titleSmall,
                        ),
                        collapsedIconColor: appTheme.colorScheme.background,
                        iconColor: appTheme.colorScheme.background,
                        children: [
                          categoryChips(),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ExpansionTile(
                        title: Text(
                          'Genre types',
                          style: appTheme.textTheme.titleSmall,
                        ),
                        collapsedIconColor: appTheme.colorScheme.background,
                        iconColor: appTheme.colorScheme.background,
                        children: [
                          genreChips(),
                        ],
                      ),
                    ),*/
                    categoryChips(),
                    genreChips(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryChips() {
    final appTheme = Theme.of(context);

    return SizedBox(
      height: 430,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: categoryData.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final item = categoryData[index];
          return Container(
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: FilterChip(
              label: SizedBox(
                width: 200,
                child: Text(item['title']),
              ),
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
                  searchController.searchApiCall(
                      pgName: "drawer",
                      searchModel: SearchModel(
                        val: searchController.value1,
                        genres: searchController.value2,
                        pageId: '1',
                        sort: '',
                        searchKeywords: '',
                      ),
                      ctx: context);
                  searchController.isSelected.value = true;
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const BottomBar(currentIndex: 1, checkVersion: false)));
                });
              },
              backgroundColor: appTheme.colorScheme.surface,
              disabledColor: appTheme.colorScheme.surface,
              selectedColor: appTheme.colorScheme.secondary,
              visualDensity: const VisualDensity(vertical: 0),
              elevation: 2,
              showCheckmark: false,
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            ),
          );
        },
      ),
    );
  }

  Widget genreChips() {
    final appTheme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 6 / 2.3,
        ),
        scrollDirection: Axis.vertical,
        itemCount: genreData.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final item = genreData[index];
          return Container(
            margin: const EdgeInsets.only(left: 5),
            alignment: Alignment.centerLeft,
            child: FilterChip(
              label: Text(item['title']),
              labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: ColorList[index % ColorList.length],
              ),
              selected: searchController.genreType.contains(item['title']),
              onSelected: (bool selected) {
                // setState(() {
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
                          ctx: context);
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
                          ctx: context);
                    }
                  }
                } else {
                  searchController.genreType = "";
                  searchController.value2 = "";
                }
                // });

              },
              backgroundColor: appTheme.colorScheme.surface,
              disabledColor: appTheme.colorScheme.surface,
              selectedColor: appTheme.colorScheme.secondary.withOpacity(0.8),
              visualDensity: const VisualDensity(vertical: -1),
              elevation: 2,
              showCheckmark: false,
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            ),
          );
        },
      ),
    );
  }
}
