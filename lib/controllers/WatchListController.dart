import 'dart:convert';

import 'package:animerush/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/CommonResponse.dart';
import '../model/ContinueWatchPodo.dart';
import '../model/WatchListPodo.dart';
import '../screens/BottomBar.dart';
import '../utils/ApiProviders.dart';
import '../utils/AppConst.dart';
import '../widgets/CustomSnackbar.dart';

class WatchListController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();
  RxBool noData = false.obs,
      hasData = false.obs,
      showLogin = false.obs;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<Anime> animeList = [];
  List<ContinueData>? continueList = [];
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
            if (type == '00') {
              CustomSnackBar('Swipe left on anime to .');
            }
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
      _apiProviders.AddToListApi(animeId: animeId, type: type).then((value) {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          hideProgress();
          if (responseBody['st'] == 200) {
            if (type.contains('False00')) {
              Get.to(() => const BottomBar(currentIndex: 2));
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

  Future<void> continueApi() async {
    animeList.clear();
    final prefs = await SharedPreferences.getInstance();
    try {
      _apiProviders.ContinueApi().then((value) async {
        if (value.isNotEmpty) {
          hasData.value = false;
          var responseBody = json.decode(value);
          hideProgress();
          if (responseBody['st'] == 100) {
            ContinueWatchPodo continueWatchPodo = ContinueWatchPodo.fromJson(responseBody);
            dataLength = continueList!.length;
            continueList = continueWatchPodo.data;
            noData.value = false;
            hasData.value = true;
            hideProgress();
          } else if (responseBody['st'] == 101) {
            dataLength = 0;
            hasData.value = false;
            noData.value = true;
          } else if (responseBody['detail'] == "Signature has expired.") {
            prefs.setBool(AppConst.loginStatus, false);
            await prefs.clear();
            // Get.deleteAll();
            hasData.value = false;
            noData.value = false;
            Get.off(() => const BottomBar(currentIndex: 3));
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

  Future<void> profileApi() async {
    animeList.clear();
    final prefs = await SharedPreferences.getInstance();
    try {
      _apiProviders.ProfileApi().then((value) async {
        if (value.isNotEmpty) {
          // hasData.value = false;
          var responseBody = json.decode(value);
          hideProgress();
          if (responseBody['st'] == 100) {
            ContinueWatchPodo continueWatchPodo = ContinueWatchPodo.fromJson(responseBody);
            dataLength = continueList!.length;
            continueList = continueWatchPodo.data;
            noData.value = false;
            showLogin.value = false;
            hasData.value = true;
            hideProgress();
          } else if (responseBody['st'] == 101) {
            dataLength = 0;
            showLogin.value = false;
            hasData.value = false;
            noData.value = true;
          } else if (responseBody['detail'] == "Signature has expired.") {
            prefs.setBool(AppConst.loginStatus, false);
            await prefs.clear();
            // Get.deleteAll();
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
