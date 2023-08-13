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
import '../widgets/Loader.dart';
import '../utils/theme.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/NoData.dart';
import 'Details.dart';
import 'Player.dart';

class Episode extends StatefulWidget {
  final String? id;
  final List<EpDetails> epDetails;
  const Episode(
      {Key? key, required this.epDetails, this.id,})
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
        // log(animeId.toString());
        epController.w_title = widget.epDetails[i].episodeTitle ?? "";
        epController.w_name = widget.epDetails[i].episodeName ?? "";
        epController.w_desc = widget.epDetails[i].videoDetails ?? "";
      }

      epController.anime = widget.epDetails;
      epController.episodeApiCall();
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
        Get.off(() => Details(id: widget.id));
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
                      child: CustomAppBar3(
                        title: epController.title ?? "",
                        backBtn: () {
                          Get.off(() => Details(id: widget.id));
                        },
                        wishlist: () {},
                      ),
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
                                      url: epController.playerURL,
                                      title: epController.title,
                                      placeHolder: epController.epImg.value,
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
          image: NetworkImage(epController.epImg.value),
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
            image: epController.epImg.value,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/img/icon1.png",
                fit: BoxFit.contain,
              );
            },
            width: 60,
          ),
        ),
        title: Text(
          epController.name,
          style: appTheme.textTheme.bodyLarge,
        ),
        subtitle: RichTextView(
          text: epController.desc,
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
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ActionChip(
                  elevation: 3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  label: Text(epController.dwldList[index].quality!),
                  labelStyle: appTheme.textTheme.labelSmall,
                  onPressed: () {},
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

  abc() {
    return Row(
      children: [
        ActionChip(
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          label: const Text('360p'),
          onPressed: () {
            downloadEp();
            // downloadFile(
            //   fileName: "One Piece Episode 1",
            //   url: 'https://gogodownload.net/download.php?url=aHR0cHM6LyAawehyfcghysfdsDGDYdgdsfsdfwstdgdsgtert8AdrefsdsdfwerFrefdsfrersfdsrfer363435342eGM1cHBlOWVpLmdvY2RuYW5pLmNvbS91c2VyMTM0Mi9jNzUxYmFiMTkzOWEyYjgzMDIwNTY1ZTFhYzI0Mjg5Ni9FUC4xLnYxLjM2MHAubXA0P3Rva2VuPURMZDVUTUxkVGNtdTEzbnVCVmRiTmcmZXhwaXJlcz0xNjc4ODY4MzY5JmlkPTM1MTgmdGl0bGU9KDY0MHgzNjAtZ29nb2FuaW1lKW9uZS1waWVjZS1lcGlzb2RlLTEubXA0',
            // );
          },
          backgroundColor: CustomTheme.themeColor1,
          side: BorderSide.none,
        ),
        const SizedBox(width: 10),
        ActionChip(
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          label: const Text('480p'),
          onPressed: () {},
          backgroundColor: CustomTheme.themeColor1,
          side: BorderSide.none,
        ),
        const SizedBox(width: 10),
        ActionChip(
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          label: const Text('720p'),
          onPressed: () {},
          backgroundColor: CustomTheme.themeColor1,
          side: BorderSide.none,
        ),
        const SizedBox(width: 10),
        ActionChip(
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          label: const Text('1080p'),
          onPressed: () {},
          backgroundColor: CustomTheme.themeColor1,
          side: BorderSide.none,
        ),
      ],
    );
  }

  Future<String> downloadEp() async {
    const folderName = "AnimeRush";
    final path = Directory("storage/emulated/0/$folderName");

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      await FlutterDownloader.enqueue(
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'
        },
        url:
            "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        savedDir: path.path,
        showNotification: true,
        saveInPublicStorage: true,
        openFileFromNotification: true,
        fileName: "One Piece Episode 1.mp4",
      );
      return path.path;
    } else {
      path.create();
      await FlutterDownloader.enqueue(
        url:
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        savedDir: path.path,
        showNotification: true,
        saveInPublicStorage: true,
        openFileFromNotification: true,
        fileName: "One Piece Episode 1.mp4",
      );
      return path.path;
    }
    /*await FlutterDownloader.enqueue(
        url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        savedDir: (await getApplicationDocumentsDirectory()).path,
        showNotification: true,
        saveInPublicStorage: true,
        openFileFromNotification: true,
        fileName: "One Piece Episode 1.mp4",
      );*/
  }

  Widget episodes() {
    final appTheme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /*ListView.builder(
          shrinkWrap: true,
          itemCount: sublists.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            bool isExpanded = selectedItems.containsAll(sublists[index]);

            return ListTile(
              title: Text('${index * 50 + 1} - ${(index + 1) * 50}'),
              onTap: () {
                setState(() {
                  if (isExpanded) {
                    selectedItems.removeWhere((item) => sublists[index].contains(item));
                  } else {
                    selectedItems.addAll(sublists[index]);
                  }
                });
                print(isExpanded);
              },
              tileColor: Colors.greenAccent,
              subtitle: (isExpanded == true)
                  ? Wrap(
                direction: Axis.horizontal,

                children: sublists[index]
                    .map((item) => ElevatedButton(
                  onPressed: () {
                    print('Item ${item.epRank} pressed');
                  },
                  child: Text(item.epRank.toString()),
                ))
                    .toList(),
              )
                  : const Text('nothing'),
              dense: true,
            );
          },
        ),*/
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
                  chunkList[index].epRank.toString(),
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
