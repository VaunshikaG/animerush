import 'dart:convert';

import 'package:animerush/utils/appConst.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/homePodo.dart';
import '../utils/apiProviders.dart';
import '../utils/localStorge.dart';
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
      final prefs = await SharedPreferences.getInstance();
      DateTime lastApiCall = DateTime.parse(prefs.getString(AppConst.homeApi)
          ?? DateTime.now().toString());
      DateTime now = DateTime.now();
      if (now.isAfter(DateTime(now.year, now.month, now.day, 12, 0, 0)) &&
          lastApiCall.day != now.day) {
        _apiProviders.homeApi().then((value) {
          /*if (value.isNotEmpty) {
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
        }*/
        });
        await prefs.setString(AppConst.homeApi, now.toString());
      }

      // Retrieve JSON data
      var retrievedHomeData = await HomeStorage().getHomeData();
      if (retrievedHomeData.toString().isNotEmpty) {
        var responseBody = json.decode(retrievedHomeData.toString());
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

    } catch (e) {
      noData.value = true;
      rethrow;
    }
  }
}
