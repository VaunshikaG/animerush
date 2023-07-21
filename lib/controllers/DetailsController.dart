import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/DetailsPodo.dart';
import '../model/SimilarModel.dart';
import '../utils/ApiProviders.dart';
import '../widgets/Loader.dart';

class DetailsController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();

  RxBool noData = false.obs, hasData = false.obs;
  bool showNextEp = false;

  var apiStatus = "",
      animeType = "",
      year = "",
      status = "",
      img = "".obs,
      img2 = "",
      name = "",
      desc = "",
      id = "",
      lang = "",
      duration = "",
      ep = "",
      views = "",
      studio = "",
      otherName = "",
      nextEp = "";

  List<EpDetails> epDetails = [];
  List<DetailsData> similarData = [];
  SimilarModel? similarModel;
  List<String> details = [];

  Future<void> detailsApiCall({required String? animeId}) async {
    _apiProviders.DetailsApi().then((value) {
      // _apiProviders.DetailsApi(animeId: animeId!).then((value) {
      try {
        if (value != null) {
          var responsebody = json.decode(value);
          if (responsebody["st"] == 200) {
            DetailsPodo detailsPodo = DetailsPodo.fromJson(responsebody);
            hasData.value = true;
            id = detailsPodo.data!.id.toString() ?? "-";
            name = detailsPodo.data!.name ?? "-";
            img.value = detailsPodo.data!.aniImage ?? detailsPodo.data!
                .imageHighQuality!;
            desc = detailsPodo.data!.description ?? "-";
            year = detailsPodo.data!.airedYear ?? "-";
            otherName = detailsPodo.data!.japaneseName ?? "-";
            ep = detailsPodo.data!.episodesTillNow ?? "-";
            duration = detailsPodo.data!.duration ?? "-";
            views = detailsPodo.data!.views.toString() ?? "-";
            epDetails = detailsPodo.data!.epDetails!;
            // epDetails[0].epRank!.toStringAsFixed(epDetails[0].epRank!.truncateToDouble() == epDetails[0].epRank ? 0 : 2);

            if (detailsPodo.data!.scheduleEp != null) {
              var day = detailsPodo.data!.scheduleEp!.day ?? "";
              var date = detailsPodo.data!.scheduleEp!.date ?? "";
              var time = detailsPodo.data!.scheduleEp!.time ?? "";
              if (day.isEmpty || date.isEmpty || time.isEmpty) {
                showNextEp = false;
              } else {
                nextEp = "$day $date $time";
                showNextEp = true;
              }
            } else {
              showNextEp = true;
              nextEp = "-";
            }

            for (int i = 0; i < detailsPodo.data!.studios!.length; i++) {
              studio = detailsPodo.data!.studios![i].name ?? "-";
            }

            for (int i = 0; i < detailsPodo.data!.relatedAnime!.length; i++) {
              similarData = detailsPodo.data!.relatedAnime!;

              similarModel = SimilarModel(
                id: detailsPodo.data!.relatedAnime![i].id,
                name: detailsPodo.data!.relatedAnime![i].name,
                aniImage: detailsPodo.data!.relatedAnime![i].aniImage,
                imageHighQuality: detailsPodo.data!.relatedAnime![i].imageHighQuality,
                banner: detailsPodo.data!.relatedAnime![i].banner,
                type: detailsPodo.data!.relatedAnime![i].type,
                animeWatchType: detailsPodo.data!.relatedAnime![i].animeWatchType,
                status: detailsPodo.data!.relatedAnime![i].status,
                airedYear: detailsPodo.data!.relatedAnime![i].airedYear,
                episodes: detailsPodo.data!.relatedAnime![i].episodes,
              );
            }

            if (detailsPodo.data!.animeWatchType == 'OV') {
              animeType = "Ovas";
            } else if (detailsPodo.data!.animeWatchType == 'ON') {
              animeType = "Onas";
            } else if (detailsPodo.data!.animeWatchType == 'M') {
              animeType = "Movies";
            } else if (detailsPodo.data!.animeWatchType == 'S') {
              animeType = "TV Series";
            } else if (detailsPodo.data!.animeWatchType == 'SP') {
              animeType = "Specials";
            } else {
              animeType = "-";
            }

            if (detailsPodo.data!.status == 'C') {
              status = "Completed";
            } else if (detailsPodo.data!.status == 'O') {
              status = "Ongoing";
            } else {
              status = "-";
            }

            if (detailsPodo.data!.type == 'S') {
              lang = "Subbed";
            } else if (detailsPodo.data!.type == 'D') {
              lang = "Dubbed";
            } else {
              lang = "-";
            }

            details.add(otherName);
            details.add(lang);
            details.add("$duration min");
            details.add(ep);
            details.add(views.toString());
            details.add(year);
            details.add(animeType);
            details.add(status);
            details.add(studio.toString());
            hideProgress();
          } else {
            hideProgress();
            noData.value = true;
            // CustomSnackBar(context, Text(homePodo.msg!));
          }
        }
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    });
  }
}
