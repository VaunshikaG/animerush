import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/EpisodeController.dart';
import '../model/DetailsPodo.dart';
import '../widgets/Loader.dart';
import '../utils/theme.dart';
import '../widgets/CustomAppBar.dart';
import 'Details.dart';
import 'Player.dart';

class Episode extends StatefulWidget {
  final String? id;
  final List<EpDetails> epDetails;
  const Episode({Key? key, required this.epDetails, this.id}) : super(key: key);

  @override
  State<Episode> createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {
  EpisodeController epController = Get.put(EpisodeController());

  @override
  void initState() {
    log(runtimeType.toString());
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      loadData();
    });
    super.initState();
  }

  Future<void> loadData() async {
    await showProgress(context, "Please wait...", true);
    epController.hasData.value = false;
    epController.noData.value = false;
    Future.delayed(Duration(seconds: 1), () {
      for (int i = 0; i < widget.epDetails.length; i++) {
        epController.animeId = widget.epDetails[i].id.toString();
        // log(animeId.toString());
        epController.w_title = widget.epDetails[i].episodeTitle ?? "";
        epController.w_name = widget.epDetails[i].episodeName ?? "";
        epController.w_desc = widget.epDetails[i].videoDetails ?? "";
      }

      epController.anime = widget.epDetails;
      epController.episodeApiCall();
    });
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
        child: Container(
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: widget.epDetails.length > 100
                                      ? SizedBox(
                                    height: 70,
                                    child: ListView.builder(
                                      itemCount: epController.finalChipCount,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 0),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                epController.rangeIndex.value = index;
                                                epController.selectedIndex.value =
                                                99999999;
                                                epController.getEpisodeRange(index);
                                                if (epController.finalChipCount ==
                                                    (index + 1)) {
                                                  epController.epChunkList.value = widget
                                                      .epDetails.sublist(int.parse(epController.start) - 1);
                                                } else {
                                                  epController.epChunkList.value = widget
                                                      .epDetails.sublist(int.parse(epController.start) - 1,
                                                      int.parse(epController.end));
                                                }
                                              });
                                            },
                                            child: Chip(
                                              backgroundColor:
                                              epController.rangeIndex.value ==
                                                  index
                                                  ? appTheme.primaryColor
                                                  : appTheme.hintColor,
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 10),
                                              label: Text(
                                                epController.getEpisodeRange(index),
                                                style: appTheme.textTheme.titleSmall,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                      : const SizedBox(),
                                ),
                                widget.epDetails.isNotEmpty
                                    ? episodes()
                                    : const SizedBox(),
                                const SizedBox(height: 20),
                              ],
                            ),
                          )),
                          Obx(() => Visibility(
                            visible: epController.noData.value,
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
                                    style: appTheme.textTheme.displayLarge,
                                  ),
                                ],
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
        color: appTheme.scaffoldBackgroundColor,
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
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            epController.desc,
            style: appTheme.textTheme.bodySmall,
          ),
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
              'Download   :',
              style: appTheme.textTheme.bodySmall,
            ),
          ],
        ),
        subtitle: SizedBox(
          height: 40,
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
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  label: Text(epController.dwldList[index].quality!),
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

    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 550,
      child: Scrollbar(
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            maxCrossAxisExtent: 45,
          ),
          itemCount: epController.epChunkList.length,
          // itemCount: epChunkList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            epController.idList.add(epController.epChunkList[index].id!);
            // print(epChunkList.indexOf(epChunkList[index]));
            return InkWell(
              onTap: () async {
                setState(() {
                  epController.selectedIndex.value = index;
                  print(index);
                  // print(epChunkList[index].id.toString());
                });
              },
              splashColor: appTheme.dialogBackgroundColor,
              child: Container(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: epController.selectedIndex.value == index
                        ? appTheme.primaryColor
                        : appTheme.hintColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  (epController.startVal++).toString(),
                  // (epChunkList[index]).toString(),
                  // (index +1).toString(),
                  style: TextStyle(
                    color: appTheme.dialogBackgroundColor,
                    fontWeight: epController.selectedIndex.value == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
