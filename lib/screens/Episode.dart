import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../theme.dart';
import '../widgets/CustomAppBar.dart';
import 'Player.dart';

class Episode extends StatefulWidget {
  final String title;
  const Episode({Key? key, required this.title}) : super(key: key);

  @override
  State<Episode> createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {

  @override
  void initState() {
    log(runtimeType.toString());
    _choiceIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: kIsWeb ? 1100 : MediaQuery.of(context).size.width,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomTheme.themeColor2,
          body: SafeArea(
            top: false,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return false;
              },
              child: ListView(
                children: [
                  CustomAppBar3(
                    title: "One Piece Episode 1",
                    backBtn: () {
                      Navigator.of(context).pop();
                    },
                    wishlist: () {},
                  ),
                  const Player(
                        url:
                            "https://tc-005.agetcdn.com/1ab5d45273a9183bebb58eb74d5722d8ea6384f350caf008f08cf018f1f0566d0cb82a2a799830d1af97cd3f4b6a9a81ef3aed2fb783292b1abcf1b8560a1d1aa308008b88420298522a9f761e5aa1024fbe74e5aa853cfc933cd1219327d1232e91847a185021b184c027f97ae732b3708ee6beb80ba5db6628ced43f1196fe/a80af13ae85820b664b87e68fa55f4c8/ep.1.1677593409.360.m3u8",
                      ),
                  dwld(),
                  details(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      "List of Episodes   :",
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  episodes(),
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
          color: CustomTheme.themeColor2,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            alignment: Alignment.center,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Color(0xB0000000), BlendMode.darken),
            image: NetworkImage("https://artworks.thetvdb.com/banners/v4/episode/361887/screencap/604df7d3ecf3a.jpg"),
          ),
        ),
        child: ListTile(
          leading: Container(
            // height: 150,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/img/icon1.png",
              image: "https://artworks.thetvdb.com/banners/v4/episode/361887/screencap/604df7d3ecf3a.jpg",
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/img/icon1.png",
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
          title: Text(
            "I'm Luffy! The Man Who's Gonna Be King of the Pirates!",
            style: TextStyle(
              color: CustomTheme.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Alvida pirates plunder a ship only to find a barrel containing a strange boy names Luffy who is on a quest to find the legendary One Piece and become the King of Pirates.",
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
        subtitle: Row(
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
        ),
        minVerticalPadding: 10,
        tileColor: CustomTheme.grey3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
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

  int? _choiceIndex;
  Widget episodes() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 200,
      child: Scrollbar(
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            maxCrossAxisExtent: 60,
          ),
          itemCount: 50,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return ChoiceChip(
              label: Text((index + 1).toString()),
              selected: _choiceIndex == index,
              onSelected: (bool selected) {
                setState(() {
                  _choiceIndex = selected ? index : 0;
                });
              },
              elevation: 2,
              labelStyle: TextStyle(
                color: CustomTheme.white,
                // fontWeight: FontWeight.bold,
              ),
              backgroundColor: CustomTheme.grey2,
              selectedColor: CustomTheme.themeColor1,
              disabledColor: CustomTheme.grey2,
            );
          },
        ),
      ),
    );
  }

}
