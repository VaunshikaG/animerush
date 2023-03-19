import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/theme.dart';
import '../widgets/CustomScreenRoute.dart';
import 'Home.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return false;
        },
        child: Container(
          alignment: Alignment.topLeft,
          height: MediaQuery.of(context).size.height / 1,
          width: 250,
          child: Drawer(
            shape: const Border.symmetric(vertical: BorderSide()),
            backgroundColor: CustomTheme.grey3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 10),
                    width: 120,
                    height: 40,
                    child: CupertinoButton(
                      onPressed: () => Navigator.of(context).pop(),
                      color: CustomTheme.grey1,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      disabledColor: CustomTheme.white,
                      pressedOpacity: 0.6,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              CupertinoIcons.chevron_left,
                              size: 16,
                              color: CustomTheme.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Close menu",
                              style: TextStyle(
                                color: CustomTheme.white,
                                fontSize: 13,
                                fontFamily: "Quicksand",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 250,
                    color: CustomTheme.grey1,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      itemCount: menu.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return CupertinoButton(
                          onPressed: () => Navigator.of(context).pop(),
                          color: CustomTheme.grey1,
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          disabledColor: CustomTheme.white,
                          pressedOpacity: 0.6,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  menuIcon[index],
                                  color: CustomTheme.themeColor1,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  menu[index],
                                  style: TextStyle(
                                    color: CustomTheme.white,
                                    fontSize: 13,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ListView.builder(
                    itemCount: title.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                          alignment: Alignment.centerLeft,
                        ),
                        child: Text(
                          title[index],
                          style: TextStyle(
                            fontSize: 15,
                            color: CustomTheme.white,
                          ),
                        ),
                      );
                    },
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 6 / 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    itemCount: genre.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext ctx, index) {
                      return OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                          alignment: Alignment.centerLeft,
                        ),
                        child: Text(
                          genre[index],
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 14.5,
                            color: ColorList[index % ColorList.length],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
