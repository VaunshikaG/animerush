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

  List<Anime> animeList = [];
  int dataLength = 0;

  Future<void> watchApi(String type) async {
    print(type);
    animeList.clear();
    final prefs = await SharedPreferences.getInstance();
    try {
      // _apiProviders.WatchListApi().then((value) {
      _apiProviders.WatchListApi(type: type).then((value) {
        if (value != null) {
          var responseBody = json.decode(value);
          hideProgress();
          if (responseBody['st'] == 100) {
            WatchListPodo watchListPodo = WatchListPodo.fromJson(responseBody);
            for (int i = 0; i < watchListPodo.data!.length; i++) {
              dataLength = watchListPodo.data!.length;
              animeList.add(watchListPodo.data![i].anime!);
            }
            print(watchListPodo.data!.length);
            print(watchListPodo.data![0].typeVal);
            noData.value = false;
            showLogin.value = false;
            hasData.value = true;
          } else if (responseBody['st'] == 101) {
            print('here');
            dataLength = 0;
            showLogin.value = false;
            hasData.value = true;
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