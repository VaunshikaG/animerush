import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../model/RqModels.dart';
import '../model/SearchPodo.dart';
import '../screens/BottomBar.dart';
import '../utils/ApiProviders.dart';
import '../widgets/Loader.dart';

class Search_Controller extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();
  RxBool isTyping = false.obs, noData = false.obs, hasData = false.obs,
      showChips = true.obs, showHistory = true.obs;
  SearchModel? searchModel;
  List<String> searchHistory = [];
  List<AnimeList> animeList = [];
  String categoryType = "", genreType = "", value1 = "", value2 = "", displayName = "";
  int currentPg = 1, nextPg = 1, previousPg = 1;

  Future<void> searchApiCall({required SearchModel searchModel, required String pgName}) async {
    _apiProviders.searchApi().then((value) {
      // _apiProviders.SearchApi(model: searchModel).then((value) {
      log(searchModel.toJson().toString());
      try {
        if (value.isNotEmpty) {
          var responsebody = json.decode(value);
          if (responsebody["st"] == 200) {
            SearchPodo searchPodo = SearchPodo.fromJson(responsebody);
            hasData.value = true;
            if (pgName == "drawer") {
              showChips.value = false;
              showHistory.value = false;
              Get.off(() => const BottomBar(currentIndex: 1));
            } else if (pgName == "chips") {
              showHistory.value = false;
            } else if (pgName == "searchField") {
              showChips.value = false;
              showHistory.value = true;
            }
            for (int i = 0; i < searchPodo.data!.animeList!.length; i++) {
              animeList = searchPodo.data!.animeList!;
            }
            displayName = searchPodo.data!.displayContentName!;
            currentPg = searchPodo.data!.currentPage!;
            nextPg = searchPodo.data!.nextPage!;
            previousPg = searchPodo.data!.previousPage!;
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