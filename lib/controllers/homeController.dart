import 'dart:convert';

import 'package:get/get.dart';

import '../model/homePodo.dart';
import '../utils/apiProviders.dart';
import '../widgets/customSnackbar.dart';
import '../widgets/loader.dart';

class HomeController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();

  RxBool noData = false.obs, hasData = false.obs;
  var animeType, year, status, img;
  List<IsSpotlightData> spotlightData = [];
  List<TopStreamingData> topData = [];
  List<LatestMoviesData> moviesData = [];
  List<LatestSpecialData> specialData = [];
  List<LatestOnasData> onasData = [];
  List<LatestOvasData> ovasData = [];
  List<RecentlyAddedSubData> subData = [];
  List<RecentlyAddedDubData> dubData = [];

  void homeApiCall() async {
    try {
      _apiProviders.homeApi().then((value) {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          if (responseBody["st"] == 200) {
            HomePodo homePodo = HomePodo.fromJson(responseBody);
            hideProgress();
            spotlightData = homePodo.isSpotlightData!;
            topData = homePodo.topStreamingData!;
            specialData = homePodo.latestSpecialData!;
            moviesData = homePodo.latestMoviesData!;
            onasData = homePodo.latestOnasData!;
            ovasData = homePodo.latestOvasData!;
            subData = homePodo.recentlyAddedSubData!;
            dubData = homePodo.recentlyAddedDubData!;

            hasData.value = true;
          } else {
            hideProgress();
            noData.value = true;
            CustomSnackBar(responseBody["msg"]);
          }
        }
      });
    } catch (e) {
      noData.value = true;
      rethrow;
    }
  }
}