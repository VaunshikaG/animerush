import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../podo/HomePodo.dart';
import '../utils/ApiService.dart';
import '../utils/CommonStyle.dart';
import '../utils/Loader.dart';
import '../utils/theme.dart';
import '../widgets/CustomScreenRoute.dart';
import '../widgets/CustomSnackbar.dart';
import 'Details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int activeindex = 0;

  late AnimationController _controller;
  late Animation _animation;
  late Animation padding;

  @override
  void initState() {
    log(runtimeType.toString());
    homeApiCall();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 275),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
        parent: _controller, curve: Curves.ease, reverseCurve: Curves.easeIn));
    padding = Tween(begin: 0.0, end: -25.0).animate(CurvedAnimation(
        parent: _controller, curve: Curves.ease, reverseCurve: Curves.easeIn));
    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomTheme.transparent,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: SizedBox(
            height: double.infinity,
            child: (apiStatus == 200)
                ? ListView(
                    children: [
                      FittedBox(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CarouselSlider.builder(
                            itemCount: spotlightData.length,
                            itemBuilder: (BuildContext context, index, _) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: CustomTheme.white,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      spotlightData[index].banner ??
                                          spotlightData[index].aniImage.toString(),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: CustomTheme.white24.withOpacity(0.5),
                                    gradient: RadialGradient(
                                      radius: 0.8,
                                      center: Alignment(0.7, 0),
                                      colors: [
                                        CustomTheme.transparent,
                                        CustomTheme.transparent,
                                        CustomTheme.transparent,
                                        CustomTheme.black12,
                                        // CustomTheme.black38,
                                        CustomTheme.black54,
                                        CustomTheme.black87,
                                      ],
                                    ),
                                    // gradient: LinearGradient(
                                    //   begin: Alignment.centerLeft,
                                    //   end: Alignment.centerRight,
                                    //   tileMode: TileMode.mirror,
                                    //   CustomTheme: (index % 2 == 0)
                                    //       ? [
                                    //           CustomTheme.black87,
                                    //           CustomTheme.black54,
                                    //           CustomTheme.black38,
                                    //           CustomTheme.black12,
                                    //           CustomTheme.black12,
                                    //         ]
                                    //       : [
                                    //           CustomTheme.white38,
                                    //           CustomTheme.white10,
                                    //           CustomTheme.transparent,
                                    //           CustomTheme.transparent,
                                    //         ],
                                    // ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 10),
                                        child: Text(
                                          "#${index + 1} Spotlight",
                                          style: TextStyle(
                                            color: CustomTheme.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 20),
                                        child: Text(
                                          spotlightData[index].name!,
                                          style: TextStyle(
                                            color: CustomTheme.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: CupertinoButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                CustomScreenRoute(
                                                  child: Details(id:
                                                  spotlightData[index].id.toString()),
                                                  direction:
                                                      AxisDirection.up,
                                                ));
                                          },
                                          color: CustomTheme.grey3,
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0,
                                                  horizontal: 10),
                                          disabledColor: CustomTheme.white,
                                          pressedOpacity: 0.6,
                                          borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                          child: SizedBox(
                                            width: 55,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons
                                                      .info_circle_fill,
                                                  size: 14,
                                                  color: CustomTheme.white,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "Details",
                                                  style: TextStyle(
                                                    color:
                                                        CustomTheme.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontFamily: "Quicksand",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        height: 30,
                                        child: CupertinoButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                CustomScreenRoute(
                                                  child: Details(id:
                                                  spotlightData[index].id.toString()),
                                                  direction:
                                                      AxisDirection.up,
                                                ));
                                          },
                                          color: CustomTheme.themeColor1,
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0,
                                                  horizontal: 10),
                                          disabledColor: CustomTheme.white,
                                          pressedOpacity: 0.6,
                                          borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                          child: SizedBox(
                                            width: 90,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons
                                                      .play_circle_fill,
                                                  size: 15,
                                                  color: CustomTheme
                                                      .themeColor2,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  "Watch Now",
                                                  style: TextStyle(
                                                    color: CustomTheme
                                                        .themeColor2,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontFamily: "Quicksand",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              onPageChanged: (index, _) {
                                setState(() => activeindex = index);
                              },
                              height: 200,
                              autoPlay: true,
                              pageSnapping: true,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              viewportFraction: 1.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        child: AnimatedSmoothIndicator(
                          curve: Curves.easeInCirc,
                          activeIndex: activeindex,
                          axisDirection: Axis.horizontal,
                          count: spotlightData.length,
                          effect: ExpandingDotsEffect(
                            dotHeight: 3,
                            dotWidth: 18,
                            activeDotColor: CustomTheme.themeColor1,
                            dotColor: CustomTheme.grey2,
                          ),
                        ),
                      ),

                      //  trending
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 20, 0, 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Trending",
                          style: TextStyle(
                            color: CustomTheme.themeColor1,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      trending(),

                      //  types
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          leading: Text(
                            "Special",
                            style: TextStyle(
                              color: CustomTheme.themeColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: () {},
                            child: Text(
                              "View all >",
                              style: TextStyle(
                                color: CustomTheme.themeColor1,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          tileColor: CustomTheme.grey2,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      // specials(),

                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          leading: Text(
                            "Movies",
                            style: TextStyle(
                              color: CustomTheme.themeColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: () {},
                            child: Text(
                              "View all >",
                              style: TextStyle(
                                color: CustomTheme.themeColor1,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          tileColor: CustomTheme.grey2,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      // movies(),

                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          leading: Text(
                            "ONA",
                            style: TextStyle(
                              color: CustomTheme.themeColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: () {},
                            child: Text(
                              "View all >",
                              style: TextStyle(
                                color: CustomTheme.themeColor1,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          tileColor: CustomTheme.grey2,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      // ona(),

                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          leading: Text(
                            "OVA",
                            style: TextStyle(
                              color: CustomTheme.themeColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: () {},
                            child: Text(
                              "View all >",
                              style: TextStyle(
                                color: CustomTheme.themeColor1,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          tileColor: CustomTheme.grey2,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      // ova(),
                    ],
                  )
                : Visibility(
                    visible: noData,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/luffy1.png',
                            width: 200,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Oops, failed to load data!",
                            style: TextStyle(
                              fontSize: 17,
                              color: CustomTheme.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget trending() {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        itemCount: topData.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          int? iD = topData[index].id;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CustomScreenRoute(
                    child: Details(id: topData[index].id.toString()),
                    direction: AxisDirection.up,
                  ));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 0),
              height: 150,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    width: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.zero,
                    color: CustomTheme.grey1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: RotatedBox(
                                  quarterTurns: -1,
                                  child: SizedBox(
                                    width: 120,
                                    child: Text(
                                      topData[index].name!,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: CustomTheme.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: CustomTheme.themeColor1,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    width: 130,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/img/icon1.png",
                        image: topData[index].aniImage.toString(),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/img/icon1.png",
                            fit: BoxFit.contain,
                          );
                        },
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget specials() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemCount: specialData.length,
        itemBuilder: (BuildContext listCtx, int index) {
          if(specialData[index].animeWatchType == 'SP') {
            animeType = "Special";
          } else {
            animeType = "-";
          }

          if(specialData[index].status == 'C') {
            status = "Completed";
          } else if(specialData[index].status == 'O') {
            status = "Ongoing";
          } else {
            status = "-";
          }

          year = specialData[index].airedYear;

          img = specialData[index].aniImage.toString();
          if(img == null) {
            setState(() {
              img = specialData[index].imageHighQuality.toString();
            });
          }

          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  CustomScreenRoute(
                    child: Details(id: specialData[index].id.toString()),
                    direction: AxisDirection.up,
                  ));
            },
            leading: SizedBox(
              height: 100,
              width: 50,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/img/icon1.png",
                image: img,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/img/icon1.png",
                    fit: BoxFit.contain,
                  );
                },
                fit: BoxFit.contain,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                specialData[index].name!,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: CustomTheme.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "$animeType   •   $status   •   $year",
                style: TextStyle(
                  color: CustomTheme.white,
                  fontSize: 13,
                ),
              ),
            ),
            dense: true,
            tileColor: (index % 2 == 0) ? CustomTheme.grey3 : CustomTheme.grey2,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          );
        },
      ),
    );
  }

  Widget movies() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemCount: moviesData.length,
        itemBuilder: (BuildContext listCtx, int index) {
          if(moviesData[index].animeWatchType == 'M') {
            animeType = "Movie";
          } else {
            animeType = "-";
          }

          if(moviesData[index].status == 'C') {
            status = "Completed";
          } else if(moviesData[index].status == 'O') {
            status = "Ongoing";
          } else {
            status = "-";
          }

          year = moviesData[index].airedYear;

          img = moviesData[index].aniImage.toString();
          img ??= moviesData[index].imageHighQuality.toString();

          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  CustomScreenRoute(
                    child: Details(id: moviesData[index].id.toString()),
                    direction: AxisDirection.up,
                  ));
            },
            leading: SizedBox(
              height: 100,
              width: 50,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/img/icon1.png",
                image: img,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/img/icon1.png",
                    fit: BoxFit.contain,
                  );
                },
                fit: BoxFit.contain,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                moviesData[index].name!,
                style: TextStyle(
                  color: CustomTheme.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "$animeType   •   $status   •   $year",
                style: TextStyle(
                  color: CustomTheme.white,
                  fontSize: 13,
                ),
              ),
            ),
            dense: true,
            tileColor: (index % 2 == 0) ? CustomTheme.grey3 : CustomTheme.grey2,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          );
        },
      ),
    );
  }

  Widget ona() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemCount: onasData.length,
        itemBuilder: (BuildContext listCtx, int index) {
          if(onasData[index].animeWatchType == 'ON') {
            animeType = "Onas";
          } else {
            animeType = "-";
          }

          if(onasData[index].status == 'C') {
            status = "Completed";
          } else if(onasData[index].status == 'O') {
            status = "Ongoing";
          } else {
            status = "-";
          }

          year = onasData[index].airedYear;

          img = onasData[index].aniImage.toString();
          img ??= onasData[index].imageHighQuality.toString();

          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  CustomScreenRoute(
                    child: Details(id: onasData[index].id.toString()),
                    direction: AxisDirection.up,
                  ));
            },
            leading: SizedBox(
              height: 100,
              width: 50,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/img/icon1.png",
                image: img,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/img/icon1.png",
                    fit: BoxFit.contain,
                  );
                },
                fit: BoxFit.contain,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                onasData[index].name!,
                style: TextStyle(
                  color: CustomTheme.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "$animeType   •   $status   •   $year",
                style: TextStyle(
                  color: CustomTheme.white,
                  fontSize: 13,
                ),
              ),
            ),
            dense: true,
            tileColor: (index % 2 == 0) ? CustomTheme.grey3 : CustomTheme.grey2,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          );
        },
      ),
    );
  }

  Widget ova() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemCount: ovasData.length,
        itemBuilder: (BuildContext listCtx, int index) {
          if(ovasData[index].animeWatchType == 'OV') {
            animeType = "Ovas";
          } else {
            animeType = "-";
          }

          if(ovasData[index].status == 'C') {
            status = "Completed";
          } else if(ovasData[index].status == 'O') {
            status = "Ongoing";
          } else {
            status = "-";
          }

          year = ovasData[index].airedYear;

          img = ovasData[index].aniImage.toString();
          img ??= ovasData[index].imageHighQuality.toString();

          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  CustomScreenRoute(
                    child: Details(id: ovasData[index].id.toString()),
                    direction: AxisDirection.up,
                  ));
            },
            leading: SizedBox(
              height: 100,
              width: 50,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/img/icon1.png",
                image: img,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/img/icon1.png",
                    fit: BoxFit.contain,
                  );
                },
                fit: BoxFit.contain,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                ovasData[index].name!,
                style: TextStyle(
                  color: CustomTheme.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "$animeType   •   $status   •   $year",
                style: TextStyle(
                  color: CustomTheme.white,
                  fontSize: 13,
                ),
              ),
            ),
            dense: true,
            tileColor: (index % 2 == 0) ? CustomTheme.grey3 : CustomTheme.grey2,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          );
        },
      ),
    );
  }

  bool noData = false;
  var apiStatus, animeType, year, status, img;
  List<IsSpotlightData> spotlightData = [];
  List<TopStreamingData> topData = [];
  List<LatestMoviesData> moviesData = [];
  List<LatestSpecialData> specialData = [];
  List<LatestOnasData> onasData = [];
  List<LatestOvasData> ovasData = [];
  List<RecentlyAddedSubData> subData = [];
  List<RecentlyAddedDubData> dubData = [];

  void homeApiCall() async {
    final prefs = await SharedPreferences.getInstance();
    await showProgress(context, "Please wait...", true);

    APIService apiService = new APIService();
    apiService.HomeApi().then((value) {
      try {
        if (value != null) {
          var responsebody = json.decode(value);
          HomePodo homePodo = HomePodo.fromJson(responsebody);
          apiStatus = responsebody["st"];
          hideProgress();
          if (apiStatus == 200) {
            setState(() {
              hideProgress();
              spotlightData = homePodo.isSpotlightData!;
              topData = homePodo.topStreamingData!;
              moviesData = homePodo.latestMoviesData!;
              specialData = homePodo.latestSpecialData!;
              onasData = homePodo.latestOnasData!;
              ovasData = homePodo.latestOvasData!;
              subData = homePodo.recentlyAddedSubData!;
              dubData = homePodo.recentlyAddedDubData!;
            });
          } else {
            hideProgress();
            noData = true;
            // CustomSnackBar(context, Text(homePodo.msg!));
          }
        }
      } catch (e) {
        rethrow;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
