import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../model/DetailsPodo.dart';
import '../model/EpDetailPodo.dart';
import '../model/VdResolutionModel.dart';
import '../utils/ApiProviders.dart';
import '../widgets/Loader.dart';

class EpisodeController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();

  RxBool noData = false.obs, hasData = false.obs;
  var apiStatus = "",
      animeId = "",
      playerURL = "",
      epImg = "".obs,
      title = "",
      name = "",
      desc = "",
      w_title = "",
      w_name = "",
      w_desc = "";
  List<DownloadEpisodeLink> dwldList = [];
  List<EpDetails> anime = [];
  List<int> idList = [];
  VdResolutionModel? vdResolutionModel;

  Future<void> episodeApiCall() async {
    _apiProviders.episodeApi().then((value) {
    // _apiProviders.EpisodeApi(episodeId: animeId.toString()).then((value) {
      try {
        if (value.isNotEmpty) {
          var responsebody = json.decode(value);
          if (responsebody["st"] == 200) {
            EpDetailPodo epDetailPodo = EpDetailPodo.fromJson(responsebody);
            hasData.value = true;
            // for (int i = 0; i < epDetailPodo.data!.episodeLink!.length; i++) {
              playerURL = epDetailPodo.data!.episodeLink!.file!;
            // }
            epImg.value = epDetailPodo.data!.image ?? "https://animerush.in/media/image/no_poster.jpg";
            hideProgress();
            title = epDetailPodo.data!.episodeTitle ?? w_title ?? "";
            name = epDetailPodo.data!.episodeName ?? w_name ?? "";
            desc = epDetailPodo.data!.videoDetails ?? w_desc ?? "";
            dwldList = epDetailPodo.data!.downloadEpisodeLink!;
          } else {
            hideProgress();
            noData.value = true;
            // CustomSnackBar(context, Text(homePodo.msg!));
          }
        }
      } catch (e) {
        rethrow;
      }
    });
  }

}
