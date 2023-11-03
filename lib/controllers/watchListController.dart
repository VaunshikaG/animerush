import 'dart:convert';

import 'package:animerush/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/commonResponse.dart';
import '../model/continueWatchPodo.dart';
import '../model/watchListPodo.dart';
import '../screens/bottomBar.dart';
import '../utils/apiProviders.dart';
import '../utils/appConst.dart';
import '../widgets/customSnackbar.dart';

class WatchListController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();
  RxBool noData = false.obs, hasData = false.obs, showLogin = false.obs;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<Anime> animeList = [];
  List<ContinueData> continueList = [];
  int dataLength = 0;

  Future<void> watchApi(String type) async {
    // hasData.value = false;
    animeList.clear();
    final prefs = await SharedPreferences.getInstance();
    try {
      // _apiProviders.watchListApi().then((value) {
      _apiProviders.WatchListApi(type: type).then((value) {
        if (value.isNotEmpty) {
          hasData.value = false;
          var responseBody = json.decode(value);
          if (responseBody['st'] == 100) {
            WatchListPodo watchListPodo = WatchListPodo.fromJson(responseBody);
            for (int i = 0; i < watchListPodo.data!.length; i++) {
              dataLength = watchListPodo.data!.length;
              animeList.add(watchListPodo.data![i].anime!);
            }
            hasData.value = true;
            noData.value = false;
            showLogin.value = false;
            hideProgress();
          } else if (responseBody['st'] == 101) {
            dataLength = 0;
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
        } else {
          CustomSnackBar('error');
        }
      });
    } catch (e) {
      hideProgress();
      rethrow;
    }
  }

  Future<void> addToListApi(
      {required String type, required String animeId}) async {
    animeList.clear();
    final prefs = await SharedPreferences.getInstance();
    try {
      // _apiProviders.addToListApi().then((value) {
      _apiProviders.AddToListApi(animeId: animeId, type: type)
          .then((value) async {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          hideProgress();
          if (responseBody['st'] == 200) {
            if (type.contains('False00')) {
              await watchApi('00');
              Get.to(
                  () => const BottomBar(currentIndex: 2, checkVersion: false));
            }
            CommonResponse commonResponse =
                CommonResponse.fromJson(responseBody);
            CustomSnackBar(commonResponse.msg!);
          } else if (responseBody['detail'] == "Signature has expired.") {
            prefs.setBool(AppConst.loginStatus, false);
            hasData.value = false;
            noData.value = false;
            showLogin.value = true;
          }
        } else {
          CustomSnackBar('error');
        }
      });
    } catch (e) {
      hideProgress();
      rethrow;
    }
  }
}
