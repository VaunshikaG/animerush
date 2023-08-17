import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rich_text_view/rich_text_view.dart';
import '../controllers/EpisodeController.dart';
import '../model/DetailsPodo.dart';
import '../utils/AppConst.dart';
import '../model/Chunks.dart';
import '../widgets/CustomButtons.dart';
import '../widgets/Loader.dart';
import '../utils/theme.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/NoData.dart';
import 'BottomBar.dart';
import 'Details.dart';
import 'Player.dart';
import 'WatchList.dart';

class Episode extends StatefulWidget {
  final String? pg;
  final String? aId;
  final List<EpDetails> epDetails;
  const Episode(
      {Key? key, required this.epDetails, this.aId, this.pg,})
      : super(key: key);

  @override
  State<Episode> createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> with SingleTickerProviderStateMixin {
  EpisodeController epController = Get.put(EpisodeController());
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  List<EpDetails> chunkList = [];
  bool hasRemainingEp = false;
  int remainingEp = 0, totalChipCount = 0, finalChipCount = 0, startVal = 0, 
      length = 0, rangeIndex = 0, selectedIndex = 0;
  var start = '', end = '';
  int startIdx = 0;

  @override
  void initState() {
    log(runtimeType.toString());
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      loadData();
    });
    super.initState();
  }

  Future<void> loadData() async {
    await showProgress(context, true);
    epController.hasData.value = false;
    epController.noData.value = false;
    Future.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i < widget.epDetails.length; i++) {
        epController.animeId = widget.epDetails[i].id.toString();
        epController.w_title = widget.epDetails[i].episodeTitle ?? "";
        epController.w_name = widget.epDetails[i].episodeName ?? "";
        epController.w_desc = widget.epDetails[i].videoDetails ?? "";
      }
      if (widget.pg == 'details') {
        epController.episodeApiCall(epId: widget.epDetails[0].id.toString());

      }

      epController.anime = widget.epDetails;
      chunks();
      animationController = AnimationController(
          duration: const Duration(milliseconds: 1800), vsync: this);
      fadeAnimation =
          Tween<double>(begin: 0, end: 1).animate(animationController);
    });
  }

  void chunks() {
    // checks if the remainder of the division of the length of the "anime" list by 50 is less than 50.
    if ((widget.epDetails.length % 50).floor() < 50) {
      log('length : ${(widget.epDetails.length % 50).toString()}');
      hasRemainingEp = true;
      remainingEp = (widget.epDetails.length % 50).floor();
      log('remainingEp : ${remainingEp.toString()}');
    }
    totalChipCount =
        (widget.epDetails.length / 50).floor();
    log('chunks of 50 : $totalChipCount');

    //  size of the remaining chunk; otherwise, it takes 50.
    chunkList = widget.epDetails.sublist(
        0, (hasRemainingEp == true && widget.epDetails.length < 50)
            ? remainingEp : 50);

    //  size of remaining chunk; otherwise, it takes 50.
    finalChipCount = totalChipCount + (hasRemainingEp ? 1 : 0);
    log('final : $finalChipCount');
  }

  String getEpisodeRange(int index) {
    startIdx = ((index * 50) + 1);
    start = ((index * 50) + 1).toString();
    end = ((50 * (index + 1))).toString();
    if (index == totalChipCount && hasRemainingEp) {
      end = ((50 * index) + remainingEp).toString();
    }
    // startVal = int.parse(start);
    // endVal = (int.parse(end) + 1).toString();
    return ('$start - $end');
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        Get.off(() => Details(id: widget.aId));
        return true;
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: kIsWeb ? 1100 : MediaQuery.of(context).size.width,
          child: Scaffold(
            body: SafeArea(
              top: false,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return false;
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Obx(() => (epController.showLogin.value == true)
                          ? CustomAppBar4(
                        title: '',
                        backBtn: () {
                          Get.off(() => Details(id: widget.aId));
                        },
                      ) : CustomAppBar3(
                        title: epController.epData.episodeTitle.toString(),
                        backBtn: () {
                          Get.off(() => Details(id: widget.aId));
                        },
                        wishlist: () {
                          Get.off(() => const WatchList(pg: 'detail'));
                        },
                      )),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Obx(() => Visibility(
                                visible: epController.hasData.value,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Player(
                                      url: epController.epData.episodeLink!.file ?? "-",
                                      title: epController.epData.episodeTitle ?? epController.w_title,
                                      placeHolder: epController.epData.image ?? "https://animerush.in/media/image/no_poster.jpg",
                                      dwldList: epController.dwldList,
                                    ),
                                    dwld(),
                                    details(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Text(
                                        "List of Episodes   :",
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                        style: appTheme.textTheme.titleMedium,
                                      ),
                                    ),

                                    (finalChipCount > 0)
                                        ? episodes()
                                        : const Placeholder(),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              )),
                          Obx(() => Visibility(
                                visible: epController.noData.value,
                                child: noData(context),
                              )),
                          Obx(() => Visibility(
                            visible: epController.showLogin.value,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget details() {
    final appTheme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: appTheme.disabledColor,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          alignment: Alignment.center,
          fit: BoxFit.cover,
          colorFilter:
              const ColorFilter.mode(Color(0xB0000000), BlendMode.darken),
          image: NetworkImage(epController.epData.image ?? "https://animerush.in/media/image/no_poster.jpg",),
          onError: (error, stackTrace) {
            Image.asset(
              "assets/img/icon1.png",
              fit: BoxFit.contain,
            );
          },
        ),
      ),
      child: ListTile(
        leading: Container(
          // height: 150,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/img/blank.png",
            image: epController.epData.image.toString(),
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/img/blank.png",
                fit: BoxFit.contain,
              );
            },
            width: 60,
          ),
        ),
        title: Text(
          epController.epData.episodeName.toString(),
          style: appTheme.textTheme.bodyLarge,
        ),
        subtitle: RichTextView(
          text: epController.epData.videoDetails.toString(),
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
        minVerticalPadding: 13,
        tileColor: appTheme.disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  Widget dwld() {
    final appTheme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        title: Row(
          children: [
            Icon(
              Icons.file_download_outlined,
              color: appTheme.primaryColor,
              size: 20,
            ),
            Text(
              ' Download   :',
              style: appTheme.textTheme.bodySmall,
            ),
          ],
        ),
        subtitle: SizedBox(
          height: 35,
          child: ListView.builder(
            itemCount: epController.dwldList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(top: 5),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ActionChip(
                  elevation: 3,
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  label: Text(epController.dwldList[index].quality!),
                  labelStyle: appTheme.textTheme.labelSmall,
                  onPressed: () {
                    epController.downloadEp(
                      name: epController.epData.episodeTitle.toString(),
                      url: epController.dwldList[index].link.toString(),
                    );
                  },
                  backgroundColor: appTheme.primaryColor,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              );
            },
          ),
        ),
        minVerticalPadding: 10,
        tileColor: appTheme.disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget episodes() {
    final appTheme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // chunk sets
        widget.epDetails.length > 50
            ? SizedBox(
                height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: finalChipCount,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      child: ActionChip(
                        onPressed: () {
                          setState(() {
                            rangeIndex = index;
                            selectedIndex = 99999999;
                            getEpisodeRange (index);
                            if (finalChipCount == (index + 1)) {
                              chunkList = widget.epDetails.sublist(int.parse(start) - 1);
                            } else {
                              chunkList = widget.epDetails.sublist(int.parse(start) - 1, int.parse(end));
                            }
                          });
                        },
                        side: BorderSide.none,
                        disabledColor: appTheme.colorScheme.secondary,
                        backgroundColor:
                            rangeIndex == index
                                ? appTheme.primaryColor
                                : appTheme.hintColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        label: Text(
                          getEpisodeRange(index),
                          style: rangeIndex == index
                              ? appTheme.textTheme.labelSmall
                              : appTheme.textTheme.titleSmall,
                        ),
                      ),
                    );
                  },
                ),
              )
            : const SizedBox(),

        // ep grid
        Container(
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.topLeft,
          child: GridView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (startIdx > 1000) ? 5 : 6,
              crossAxisSpacing: (startIdx > 999) ? 8 : 9,
            ),
            itemCount: chunkList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ActionChip(
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                    epController.episodeApiCall(epId: chunkList[index].id.toString());
                  });
                },
                side: BorderSide.none,
                disabledColor: appTheme.colorScheme.secondary,
                backgroundColor:
                selectedIndex == index
                    ? appTheme.primaryColor
                    : appTheme.hintColor,
                padding: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                label: Text(
                  chunkList[index].epRank.replaceAll('.0', '').toString(),
                  style: selectedIndex == index
                      ? appTheme.textTheme.labelSmall
                      : appTheme.textTheme.titleSmall,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}
