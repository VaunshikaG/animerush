// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/rqModels.dart';
import '../model/searchPodo.dart';
import '../model/similarModel.dart';
import '../screens/bottomBar.dart';
import '../screens/category.dart';
import '../screens/search.dart';
import '../utils/apiProviders.dart';
import '../utils/appConst.dart';
import '../widgets/loader.dart';

class Search_Controller extends GetxController {
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();

  final ApiProviders _apiProviders = ApiProviders();
  RxBool isTyping = false.obs,
      noData = false.obs,
      hasData = false.obs,
      showChips = true.obs,
      showLogin = false.obs, isListLoading = false.obs,
      isPageLoading = true.obs,
  isSelected = false.obs;
  SearchModel? searchModel;
  List<String> searchHistory = [];
  List<AnimeList> animeList = [];
  List<SimilarModel> list = [];
  String categoryType = "",
      genreType = "",
      value1 = "",
      value2 = "",
      displayName = "", currentPg = '1', nextPg = '1', previousPg = '1',
      maxPg = '';
  TextEditingController searchText = TextEditingController();

  Future<void> searchApiCall(
      {required SearchModel searchModel,
      required String pgName,
      required BuildContext ctx}) async {
    await showProgress(ctx, true);
    final prefs = await SharedPreferences.getInstance();

    _apiProviders.SearchApi(model: searchModel).then((value) {
      try {
        if (value.isNotEmpty) {
          hasData.value = false;
          var responseBody = json.decode(value);
          if (responseBody["st"] == 200) {
            animeList.clear();
            if (pgName.contains("drawer")) {
              // Get.back();
              // Get.off(() => const BottomBar(currentIndex: 1, checkVersion: false));
              searchText.text = '';
              showChips.value = false;
              print('object');
            } else if (pgName == "chips") {
              print('chips');
            } else if (pgName == "searchField") {
              // showChips.value = false;
            }
            SearchPodo searchPodo = SearchPodo.fromJson(responseBody);
            hasData.value = true;
            isPageLoading.value = false;
            hideProgress();
            if (searchModel.pageId!.isNotEmpty) {
              scrollController.jumpTo(0);
            }
            animeList = searchPodo.data!.animeList!;

            displayName = searchPodo.data!.displayContentName!;
            currentPg = searchPodo.data!.currentPage.toString();
            nextPg = searchPodo.data!.nextPage.toString();
            previousPg = searchPodo.data!.previousPage.toString();
            maxPg = searchPodo.data!.maxPageCounter.toString();

          } else if (responseBody['st'] == 101) {
            animeList = [];
            showLogin.value = false;
            noData.value = false;
            hasData.value = true;
            hideProgress();
            // CustomSnackBar(responseBody['msg']);
          } else if (responseBody['detail'] == "Signature has expired.") {
            prefs.setBool(AppConst.loginStatus, false);
            hasData.value = false;
            noData.value = false;
            showChips.value = false;
            showLogin.value = true;
          } else if (responseBody['detail'] ==
              "Invalid Authorization header. No credentials provided.") {
            Get.back();
            // scaffoldKey.currentState!.closeDrawer();
            // Get.off(() => const BottomBar(currentIndex: 1, checkVersion: false));
            print('here');
            prefs.setBool(AppConst.loginStatus, false);
            hasData.value = false;
            noData.value = false;
            showChips.value = false;
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
