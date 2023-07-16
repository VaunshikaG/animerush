import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/HomePodo.dart';
import '../utils/ApiProviders.dart';
import '../widgets/CustomSnackbar.dart';
import '../widgets/Loader.dart';

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
    final prefs = await SharedPreferences.getInstance();
    try {
      _apiProviders.HomeApi().then((value) {
        if (value != null) {
          var responsebody = json.decode(value);
          if (responsebody["st"] == 200) {
            HomePodo homePodo = HomePodo.fromJson(responsebody);
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
            CustomSnackBar(responsebody["msg"]);
          }
        }
      });
    } catch (e) {
      noData.value = true;
      rethrow;
    }
  }

}