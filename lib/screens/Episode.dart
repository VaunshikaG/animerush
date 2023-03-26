import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../podo/DetailsPodo.dart';
import '../podo/EpDetailPodo.dart';
import '../utils/ApiService.dart';
import '../utils/Loader.dart';
import '../utils/theme.dart';
import '../widgets/CustomAppBar.dart';
import 'Player.dart';

class Episode extends StatefulWidget {
  final List<EpDetails> epDetails;
  const Episode({Key? key, required this.epDetails}) : super(key: key);

  @override
  State<Episode> createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {

  @override
  void initState() {
    log(runtimeType.toString());
    // log(widget.epDetails.toString());
    episodeApiCall();
    super.initState();
    apiStatus = "";
    animeId = "";
    playerURL = "";
    epImg = "";
    title = "";
    name = "";
    desc = "";
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: kIsWeb ? 1100 : MediaQuery.of(context).size.width,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomTheme.black,
          body: SafeArea(
            top: false,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return false;
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: CustomAppBar3(
                      title: title,
                      backBtn: () {
                        Navigator.of(context).pop();
                      },
                      wishlist: () {},
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: (apiStatus == 200)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Player(url: playerURL),
                              dwld(),
                              details(),
                               Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Text(
                                  "List of Episodes   :",
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: CustomTheme.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Quicksand',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child:  widget.epDetails.length > 100 ?
                                SizedBox(
                                  height: 70,
                                  child: ListView.builder(
                                    itemCount: finalChipCount,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric
                                          (horizontal: 8, vertical: 0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _rangeIndex.value = index;
                                              selectedIndex.value = 99999999;
                                              getEpisodeRange(index);
                                              if (finalChipCount == (index + 1)) {
                                                epChunkList.value = widget.epDetails.sublist(int.parse(start) - 1);
                                              } else {
                                                epChunkList.value = widget.epDetails
                                                    .sublist(int.parse(start) - 1, int.parse(end));
                                              }
                                            });
                                          },
                                          child: Chip(
                                            backgroundColor:
                                            _rangeIndex.value == index
                                                ? CustomTheme.themeColor1
                                                : CustomTheme.grey2,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            label: Text(
                                              getEpisodeRange(index),
                                              style: TextStyle(
                                                color: CustomTheme.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ) : const SizedBox(),
                              ),

                              widget.epDetails.isNotEmpty ? episodes() : const SizedBox(),
                              const SizedBox(height: 20),
                            ],
                          )
                        : Visibility(
                      visible: noData,
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/img/luffy1.png',
                              width: 200,
                            ),
                            Image.asset(
                              'assets/img/luffy2.png',
                              width: 200,
                            ),
                            const Text(
                              "No Data",
                              style: TextStyle(
                                fontSize: 17,
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
          ),
        ),
      ),
    );
  }

  Widget details() {
    return Container(
      margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: CustomTheme.black,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            alignment: Alignment.center,
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(Color(0xB0000000), BlendMode.darken),
            image: NetworkImage(epImg ?? "https://animerush.in/media/image/no_poster.jpg"),
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
              placeholder: "https://animerush.in/media/image/no_poster.jpg",
              image: epImg,
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
            name,
            style: TextStyle(
              color: CustomTheme.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              desc,
              style: TextStyle(
                color: CustomTheme.white,
                fontSize: 14,
              ),
            ),
          ),
          minVerticalPadding: 13,
          tileColor: CustomTheme.grey3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
    );
  }

  Widget dwld() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        title: Row(
          children: [
            Icon(
              Icons.file_download_outlined,
              color: CustomTheme.themeColor1,
              size: 20,
            ),
            Text(
              'Download   :',
              style: TextStyle(
                color: CustomTheme.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
        subtitle: SizedBox(
          height: 40,
          child: ListView.builder(
            itemCount: dwldList.length,
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
                  label: Text(dwldList[index].quality!),
                  onPressed: () {},
                  backgroundColor: CustomTheme.themeColor1,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
              );
            },
          ),
        ),
        minVerticalPadding: 10,
        tileColor: CustomTheme.grey3,
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
          url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
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
          url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
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
          itemCount: epChunkList.length,
          // itemCount: epChunkList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            idList.add(epChunkList[index].id!);
            // print(epChunkList.indexOf(epChunkList[index]));
            return InkWell(
              onTap: () async {
                setState(() {
                  selectedIndex.value = index;
                  print(index);
                  // print(epChunkList[index].id.toString());
                });
              },
              splashColor: CustomTheme.white,
              child: Container(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: selectedIndex.value == index
                        ? CustomTheme.themeColor1
                        : CustomTheme.grey2,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  (startVal++ ).toString(),
                  // (epChunkList[index]).toString(),
                  // (index +1).toString(),
                  style: TextStyle(
                    color: CustomTheme.white,
                    fontWeight: selectedIndex.value == index
                        ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool noData = false;
  var apiStatus, animeId, playerURL, epImg, title, name, desc;
  var w_title, w_name, w_desc;
  List<DownloadEpisodeLink> dwldList = [];

  bool hasRemainingEp = false;
  int remainingEp = 0;
  int totalChipCount = 0;
  int finalChipCount = 0;
  int startVal = 0;
  var start = '';
  var end = '';
  var _rangeIndex = 0.obs;
  var selectedIndex = 9999999.obs;
  RxList<EpDetails> epChunkList = <EpDetails>[].obs;
  List<EpDetails> anime = [];
  List<int> idList = [];

  void episodeApiCall() async {
    final prefs = await SharedPreferences.getInstance();
    await showProgress(context, "Please wait...", true);

    APIService apiService = new APIService();
    for (int i = 0; i < widget.epDetails.length; i++) {
        animeId = widget.epDetails[i].id;
        // log(animeId.toString());
        w_title = widget.epDetails[i].episodeTitle ?? "";
        w_name = widget.epDetails[i].episodeName ?? "";
        w_desc = widget.epDetails[i].videoDetails ?? "";
    }

    anime = widget.epDetails;
    if ((anime.length % 100).floor() < 100) {
      print((anime.length % 100).toString());
      hasRemainingEp = true;
      remainingEp = (anime.length % 100).floor();
    }
    totalChipCount = (anime.length / 100).floor();
    epChunkList.value = anime.sublist(0, (hasRemainingEp == true && anime.length < 100)
            ? remainingEp
            : 100);
    finalChipCount = totalChipCount + (hasRemainingEp ? 1 : 0);

    print('Ep Chunk List ${epChunkList.length} + $remainingEp');
    print((anime.length % 100).floor());
    print(totalChipCount);
    print(finalChipCount);
    // int str1 = int.parse(start);
    // int str2 = int.parse(end);
    // log(epChunkList.getRange(str1, str2).toString());

    apiService.EpisodeApi().then((value) {
      // apiService.EpisodeApi(animeId: animeId.toString()).then((value) {
      try {
        if (value != null) {
          var responsebody = json.decode(value);
          EpDetailPodo epDetailPodo = EpDetailPodo.fromJson(responsebody);
          apiStatus = responsebody["st"];
          hideProgress();
          if (apiStatus == 200) {
            setState(() {
              hideProgress();
              for(int i = 0; i < epDetailPodo.data!.episodeLink!.length; i++) {
                playerURL = epDetailPodo.data!.episodeLink![i].file;
              }
              epImg = epDetailPodo.data!.image ?? "https://animerush.in/media/image/no_poster.jpg";
              title = epDetailPodo.data!.episodeTitle ?? w_title ?? "";
              name = epDetailPodo.data!.episodeName ?? w_name ?? "";
              desc = epDetailPodo.data!.videoDetails ?? w_desc ?? "";
              dwldList = epDetailPodo.data!.downloadEpisodeLink!;

            });
          } else {
            hideProgress();
            noData = true;
            // CustomSnackBar(context, Text(homePodo.msg!));
          }
        }
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    });
  }

  String getEpisodeRange(int index) {
    start = ((index * 100) + 1).toString();
    end = ((100 * (index + 1))).toString();
    if (index == totalChipCount && hasRemainingEp) {
      end = ((100 * index) + remainingEp).toString();
    }
    startVal = int.parse(start);
    // endVal = (int.parse(end) + 1).toString();
    return ('$start - $end');
  }

}
