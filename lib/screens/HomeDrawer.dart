import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
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
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return false;
        },
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            alignment: Alignment.topLeft,
            height: MediaQuery.of(context).size.height / 1,
            width: 250,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Drawer(
              shape: const Border.symmetric(vertical: BorderSide()),
              backgroundColor: CustomTheme.blur,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // width: 50,
                    // height: 40,
                    child: CupertinoButton(
                      onPressed: () => Navigator.of(context).pop(),
                      color: CustomTheme.blur3,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      disabledColor: CustomTheme.white,
                      pressedOpacity: 0.6,
                      borderRadius:
                      const BorderRadius.all(
                          Radius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons
                                .chevron_left,
                            size: 16,
                            color: CustomTheme.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Close menu",
                            style: TextStyle(
                              color: CustomTheme.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ListView.builder(
                      itemCount: title.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
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
