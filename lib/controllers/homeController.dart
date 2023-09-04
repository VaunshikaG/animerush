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

  Future<void> homeApiCall() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      DateTime now = DateTime.now();
      DateTime lastApiCall =
          DateTime.parse(prefs.getString(AppConst.lastHomeApi) ?? '1970-01-01');
      if (lastApiCall.day != now.day) {
        _apiProviders.homeApi().then((value) {
          getHomeData();
        });
        await prefs.setString(AppConst.lastHomeApi, now.toString());
      } else {
        getHomeData();
      }

    } catch (e) {
      noData.value = true;
      rethrow;
    }
  }

  Future<void> getHomeData() async {
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
  }
}
