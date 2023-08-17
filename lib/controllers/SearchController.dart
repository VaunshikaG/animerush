import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/RqModels.dart';
import '../model/SearchPodo.dart';
import '../screens/BottomBar.dart';
import '../utils/ApiProviders.dart';
import '../utils/AppConst.dart';
import '../widgets/Loader.dart';

class Search_Controller extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();
  RxBool isTyping = false.obs,
      noData = false.obs,
      hasData = false.obs,
      showChips = true.obs,
      showHistory = true.obs,
      showLogin = false.obs;
  SearchModel? searchModel;
  List<String> searchHistory = [];
  List<AnimeList> animeList = [];
  String categoryType = "",
      genreType = "",
      value1 = "",
      value2 = "",
      displayName = "";
  int currentPg = 1, nextPg = 1, previousPg = 1;

  Future<void> searchApiCall(
      {required SearchModel searchModel, required String pgName}) async {
    final prefs = await SharedPreferences.getInstance();
    // _apiProviders.searchApi().then((value) {
    _apiProviders.SearchApi(model: searchModel).then((value) {
      try {
        if (value.isNotEmpty) {
          hasData.value = false;
          var responseBody = json.decode(value);
          if (responseBody["st"] == 200) {
            if (pgName == "drawer") {
              Get.off(() => const BottomBar(currentIndex: 1));
              Get.back();
              showChips.value = false;
              showHistory.value = false;
            } else if (pgName == "chips") {
              showHistory.value = false;
            } else if (pgName == "searchField") {
              showChips.value = false;
              showHistory.value = true;
            }
            SearchPodo searchPodo = SearchPodo.fromJson(responseBody);
            for (int i = 0; i < searchPodo.data!.animeList!.length; i++) {
              animeList = searchPodo.data!.animeList!;
            }
            displayName = searchPodo.data!.displayContentName!;
            currentPg = searchPodo.data!.currentPage!;
            nextPg = searchPodo.data!.nextPage!;
            previousPg = searchPodo.data!.previousPage!;
            hasData.value = true;
            hideProgress();
          } else if (responseBody['detail'] == "Signature has expired.") {
            prefs.setBool(AppConst.loginStatus, false);
            hasData.value = false;
            noData.value = false;
            showChips.value = false;
            showHistory.value = false;
            showLogin.value = true;
          } else if (responseBody['detail'] == "Invalid Authorization header. No credentials provided.") {
            prefs.setBool(AppConst.loginStatus, false);
            Get.offAll(() => const BottomBar(currentIndex: 3));
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
