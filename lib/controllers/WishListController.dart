import 'dart:convert';
import 'dart:developer';

import 'package:animerush/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/RqModels.dart';
import '../model/WatchListPodo.dart';
import '../utils/ApiProviders.dart';
import '../utils/AppConst.dart';
import '../widgets/CustomSnackbar.dart';

class WishListController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();
  RxBool noData = false.obs, hasData = false.obs, showLogin = false.obs;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> watchApi(String type) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      WatchListModel watchModel = WatchListModel(type: type);
      _apiProviders.WatchListApi().then((value) {
      // _apiProviders.WatchListApi(model: watchModel).then((value) {
        if (value != null) {
          var responseBody = json.decode(value);
          hideProgress();
          if (responseBody['st'] == 100) {
            WatchListPodo watchListPodo = WatchListPodo.fromJson(responseBody);
            noData.value = false;
            showLogin.value = false;
            hasData.value = true;
          } else if (responseBody['st'] == 101) {
            showLogin.value = false;
            hasData.value = false;
            noData.value = true;
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