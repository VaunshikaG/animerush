import 'dart:developer';

import 'package:animerush/screens/category.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controllers/homeController.dart';
import '../widgets/loader.dart';
import '../utils/theme.dart';
import '../widgets/noData.dart';
import 'details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.put(HomeController());
  int activeindex = 0;

  bool isInterstitialAvailable = false;
  bool interstitialCapped = false;
  bool interstitialClosed = false;

  bool isBannerLoaded = false;
  bool bannerCapped = false;

  @override
  void initState() {
    debugPrint(runtimeType.toString());
    homeController.hasData.value = false;
    homeController.noData.value = false;
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      loadData();
    });
    super.initState();
  }

  Future<void> loadData() async {
    await showProgress(context, false);
    // Future.delayed(Duration(seconds: 1), () {});
    homeController.homeApiCall();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.071),
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Obx(() => Visibility(
                          visible: homeController.hasData.value,
                          child: Column(
                            children: [
                              FittedBox(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: CarouselSlider.builder(
                                    itemCount:
                                        homeController.spotlightData.length,
                                    itemBuilder:
                                        (BuildContext context, index, _) {
                                      var img = homeController
                                              .spotlightData[index].banner ??
                                          homeController
                                              .spotlightData[index].aniImage
                                              .toString();
                                      return GestureDetector(
                                        onTap: () {
                                          Get.off(() => Details(
                                              id: homeController
                                                  .spotlightData[index].id
                                                  .toString()));
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            color: appTheme.splashColor,
                                            image: DecorationImage(
                                              image: NetworkImage(img),
                                              fit: BoxFit.cover,
                                              onError: (error, stackTrace) =>
                                                  Image.network(
                                                homeController
                                                    .spotlightData[index]
                                                    .imageHighQuality
                                                    .toString(),
                                                fit: BoxFit.contain,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                    "assets/img/blank.png",
                                                    fit: BoxFit.contain,
                                                  );
                                                },
                                              ),
                                              // onError: (error, stackTrace) =>
                                              //     Image.asset(
                                              //   "assets/img/blank.png",
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: appTheme.splashColor
                                                  .withOpacity(0.5),
                                              gradient: RadialGradient(
                                                radius: 0.8,
                                                center: const Alignment(0.7, 0),
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
                                                    style: appTheme
                                                        .textTheme.titleSmall,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 20),
                                                  child: Text(
                                                    homeController
                                                        .spotlightData[index]
                                                        .name!,
                                                    style: appTheme
                                                        .textTheme.titleMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                  count: homeController.spotlightData.length,
                                  effect: ExpandingDotsEffect(
                                    dotHeight: 3,
                                    dotWidth: 18,
                                    activeDotColor: appTheme.primaryColor,
                                    dotColor: appTheme.colorScheme.secondary,
                                  ),
                                ),
                              ),

                              //  trending
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 0, 20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Trending",
                                  style: appTheme.textTheme.bodyLarge,
                                ),
                              ),
                              trending(),

                              //  types
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(15, 20, 15, 0),
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  leading: Text(
                                    "Special",
                                    style: appTheme.textTheme.bodyLarge,
                                  ),
                                  trailing: TextButton(
                                    onPressed: () {
                                      Get.off(() =>
                                          const Category(category: 'specials'));
                                    },
                                    child: Text(
                                      "View all >",
                                      style: appTheme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  tileColor: appTheme.hintColor,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                              specials(),

                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(15, 20, 15, 0),
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  leading: Text(
                                    "Movies",
                                    style: appTheme.textTheme.bodyLarge,
                                  ),
                                  trailing: TextButton(
                                    onPressed: () {
                                      Get.off(() =>
                                          const Category(category: 'movies'));
                                    },
                                    child: Text(
                                      "View all >",
                                      style: appTheme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  tileColor: appTheme.hintColor,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                              movies(),

                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(15, 20, 15, 0),
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  leading: Text(
                                    "ONA",
                                    style: appTheme.textTheme.bodyLarge,
                                  ),
                                  trailing: TextButton(
                                    onPressed: () {
                                      Get.off(() =>
                                          const Category(category: 'ona'));
                                    },
                                    child: Text(
                                      "View all >",
                                      style: appTheme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  tileColor: appTheme.hintColor,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                              ona(),

                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(15, 20, 15, 0),
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  leading: Text(
                                    "OVA",
                                    style: appTheme.textTheme.bodyLarge,
                                  ),
                                  trailing: TextButton(
                                    onPressed: () {
                                      Get.off(() =>
                                          const Category(category: 'ova'));
                                    },
                                    child: Text(
                                      "View all >",
                                      style: appTheme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  tileColor: appTheme.hintColor,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                              ova(),
                            ],
                          ),
                        )),
                    Obx(() => Visibility(
                          visible: homeController.noData.value,
                          child: noData("Oops, failed to load data!"),
                        )),
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: Container(
              //     height: MediaQuery.of(context).size.height * 0.07,
              //     color: Colors.black,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget trending() {
    final appTheme = Theme.of(context);

    return Stack(
      children: [
        Positioned(
          child: Container(
            height: 200,
            margin: const EdgeInsets.only(bottom: 20),
            child: ListView.builder(
              itemCount: homeController.topData.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.off(() => Details(
                        id: homeController.topData[index].id.toString()));
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
                          color: appTheme.colorScheme.surface,
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
                                            homeController.topData[index].name!,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                appTheme.textTheme.titleSmall,
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
                                style: appTheme.textTheme.bodyLarge,
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
                              placeholder: "assets/img/blank.png",
                              image: homeController.topData[index].aniImage
                                  .toString(),
                              imageErrorBuilder: (context, error, stackTrace) {
                                try {
                                  return Image.network(
                                    homeController
                                        .topData[index].imageHighQuality
                                        .toString(),
                                    fit: BoxFit.contain,
                                  );
                                } catch (e) {
                                  return Image.asset(
                                    "assets/img/blank.png",
                                    fit: BoxFit.contain,
                                  );
                                }
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
          ),
        ),
        const Positioned(
          bottom: 50,
          child: SizedBox(height: 30),
        )
      ],
    );
  }

  Widget specials() {
    final appTheme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemCount: homeController.specialData.length,
        itemBuilder: (BuildContext listCtx, int index) {
          if (homeController.specialData[index].animeWatchType == 'SP') {
            homeController.animeType = "Special";
          } else {
            homeController.animeType = "-";
          }

          if (homeController.specialData[index].status == 'C') {
            homeController.status = "Completed";
          } else if (homeController.specialData[index].status == 'O') {
            homeController.status = "Ongoing";
          } else {
            homeController.status = "-";
          }
          return ListTile(
            onTap: () {
              Get.off(() =>
                  Details(id: homeController.specialData[index].id.toString()));
            },
            leading: SizedBox(
              height: 100,
              width: 50,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/img/blank.png",
                image: homeController.specialData[index].aniImage ??=
                    homeController.specialData[index].imageHighQuality
                        .toString(),
                imageErrorBuilder: (context, error, stackTrace) {
                  try {
                    return Image.network(
                      homeController.moviesData[index].imageHighQuality
                          .toString(),
                      fit: BoxFit.contain,
                    );
                  } catch (e) {
                    return Image.asset(
                      "assets/img/blank.png",
                      fit: BoxFit.contain,
                    );
                  }
                },
                fit: BoxFit.contain,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                homeController.specialData[index].name!,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: appTheme.textTheme.titleMedium,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "${homeController.animeType}   •   ${homeController.status}   •   ${homeController.specialData[index].airedYear}",
                style: appTheme.textTheme.titleSmall,
              ),
            ),
            dense: true,
            tileColor:
                (index % 2 == 0) ? appTheme.disabledColor : appTheme.hintColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          );
        },
      ),
    );
  }

  Widget movies() {
    final appTheme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemCount: homeController.moviesData.length,
        itemBuilder: (BuildContext listCtx, int index) {
          if (homeController.moviesData[index].animeWatchType == 'M') {
            homeController.animeType = "Movie";
          } else {
            homeController.animeType = "-";
          }

          if (homeController.moviesData[index].status == 'C') {
            homeController.status = "Completed";
          } else if (homeController.moviesData[index].status == 'O') {
            homeController.status = "Ongoing";
          } else {
            homeController.status = "-";
          }
          return ListTile(
            onTap: () {
              Get.off(() =>
                  Details(id: homeController.moviesData[index].id.toString()));
            },
            leading: SizedBox(
              height: 100,
              width: 50,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/img/blank.png",
                image: homeController.moviesData[index].aniImage ??=
                    homeController.moviesData[index].imageHighQuality
                        .toString(),
                imageErrorBuilder: (context, error, stackTrace) {
                  try {
                    return Image.network(
                      homeController.moviesData[index].imageHighQuality
                          .toString(),
                      fit: BoxFit.contain,
                    );
                  } catch (e) {
                    return Image.asset(
                      "assets/img/blank.png",
                      fit: BoxFit.contain,
                    );
                  }
                },
                fit: BoxFit.contain,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                homeController.moviesData[index].name!,
                style: appTheme.textTheme.titleMedium,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "${homeController.animeType}   •   ${homeController.status}   •   ${homeController.specialData[index].airedYear}",
                style: appTheme.textTheme.titleSmall,
              ),
            ),
            dense: true,
            tileColor:
                (index % 2 == 0) ? appTheme.disabledColor : appTheme.hintColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          );
        },
      ),
    );
  }

  Widget ona() {
    final appTheme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemCount: homeController.onasData.length,
        itemBuilder: (BuildContext listCtx, int index) {
          if (homeController.onasData[index].animeWatchType == 'ON') {
            homeController.animeType = "Onas";
          } else {
            homeController.animeType = "-";
          }

          if (homeController.onasData[index].status == 'C') {
            homeController.status = "Completed";
          } else if (homeController.onasData[index].status == 'O') {
            homeController.status = "Ongoing";
          } else {
            homeController.status = "-";
          }
          return ListTile(
            onTap: () {
              Get.off(() =>
                  Details(id: homeController.onasData[index].id.toString()));
            },
            leading: SizedBox(
              height: 100,
              width: 50,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/img/blank.png",
                image: homeController.onasData[index].aniImage ??=
                    homeController.onasData[index].imageHighQuality.toString(),
                imageErrorBuilder: (context, error, stackTrace) {
                  try {
                    return Image.network(
                      homeController.onasData[index].imageHighQuality
                          .toString(),
                      fit: BoxFit.contain,
                    );
                  } catch (e) {
                    return Image.asset(
                      "assets/img/blank.png",
                      fit: BoxFit.contain,
                    );
                  }
                },
                fit: BoxFit.contain,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                homeController.onasData[index].name!,
                style: appTheme.textTheme.titleMedium,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "${homeController.animeType}   •   ${homeController.status}   •   ${homeController.specialData[index].airedYear}",
                style: appTheme.textTheme.titleSmall,
              ),
            ),
            dense: true,
            tileColor:
                (index % 2 == 0) ? appTheme.disabledColor : appTheme.hintColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          );
        },
      ),
    );
  }

  Widget ova() {
    final appTheme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemCount: homeController.ovasData.length,
        itemBuilder: (BuildContext listCtx, int index) {
          if (homeController.ovasData[index].animeWatchType == 'OV') {
            homeController.animeType = "Ovas";
          } else {
            homeController.animeType = "-";
          }

          if (homeController.ovasData[index].status == 'C') {
            homeController.status = "Completed";
          } else if (homeController.ovasData[index].status == 'O') {
            homeController.status = "Ongoing";
          } else {
            homeController.status = "-";
          }
          return ListTile(
            onTap: () {
              Get.off(() =>
                  Details(id: homeController.ovasData[index].id.toString()));
            },
            leading: SizedBox(
              height: 100,
              width: 50,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/img/blank.png",
                image: homeController.ovasData[index].aniImage ??=
                    homeController.ovasData[index].imageHighQuality.toString(),
                imageErrorBuilder: (context, error, stackTrace) {
                  try {
                    return Image.network(
                      homeController.ovasData[index].imageHighQuality
                          .toString(),
                      fit: BoxFit.contain,
                    );
                  } catch (e) {
                    return Image.asset(
                      "assets/img/blank.png",
                      fit: BoxFit.contain,
                    );
                  }
                },
                fit: BoxFit.contain,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                homeController.ovasData[index].name!,
                style: appTheme.textTheme.titleMedium,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "${homeController.animeType}   •   ${homeController.status}   •   ${homeController.specialData[index].airedYear}",
                style: appTheme.textTheme.titleSmall,
              ),
            ),
            dense: true,
            tileColor:
                (index % 2 == 0) ? appTheme.disabledColor : appTheme.hintColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          );
        },
      ),
    );
  }
}
