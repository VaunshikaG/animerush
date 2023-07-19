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

  bool hasRemainingEp = false;
  int remainingEp = 0, totalChipCount = 0, finalChipCount = 0, startVal = 0;
  var start = '', end = '', rangeIndex = 0.obs, selectedIndex = 9999999.obs;
  RxList<EpDetails> epChunkList = <EpDetails>[].obs;
  List<EpDetails> anime = [];
  List<int> idList = [];
  VdResolutionModel? vdResolutionModel;

  Future<void> episodeApiCall() async {
    if ((anime.length % 100).floor() < 100) {
      print((anime.length % 100).toString());
      hasRemainingEp = true;
      remainingEp = (anime.length % 100).floor();
    }
    totalChipCount = (anime.length / 100).floor();
    epChunkList.value = anime.sublist(
        0, (hasRemainingEp == true && anime.length < 100) ? remainingEp : 100);
    finalChipCount = totalChipCount + (hasRemainingEp ? 1 : 0);

    print('Ep Chunk List ${epChunkList.length} + $remainingEp');
    print((anime.length % 100).floor());
    print(totalChipCount);
    print(finalChipCount);
    // int str1 = int.parse(start);
    // int str2 = int.parse(end);
    // log(epChunkList.getRange(str1, str2).toString());

    _apiProviders.EpisodeApi().then((value) {
    // _apiProviders.EpisodeApi(episodeId: animeId.toString()).then((value) {
      try {
        if (value != null) {
          var responsebody = json.decode(value);
          if (responsebody["st"] == 200) {
            EpDetailPodo epDetailPodo = EpDetailPodo.fromJson(responsebody);
            hasData.value = true;
            for (int i = 0; i < epDetailPodo.data!.episodeLink!.length; i++) {
              playerURL = epDetailPodo.data!.episodeLink![i].file!;
            }
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
