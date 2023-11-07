import 'dart:async';
import 'dart:developer';
import 'package:animerush/screens/episode.dart';
import 'package:animerush/utils/appConst.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rich_text_view/rich_text_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/admobController.dart';
import '../controllers/detailsController.dart';
import '../controllers/watchListController.dart';
import '../utils/commonStyle.dart';
import '../widgets/customButtons.dart';
import '../widgets/loader.dart';
import '../utils/theme.dart';
import '../widgets/customAppBar.dart';
import '../widgets/noData.dart';
import '../widgets/similarList.dart';
import 'bottomBar.dart';
import 'watchList.dart';
import 'auth.dart';

class Details extends StatefulWidget {
  final String? id;
  final String? epId;

  const Details({Key? key, required this.id, this.epId}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  DetailsController detailsController = Get.put(DetailsController());
  WatchListController watchListController = Get.put(WatchListController());
  ScrollController scrollController = ScrollController();
  AdmobController admob = AdmobController();

  List<String> options = [
    "Share",
    "Watch now",
    "Add to list",
  ];
  List<IconData> optionIcon = [
    CupertinoIcons.share,
    CupertinoIcons.play_circle,
    CupertinoIcons.add_circled,
  ];
  List<String> detailTitle = [
    "Other names",
    "Language",
    "Duration",
    "Episodes",
    "Release Year",
    "Type",
    "Status",
    "Studios",
  ];

  @override
  void initState() {
    debugPrint(runtimeType.toString());
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      admob.loadBanner(this);
      loadData();
    });
    super.initState();
  }

  Future<void> loadData() async {
    await showProgress(context, false);
    detailsController.detailsApiCall(animeId: widget.id);

    final prefs = await SharedPreferences.getInstance();
    DateTime? lastClicked = prefs.containsKey(AppConst.adTimeStamp1)
        ? DateTime.parse(prefs.getString(AppConst.adTimeStamp1)!)
        : null;

    if (lastClicked == null || DateTime.now().difference(lastClicked) >= const Duration(minutes: 5)) {
      prefs.setString(AppConst.adTimeStamp1, DateTime.now().toString());
      admob.loadInterstitial();
    } else {
      log('Interstitial loaded within the last 5 mins. Not executing code1.');
    }
  }

  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const BottomBar(currentIndex: 0, checkVersion: false));
        return true;
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: kIsWeb ? 1100 : MediaQuery.of(context).size.width,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              top: false,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return false;
                },
                child: CustomScrollView(
                  slivers: [
                    Obx(() => (detailsController.hasData.value == true)
                        ? CustomAppBar(
                            title: detailsController.name ?? "-",
                            img: detailsController.img.value,
                            backBtn: () {
                              // Get.back();
                              Get.offAll(() => const BottomBar(
                                  currentIndex: 0, checkVersion: false));
                            },
                            wishlist: () {
                              Get.off(() => WatchList(
                                    pg: 'detail',
                                    aId: widget.id,
                                  ));
                            },
                          )
                        : SliverToBoxAdapter(
                            child: Visibility(
                              visible: detailsController.showLogin.value,
                              child: CustomAppBar4(
                                title: '',
                                backBtn: () {
                                  Get.back();
                                  Get.offAll(() => const BottomBar(
                                      currentIndex: 0, checkVersion: false));
                                },
                              ),
                            ),
                          )),
                    SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          Container(
                            margin: (admob.bannerAd != null && admob.isBannerLoaded == true)
                                ? EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height * 0.04)
                                : EdgeInsets.zero,
                            child: Column(
                              children: [
                                Obx(() => Visibility(
                                      visible: detailsController.hasData.value,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        // margin: const EdgeInsets.only(bottom: 150),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //  title
                                            ListTile(
                                              title: Text(
                                                detailsController.name ?? '-',
                                                softWrap: true,
                                                style: appTheme
                                                    .textTheme.displayMedium,
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  "HD   •   ${detailsController.status}   •   ${detailsController.animeType}",
                                                  style: appTheme
                                                      .textTheme.bodySmall,
                                                ),
                                              ),
                                              // dense: true,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 5),
                                            ),

                                            /*Obx(() => Visibility(
                                                  visible: detailsController
                                                      .showNextEp.value,
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                                    margin: const EdgeInsets.only
                                                      (bottom: 10,left: 10, right:10),
                                                    child: ListTile(
                                                      leading: Image.asset(
                                                        "assets/img/rocket.png",
                                                        height: 30,
                                                      ),
                                                      title: Text(
                                                        "Estimated the next episode will come at ${detailsController.nextEp}",
                                                        textAlign: TextAlign.start,
                                                        style: appTheme
                                                            .textTheme.titleMedium,
                                                      ),
                                                      minLeadingWidth: 0,
                                                      trailing: IconButton(
                                                        onPressed: () => setState(
                                                            () => detailsController
                                                                .showNextEp
                                                                .value = false),
                                                        icon: Icon(
                                                          CupertinoIcons.clear,
                                                          size: 14,
                                                          color: appTheme
                                                              .iconTheme.color,
                                                        ),
                                                      ),
                                                      tileColor: CustomTheme.blue,
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(5),
                                                      ),
                                                      dense: true,
                                                    ),
                                                  ),
                                                )),*/

                                            //  desc
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: RichTextView(
                                                text: detailsController.desc ??
                                                    '-',
                                                maxLines: 4,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: appTheme
                                                    .textTheme.titleSmall,
                                                truncate: true,
                                                viewLessText: 'less',
                                                linkStyle: TextStyle(
                                                  fontSize: 13,
                                                  color: CustomTheme.blue,
                                                  fontFamily: AppConst.FONT,
                                                ),
                                                supportedTypes: const [],
                                              ),
                                            ),

                                            //  btns
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 5, 0, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ActionChip(
                                                    elevation: 3,
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    avatar: CircleAvatar(
                                                      backgroundColor:
                                                          appTheme.primaryColor,
                                                      child: Icon(
                                                        CupertinoIcons
                                                            .play_circle,
                                                        color: appTheme
                                                            .scaffoldBackgroundColor,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    label: Text(
                                                      'Watch Now',
                                                      style: appTheme
                                                          .textTheme.labelSmall,
                                                    ),
                                                    onPressed: () async {
                                                      if (widget.epId != "") {
                                                        Get.off(() => Episode(
                                                              pg: 'details',
                                                              epDetails:
                                                                  detailsController
                                                                      .epDetails,
                                                              aId: widget.id,
                                                              epId: widget.epId,
                                                            ));
                                                      } else {
                                                        Get.off(() => Episode(
                                                              pg: 'details',
                                                              epDetails:
                                                                  detailsController
                                                                      .epDetails,
                                                              aId: widget.id,
                                                              epId: '',
                                                            ));
                                                      }
                                                    },
                                                    backgroundColor:
                                                        appTheme.primaryColor,
                                                    shape:
                                                        const StadiumBorder(),
                                                    side: BorderSide.none,
                                                    labelPadding:
                                                        const EdgeInsets.only(
                                                            right: 6),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  PopupMenuButton(
                                                    onSelected: (String value) {
                                                      setState(() {
                                                        watchListController
                                                            .addToListApi(
                                                          animeId: widget.id!,
                                                          type: value,
                                                        );
                                                      });
                                                    },
                                                    itemBuilder:
                                                        (BuildContext ctx) => [
                                                      PopupMenuItem(
                                                        value: '01',
                                                        child: Text(
                                                          'Watching',
                                                          style: appTheme
                                                              .textTheme
                                                              .titleSmall,
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: '02',
                                                        child: Text(
                                                          'On Hold',
                                                          style: appTheme
                                                              .textTheme
                                                              .titleSmall,
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: '03',
                                                        child: Text(
                                                          'Plan To Watch',
                                                          style: appTheme
                                                              .textTheme
                                                              .titleSmall,
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: '04',
                                                        child: Text(
                                                          'Dropped',
                                                          style: appTheme
                                                              .textTheme
                                                              .titleSmall,
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        value: '05',
                                                        child: Text(
                                                          'Completed',
                                                          style: appTheme
                                                              .textTheme
                                                              .titleSmall,
                                                        ),
                                                      ),
                                                    ],
                                                    padding: EdgeInsets.zero,
                                                    color: appTheme.hintColor,
                                                    shadowColor:
                                                        appTheme.disabledColor,
                                                    child: Chip(
                                                      elevation: 3,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      avatar: CircleAvatar(
                                                        backgroundColor:
                                                            appTheme
                                                                .primaryColor,
                                                        child: Icon(
                                                          Icons
                                                              .bookmark_add_outlined,
                                                          color: appTheme
                                                              .scaffoldBackgroundColor,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      label: Text(
                                                        'Add To WatchList',
                                                        style: appTheme
                                                            .textTheme
                                                            .labelSmall,
                                                      ),
                                                      backgroundColor:
                                                          appTheme.primaryColor,
                                                      shape:
                                                          const StadiumBorder(),
                                                      side: BorderSide.none,
                                                      labelPadding:
                                                          const EdgeInsets.only(
                                                              right: 6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // info
                                            // Padding(
                                            //   padding: const EdgeInsets.fromLTRB(15, 6, 15, 6),
                                            //   child: customText(
                                            //     text1: "Other names",
                                            //     text2: detailsController.otherName.toString(),
                                            //   ),
                                            // ),
                                            ListView.builder(
                                              itemCount: detailTitle.length,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 6, 15, 6),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return customText(
                                                  text1: detailTitle[index],
                                                  text2: detailsController
                                                      .details[index],
                                                );
                                              },
                                            ),

                                            // similar list
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 15, bottom: 10),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Similar Anime",
                                                style: appTheme
                                                    .textTheme.labelLarge,
                                              ),
                                            ),
                                            SimilarList(
                                              pg: 'detail',
                                              similarData:
                                                  detailsController.similarData,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                Obx(() => Visibility(
                                      visible: detailsController.noData.value,
                                      child:
                                          noData("Oops, failed to load data!"),
                                    )),
                                Obx(() => Visibility(
                                      visible:
                                          detailsController.showLogin.value,
                                      child: Center(
                                        heightFactor: 13,
                                        child: elevatedButton(
                                          text: "Login →",
                                          onPressed: () =>
                                              Get.offAll(() => const Auth()),
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
                            child: (admob.bannerAd != null && admob.isBannerLoaded == true)
                                ? SizedBox(
                              width: admob.bannerAd!.size.width.toDouble(),
                              height: admob.bannerAd!.size.height.toDouble(),
                              child: AdWidget(ad: admob.bannerAd!),
                            )
                                : const SizedBox(),
                          ),
                        ],
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

  @override
  void dispose() {
    admob.bannerAd?.dispose();
    super.dispose();
  }
}
