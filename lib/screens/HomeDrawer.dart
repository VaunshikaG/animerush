import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../utils/AppTheme.dart';
import '../utils/theme.dart';

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
  var themeMode;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    themeMode = (SchedulerBinding.instance.window.platformBrightness == Brightness.light);

    return SafeArea(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Container(
          alignment: Alignment.topLeft,
          height: MediaQuery.of(context).size.height / 1,
          width: 250,
          child: Drawer(
            shape: const Border.symmetric(vertical: BorderSide()),
            // backgroundColor: appTheme.colorScheme.surface,
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
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                  Container(
                    height: 70,
                    width: 250,
                    color: appTheme.disabledColor,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      itemCount: menu.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return CupertinoButton(
                          onPressed: () => Navigator.of(context).pop(),
                          color: appTheme.colorScheme.surface,
                          padding: const EdgeInsets.symmetric(vertical: 0,
                              horizontal: 17),
                          disabledColor: appTheme.disabledColor,
                          pressedOpacity: 0.6,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  menuIcon[index],
                                  color: appTheme.iconTheme.color,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  menu[index],
                                  style: appTheme.textTheme.titleSmall,
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
                        style: AppTheme.outlinedBtn1,
                        child: Text(
                          title[index],
                          style: appTheme.textTheme.titleSmall,
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext ctx, index) {
                      return OutlinedButton(
                        onPressed: () {},
                        style: AppTheme.outlinedBtn1,
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
