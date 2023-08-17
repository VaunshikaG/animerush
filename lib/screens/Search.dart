import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/SearchController.dart';
import '../model/RqModels.dart';
import '../utils/theme.dart';
import '../widgets/CustomButtons.dart';
import '../widgets/NoData.dart';
import '../widgets/SimilarList.dart';
import 'BottomBar.dart';
import 'Details.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Search_Controller searchController = Get.put(Search_Controller());
  ScrollController scrollController = ScrollController();

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
    {'title': 'Fantasy', 'icon': 'assets/icons/fantasy.png', 'value': 'fantasy'},
    {'title': 'Cars', 'icon': 'assets/icons/cars.png', 'value': 'cars'},
    {'title': 'Space', 'icon': 'assets/icons/space.png', 'value': 'space'},
    {'title': 'Psychological', 'icon': 'assets/icons/psycho.png', 'value': 'psychological'},
    {'title': 'Music', 'icon': 'assets/icons/music.png', 'value': 'music'},
    {'title': 'Vampire', 'icon': 'assets/icons/vampire.png', 'value': 'vampire'},
  ];

  List<CategoryTitle> categoryNames = [];
  List<GenreTitle> genreNames = [];

  @override
  void initState() {
    log(runtimeType.toString());
    searchController.isTyping.value = false;
    searchController.noData.value = false;
    searchController.hasData.value = false;
    searchController.showChips.value = true;
    searchController.showHistory.value = true;


    //  text chip
    // genreNames = genreTitle.map((name) => GenreTitle(name)).toList();
    categoryNames = categoryData.map((map) => CategoryTitle(map['title'], map['value'])).toList();
    genreNames = genreData.map((map) => GenreTitle(map['title'], map['icon'], map['value'])).toList();
    // searchController.searchApiCall(pgName: "searchField", searchModel: SearchModel(
    //       val: 'anime',
    //       genres: '',
    //       pageId: '',
    //       sort: '',
    //     ));
    super.initState();
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
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                CupertinoSearchTextField(
                  placeholder: 'Search',
                  placeholderStyle: appTheme.textTheme.titleMedium,
                  keyboardType: TextInputType.text,
                  onSubmitted: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        if (searchController.searchHistory.length >= 4) {
                          searchController.searchHistory.removeRange(0, 1);
                          searchController.searchHistory.add(value);

                          searchController.searchApiCall(pgName: "searchField",
                              searchModel: SearchModel(
                                val: value,
                                genres: '',
                                pageId: '1',
                                sort: '',
                              ));
                        } else {
                          searchController.searchHistory.add(value);
                          searchController.showChips.value = true;
                          searchController.showHistory.value = true;
                        }
                      }
                    });
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
                  backgroundColor: appTheme.splashColor
                      .withOpacity(0.25),
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
                  visible: searchController.showHistory.value,
                      child: (searchController.searchHistory.isNotEmpty)
                          ? Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (!FocusScope.of(context)
                                      .hasPrimaryFocus) {
                                    FocusScope.of(context)
                                        .unfocus();
                                  }
                                  searchController.searchHistory
                                      .clear();
                                });
                              },
                              style: TextButton.styleFrom(
                                visualDensity: const VisualDensity(
                                    vertical: -2),
                                padding: const EdgeInsets.fromLTRB(
                                    0, 5, 10, 0),
                              ),
                              child: Text(
                                "Clear All",
                                style:
                                appTheme.textTheme.labelMedium,
                              ),
                            ),
                          ),
                          ListView.builder(
                            itemCount: searchController
                                .searchHistory.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder:
                                (BuildContext context, int index) {
                              return ListTile(
                                leading: IconButton(
                                  icon: Icon(
                                    CupertinoIcons.search,
                                    size: 17,
                                    color: appTheme.primaryColor,
                                  ),
                                  onPressed: () {
                                    if (!FocusScope.of(context)
                                        .hasPrimaryFocus) {
                                      FocusScope.of(context)
                                          .unfocus();
                                      searchController
                                          .isTyping.value = false;
                                    }
                                  },
                                ),
                                title: Text(
                                  searchController
                                      .searchHistory[index]
                                      .toString(),
                                  style: appTheme
                                      .textTheme.titleMedium,
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    CupertinoIcons
                                        .clear_circled_solid,
                                    size: 15,
                                    color: appTheme.primaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      searchController.searchHistory
                                          .removeAt(index);
                                    });
                                  },
                                ),
                                horizontalTitleGap: 5,
                                visualDensity: const VisualDensity(
                                    vertical: -4),
                              );
                            },
                          )
                        ],
                      )
                          : Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const Center(
                          child: Text("No search history.."),
                        ),
                      ),
                    )),
                Obx(() => Visibility(
                  visible: searchController.hasData.value,
                      child: Column(
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
                        ],
                      ),
                    )),
                Obx(() => Visibility(
                  visible: searchController.noData.value,
                      child: noData(context),
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
                  searchController.searchApiCall(pgName: "chips",
                      searchModel: SearchModel(
                        val: searchController.value1,
                        genres: searchController.value2,
                        pageId: '1',
                        sort: '',
                      ));
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
              borderRadius: const BorderRadius.all(Radius
                  .circular(10)),
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
                    Text(item['title'], style: appTheme.textTheme.titleSmall,),
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
                  } else {
                    searchController.genreType = "";
                    searchController.value2 = "";
                  }
                  searchController.searchApiCall(
                      pgName: "chips",
                      searchModel: SearchModel(
                        val: searchController.value1,
                        genres: searchController.value2,
                        pageId: '1',
                        sort: '',
                      ));
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


  List<String> title = [
    "One Piece",
    "Chainsaw Man",
    "Naruto Shippuden",
    "Boruto: Naruto Next Generations",
    "Kage No Jitsuryokusha Ni Naritakute!",
    "Bleach: Sennen Kessen-Hen",
    "Blue Lock",
    "Detective Conan",
    "Fumetsu No Anata E 2Nd Season",
    "High School Dxd Hero",
  ];
  List<String> titleImgs = [
    "https://cdnimg.xyz/images/anime/One-piece.jpg",
    "https://cdnimg.xyz/cover/chainsaw-man-1664388043.png",
    "https://cdnimg.xyz/images/anime/naruto_shippuden.jpg",
    "https://cdnimg.xyz/cover/boruto-naruto-next-generations.png",
    "https://cdnimg.xyz/cover/kage-no-jitsuryokusha-ni-naritakute-1664388804.png",
    "https://cdnimg.xyz/cover/bleach-sennen-kessen-hen-1664387572.png",
    "https://cdnimg.xyz/cover/blue-lock-1664387634.png",
    "https://cdnimg.xyz/cover/detective-conan.png",
    "https://cdnimg.xyz/cover/fumetsu-no-anata-e-2nd-season-1662695170.png",
    "https://cdnimg.xyz/cover/high-school-dxd-hero.png",
  ];

  Widget searchResultList() {
    final appTheme = Theme.of(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 160,
      ),
      itemCount: searchController.animeList.length,
      itemBuilder: (BuildContext ctx, index) {
        final searchResultList = searchController.animeList[index];
        final lang, type, status;

        if(searchResultList.type == 'S') {
          lang = "SUB";
        } else if(searchResultList.type == 'D') {
          lang = "DUB";
        } else {
          lang = "-";
        }

        if(searchResultList.animeWatchType == 'ON') {
          type = "Onas";
        } else if(searchResultList.animeWatchType == 'OV') {
          type = "Ovas";
        } else if(searchResultList.animeWatchType == 'M') {
          type = "Movie";
        } else if(searchResultList.animeWatchType == 'SP') {
          type = "Special";
        } else if(searchResultList.animeWatchType == 'S') {
          type = "Series";
        } else {
          type = "-";
        }

        if(searchResultList.status == 'C') {
          status = "Completed";
        } else if(searchResultList.status == 'O') {
          status = "Ongoing";
        } else {
          status = "-";
        }

        return GestureDetector(
          onTap: () {
            Get.off(() => Details(id: searchResultList.id.toString()));
          },
          child: SizedBox(
            height: 220,
            child: Wrap(
              children: [
                Container(
                  height: 220,
                  width: 170,
                  margin: const EdgeInsets.only(left: 6),
                  child: FadeInImage.assetNetwork(
                    alignment: Alignment.center,
                    placeholder: "assets/img/blank.png",
                    image: searchResultList.aniImage ?? searchResultList.imageHighQuality!,
                    fit: BoxFit.fill,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/img/blank.png",
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    // height: 90,
                    width: 170,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: CustomTheme.grey2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (lang == "SUB")
                                    ? appTheme.indicatorColor
                                    : appTheme.colorScheme.error,
                              ),
                              child: Text(
                                lang,
                                style: appTheme.textTheme.labelSmall,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: appTheme.splashColor,
                              ),
                              child: Text(
                                "EP ${searchResultList.episodes}",
                                style: appTheme.textTheme.labelSmall,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          height: 40,
                          child: Text(
                            searchResultList.name ?? "",
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: appTheme.textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "$type  •  $status  •  ${searchResultList.airedYear ?? "-"}",
                          overflow: TextOverflow.ellipsis,
                          style: appTheme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 7),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
                  ));
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
          borderRadius: const BorderRadius.all(Radius
              .circular(10)),
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
                Text(item.title, style: appTheme.textTheme.titleSmall,),
                const SizedBox(height: 4),
              ],
            ),
          ),
          labelStyle: appTheme.textTheme.titleSmall,
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
                  ));
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
