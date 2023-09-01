import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/detailsPodo.dart';
import '../model/similarModel.dart';
import '../utils/apiProviders.dart';
import '../utils/appConst.dart';
import '../widgets/loader.dart';

class DetailsController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();

  RxBool noData = false.obs,
      hasData = false.obs,
      showLogin = false.obs,
      showNextEp = true.obs;
  int length = 0;
  RxString img = ''.obs;
  String? apiStatus,
      animeType,
      year,
      status,
      img2,
      name,
      desc,
      id,
      lang,
      duration,
      ep,
      views,
      studio,
      otherName,
      nextEp;

  List<EpDetails> epDetails = [];
  List<DetailsData> similarData = [];
  SimilarModel? similarModel;
  List<String> details = [];
  DetailsData? detailsData;

  Future<void> detailsApiCall({required String? animeId}) async {
    final prefs = await SharedPreferences.getInstance();
    // _apiProviders.detailsApi().then((value) {
    _apiProviders.DetailsApi(animeId: animeId!).then((value) {
      try {
        if (value.isNotEmpty) {
          hasData.value = false;
          var responseBody = json.decode(value);
          if (responseBody["st"] == 200) {
            DetailsPodo detailsPodo = DetailsPodo.fromJson(responseBody);
            hasData.value = true;
            detailsData = detailsPodo.data;
            id = detailsPodo.data!.id.toString();
            name = detailsPodo.data!.name ?? "-";
            img.value = detailsPodo.data!.aniImage ??
                detailsPodo.data!.imageHighQuality!;
            desc = detailsPodo.data!.descriptionClear ?? "-";
            year = detailsPodo.data!.airedYear ?? "-";
            otherName = detailsPodo.data!.synonyms ?? "-";
            ep = detailsPodo.data!.episodesTillNow ?? "-";
            duration = detailsPodo.data!.duration ?? "-";
            views = detailsPodo.data!.views.toString();
            epDetails = detailsPodo.data!.epDetails!;
            length = detailsPodo.data!.epDetails!.length;

            if (detailsPodo.data!.scheduleEp != null) {
              var day = detailsPodo.data!.scheduleEp!.day ?? "";
              var date = detailsPodo.data!.scheduleEp!.date ?? "";
              var time = detailsPodo.data!.scheduleEp!.time ?? "";
              if (day.isEmpty || date.isEmpty || time.isEmpty) {
                showNextEp.value = false;
              } else {
                nextEp = "$day $date $time";
                showNextEp.value = true;
              }
            } else {
              showNextEp.value = true;
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
                imageHighQuality:
                    detailsPodo.data!.relatedAnime![i].imageHighQuality,
                banner: detailsPodo.data!.relatedAnime![i].banner,
                type: detailsPodo.data!.relatedAnime![i].type,
                animeWatchType:
                    detailsPodo.data!.relatedAnime![i].animeWatchType,
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

            details.add(detailsPodo.data!.synonyms.toString());
            details.add(lang!);
            details.add("$duration min");
            details.add(ep!);
            details.add(year!);
            details.add(animeType!);
            details.add(status!);
            details.add(studio.toString());
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
        rethrow;
      }
    });
  }
}
