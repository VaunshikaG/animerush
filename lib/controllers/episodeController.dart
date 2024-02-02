import 'dart:async';
import 'dart:convert';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/epDetailPodo.dart';
import '../model/vdResolutionModel.dart';
import '../utils/apiProviders.dart';
import '../utils/appConst.dart';
import '../utils/theme.dart';
import '../widgets/loader.dart';

class EpisodeController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();

  RxBool noData = false.obs,
      hasData = false.obs,
      showLogin = false.obs,
      loading = true.obs,
      showPg = false.obs;
  String? apiStatus = "",
      animeId = "",
      w_title = "",
      w_name = "",
      w_desc = "",
      vdUrl,
      dwldLink,
      webLink,
      embdLink,
      streamsbLink,
      xstreamcdnLink,
      doodstreamLink,
      playerUrl,
      epRank;
  Data epData = Data();
  // List<DownloadEpisodeLink>? dwldList;
  VdResolutionModel? vdResolutionModel;
  late BetterPlayerController betterPlayerController;
  final GlobalKey betterPlayerKey = GlobalKey();

  Future<void> episodeApiCall({required String epId}) async {
    final prefs = await SharedPreferences.getInstance();
    _apiProviders.EpisodeApi(episodeId: epId).then((value) {
      try {
        if (value.isNotEmpty) {
          hasData.value = false;
          var responseBody = json.decode(value);
          if (responseBody["st"] == 200) {
            EpDetailPodo epDetailPodo = EpDetailPodo.fromJson(responseBody);
            epData = epDetailPodo.data!;
            epRank = epData.epRank.toString();
            vdUrl = epData.episodeLink!.file;
            // dwldLink = "";
            dwldLink = "${AppConst.app_weburl}${epData.streamDetails!.download}";
            webLink = epData.webEpisodeUrl;
            embdLink = epData.allResponce!.embdLink;
            streamsbLink = epData.allResponce!.streamsbLink;
            xstreamcdnLink = epData.allResponce!.xstreamcdnLink;
            doodstreamLink = epData.allResponce!.doodstreamLink;
            playerUrl = webLink ?? embdLink ?? streamsbLink ??
                xstreamcdnLink ?? doodstreamLink ?? dwldLink;

            betterPlayerController = BetterPlayerController(
                betterPlayerDataSource: BetterPlayerDataSource(
                  BetterPlayerDataSourceType.network,
                  vdUrl!,
                  bufferingConfiguration:
                  const BetterPlayerBufferingConfiguration(
                    minBufferMs: 60000,
                    maxBufferMs: 555000,
                  ),
                  cacheConfiguration: const BetterPlayerCacheConfiguration(
                    useCache: true,
                    preCacheSize: 400000,
                    maxCacheSize: 400000,
                    maxCacheFileSize: 400000,
                  ),
                  videoFormat: BetterPlayerVideoFormat.hls,
                  headers: {
                    'User-Agent':
                    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'
                  },
                  // resolutions: Map.fromEntries(
                  //   epDetailPodo.data!.downloadEpisodeLink!.map(
                  //     (link) => MapEntry(link.quality!, link.link!),
                  //   ),
                  // ),
                  notificationConfiguration:
                  BetterPlayerNotificationConfiguration(
                    showNotification: true,
                    title: epDetailPodo.data!.episodeTitle.toString(),
                    author: "animerush.in",
                    imageUrl: epDetailPodo.data!.image ??
                        "https://animerush.in/media/image/no_poster.jpg",
                  ),
                ),
                BetterPlayerConfiguration(
                  autoDetectFullscreenAspectRatio: false,
                  handleLifecycle: true,
                  autoDetectFullscreenDeviceOrientation: true,
                  allowedScreenSleep: false,
                  autoDispose: true,
                  fullScreenByDefault: false,
                  fullScreenAspectRatio: 16 / 9,
                  deviceOrientationsAfterFullScreen: [
                    DeviceOrientation.portraitUp
                  ],
                  aspectRatio: 16 / 9,
                  fit: BoxFit.contain,
                  looping: false,
                  autoPlay: false,
                  placeholderOnTop: true,
                  placeholder: Image.network(
                    epDetailPodo.data!.image ??
                        "https://animerush.in/media/image/no_poster.jpg",
                    fit: BoxFit.contain,
                  ),
                  controlsConfiguration: BetterPlayerControlsConfiguration(
                    controlBarColor: CustomTheme.transparent,
                    iconsColor: CustomTheme.white,
                    progressBarBufferedColor: CustomTheme.white,
                    progressBarPlayedColor: CustomTheme.themeColor1,
                    loadingColor: CustomTheme.themeColor1,
                    progressBarHandleColor: CustomTheme.themeColor1,
                    playIcon: Icons.play_arrow,
                    muteIcon: Icons.volume_up_sharp,
                    unMuteIcon: Icons.volume_off_sharp,
                    pipMenuIcon: Icons.picture_in_picture,
                    enablePip: true,
                    enableRetry: true,
                    enableQualities: false,
                    enableSubtitles: false,
                    overflowMenuCustomItems: [
                      BetterPlayerOverflowMenuItem(
                        Icons.picture_in_picture,
                        "Picture in Picture",
                            () =>
                            betterPlayerController
                                .enablePictureInPicture(betterPlayerKey),
                      ),
                    ],
                  ),
                ),
              );
            betterPlayerController.setOverriddenFit(BoxFit.contain);
            betterPlayerController.enablePictureInPicture(betterPlayerKey);
            betterPlayerController.setControlsAlwaysVisible(true);

            loading.value = false;
            showPg.value = true;
            hasData.value = true;
            hideProgress();
          } else if (responseBody['detail'] == "Signature has expired.") {
            prefs.setBool(AppConst.loginStatus, false);
            hasData.value = false;
            noData.value = false;
            showLogin.value = true;
            hideProgress();
          } else if (responseBody['detail'] ==
              "Invalid Authorization header. No credentials provided.") {
            prefs.setBool(AppConst.loginStatus, false);
            hasData.value = false;
            noData.value = false;
            showLogin.value = true;
            hideProgress();
          }
        }
      } catch (e) {
        hideProgress();
        loading.value = false;
        rethrow;
      }
    });
  }
}
