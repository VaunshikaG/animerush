import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/DetailsPodo.dart';
import '../model/EpDetailPodo.dart';
import '../model/VdResolutionModel.dart';
import '../utils/ApiProviders.dart';
import '../utils/AppConst.dart';
import '../widgets/Loader.dart';

class EpisodeController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();

  RxBool noData = false.obs, hasData = false.obs, showLogin = false.obs;
  var apiStatus = "",
      animeId = "",
      w_title = "",
      w_name = "",
      w_desc = "";
  Data epData = Data();
  List<DownloadEpisodeLink> dwldList = [];
  List<EpDetails> anime = [];
  VdResolutionModel? vdResolutionModel;

  Future<void> episodeApiCall({required String epId}) async {
    final prefs = await SharedPreferences.getInstance();
    dwldList.clear();
    anime.clear();
    // _apiProviders.episodeApi().then((value) {
    _apiProviders.EpisodeApi(episodeId: epId).then((value) {
      try {
        if (value.isNotEmpty) {
          hasData.value = false;
          var responseBody = json.decode(value);
          if (responseBody["st"] == 200) {
            EpDetailPodo epDetailPodo = EpDetailPodo.fromJson(responseBody);
            epData = epDetailPodo.data!;
            dwldList = epDetailPodo.data!.downloadEpisodeLink!;
            update([hasData.value = true, epData = epDetailPodo.data!,
              dwldList = epDetailPodo.data!.downloadEpisodeLink!, anime], true);
            hasData.value = true;
            hideProgress();
          } else if (responseBody['detail'] == "Signature has expired.") {
            prefs.setBool(AppConst.loginStatus, false);
            hasData.value = false;
            noData.value = false;
            showLogin.value = true;
            hideProgress();
          } else if (responseBody['detail'] == "Invalid Authorization header. No credentials provided.") {
            prefs.setBool(AppConst.loginStatus, false);
            hasData.value = false;
            noData.value = false;
            showLogin.value = true;
            hideProgress();
          }
        }
      } catch (e) {
        rethrow;
      }
    });
  }

  Future<String> downloadEp({required String url, required String name}) async {
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
        url: url,
        // "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        savedDir: path.path,
        showNotification: true,
        saveInPublicStorage: true,
        openFileFromNotification: true,
        fileName: "$name.mp4",
        allowCellular: true,
        requiresStorageNotLow: true,
      );
      return path.path;
    } else {
      path.create();
      await FlutterDownloader.enqueue(
        url: url,
        // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        savedDir: path.path,
        showNotification: true,
        saveInPublicStorage: true,
        openFileFromNotification: true,
        fileName: "$name.mp4",
        allowCellular: true,
        requiresStorageNotLow: true,
      );
      return path.path;
    }
  }

}
