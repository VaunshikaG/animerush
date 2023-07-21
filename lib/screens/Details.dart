import 'dart:developer';
import 'dart:ui';
import 'package:animerush/screens/Episode.dart';
import 'package:animerush/utils/AppConst.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rich_text_view/rich_text_view.dart';
import '../controllers/DetailsController.dart';
import '../utils/CommonStyle.dart';
import '../widgets/Loader.dart';
import '../utils/theme.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomScreenRoute.dart';
import '../widgets/NoData.dart';
import '../widgets/SimilarList.dart';
import 'BottomBar.dart';

class Details extends StatefulWidget {
  final String? id;

  const Details({Key? key, required this.id}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  DetailsController detailsController = Get.put(DetailsController());
  ScrollController scrollController = ScrollController();

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
    "Views",
    "Release Year",
    "Type",
    "Status",
    "Studios",
  ];

  @override
  void initState() {
    log(runtimeType.toString());
    log(widget.id.toString());
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      loadData();
    });
    super.initState();
  }

  Future<void> loadData() async {
    await showProgress(context, true);
    detailsController.hasData.value = false;
    detailsController.noData.value = false;
    Future.delayed(const Duration(seconds: 1), () {
      detailsController.detailsApiCall(animeId: widget.id);
    });
  }

  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        Get.off(() => const BottomBar(currentIndex: 0));
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
                    Obx(() => CustomAppBar(
                          title: detailsController.name ?? "-",
                          img: detailsController.img.value,
                          backBtn: () {
                            Get.off(() => const BottomBar(currentIndex: 0));
                          },
                          wishlist: () {},
                        )),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Obx(() => Visibility(
                                visible: detailsController.hasData.value,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  margin: const EdgeInsets.only(bottom: 100),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //  title
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          detailsController.name,
                                          softWrap: true,
                                          style:
                                              appTheme.textTheme.displayMedium,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          "HD   •   ${detailsController.status}   •   ${detailsController.animeType}",
                                          style: appTheme.textTheme.bodySmall,
                                        ),
                                      ),

                                      //  desc
                                      RichTextView(
                                        text: detailsController.desc,
                                        maxLines: 4,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: appTheme.textTheme.titleSmall,
                                        truncate: true,
                                        viewLessText: 'less',
                                        linkStyle: TextStyle(
                                          fontSize: 13,
                                          color: CustomTheme.blue,
                                          fontFamily: AppConst.FONT,
                                        ),
                                        supportedTypes: const [],
                                      ),

                                      //  btns
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ActionChip(
                                              elevation: 3,
                                              padding: const EdgeInsets.all(2),
                                              avatar: CircleAvatar(
                                                backgroundColor:
                                                    appTheme.primaryColor,
                                                child: Icon(
                                                  CupertinoIcons.play_circle,
                                                  color: appTheme
                                                      .colorScheme.background,
                                                  size: 20,
                                                ),
                                              ),
                                              label: Text(
                                                'Watch Now',
                                                style: appTheme
                                                    .textTheme.labelSmall,
                                              ),
                                              onPressed: () {
                                                Get.off(() => Episode(
                                                      epDetails: detailsController.epDetails,
                                                      id: widget.id,
                                                    ));
                                              },
                                              backgroundColor:
                                                  appTheme.primaryColor,
                                              shape: const StadiumBorder(),
                                              side: BorderSide.none,
                                            ),
                                            const SizedBox(width: 15),
                                            ActionChip(
                                              elevation: 3,
                                              padding: const EdgeInsets.all(2),
                                              avatar: CircleAvatar(
                                                backgroundColor:
                                                    appTheme.primaryColor,
                                                child: Icon(
                                                  Icons.bookmark_add_outlined,
                                                  color: appTheme
                                                      .colorScheme.background,
                                                  size: 20,
                                                ),
                                              ),
                                              label: Text(
                                                'Watchlist',
                                                style: appTheme
                                                    .textTheme.labelSmall,
                                              ),
                                              onPressed: () {
                                                // Navigator.push(
                                                //     context,
                                                //     CustomScreenRoute(
                                                //       child: Episode(
                                                //         id: id,
                                                //         epDetails: epDetails,
                                                //       ),
                                                //       direction: AxisDirection.up,
                                                //     ));
                                              },
                                              backgroundColor:
                                                  appTheme.primaryColor,
                                              shape: const StadiumBorder(),
                                              side: BorderSide.none,
                                            ),
                                          ],
                                        ),
                                      ),

                                      Visibility(
                                        visible: detailsController.showNextEp,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
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
                                              onPressed: () => setState(() =>
                                                  detailsController.showNextEp =
                                                      false),
                                              icon: Icon(
                                                CupertinoIcons.clear,
                                                size: 14,
                                                color: appTheme.iconTheme.color,
                                              ),
                                            ),
                                            tileColor: CustomTheme.blue,
                                            contentPadding:
                                                const EdgeInsets.only(left: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            dense: true,
                                          ),
                                        ),
                                      ),

                                      // info
                                      ListView.builder(
                                        itemCount: detailTitle.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: const ClampingScrollPhysics(),
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 6, 15, 6),
                                        itemBuilder:
                                            (BuildContext context, int index) {
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
                                          style: appTheme.textTheme.labelLarge,
                                        ),
                                      ),
                                      SimilarList(
                                        dataLength: detailsController.similarData
                                            .length,
                                        similarData: detailsController.similarData,
                                      ),

                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              )),
                          Obx(() => Visibility(
                                visible: detailsController.noData.value,
                                child: noData(context),
                              )),
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
    detailsController.dispose();
    super.dispose();
  }
}
