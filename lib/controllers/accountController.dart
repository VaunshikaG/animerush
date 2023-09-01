import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/continueWatchPodo.dart';
import '../model/profilePodo.dart';
import '../model/rqModels.dart';
import '../utils/apiProviders.dart';
import '../utils/appConst.dart';
import '../utils/localStorge.dart';
import '../widgets/customSnackbar.dart';
import '../widgets/loader.dart';

class AccountController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();

  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  RxBool noData = false.obs,
      hasData = false.obs,
      showLogin = false.obs;
  var email = '', userName = '', dateJoined = '';

  List<ContinueData> continueList = [];
  int dataLength = 0;

  Future<void> profilePasswordApi() async {
    try {
      ProfilePasswordModel passwordModel = ProfilePasswordModel(
        currentPassword: passwordController.text,
        newPassword: newPasswordController.text,
      );
      _apiProviders.profilePasswordApi(model: passwordModel).then((value) {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          if (responseBody['st'] == 100) {
            // CommonResponse commonResponse = CommonResponse.fromJson(responseBody);
            newPasswordController.clear();
            passwordController.clear();
            CustomSnackBar(responseBody['msg']);
          } else {
            CustomSnackBar(responseBody['msg']);
          }
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> profileApi() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      DateTime lastApiCall =
          DateTime.parse(prefs.getString(AppConst.profileApi) ?? '1970-01-01');
      DateTime now = DateTime.now();
      if (now.isAfter(DateTime(now.year, now.month, now.day, 12, 0, 0)) &&
          lastApiCall.day != now.day) {
        _apiProviders.ProfileApi().then((value) async {
          /*if (value.isNotEmpty) {
            var responseBody = json.decode(value);
            if (responseBody['st'] == 100) {
              ProfilePodo profilePodo = ProfilePodo.fromJson(responseBody);
              email = profilePodo.data!.email.toString();
              userName = profilePodo.data!.realUsername.toString();
              dateJoined =
                  profilePodo.data!.created ?? DateTime.now().toString();
              DateTime? dateTime = DateTime.parse(dateJoined);
              dateJoined = DateFormat('dd MMM yyyy').format(dateTime);

              noData.value = false;
              hasData.value = true;
              hideProgress();
            } else if (responseBody['detail'] == "Signature has expired.") {
              prefs.setBool(AppConst.loginStatus, false);
              await prefs.clear();
              hasData.value = false;
              noData.value = false;
              showLogin.value = true;
            }
          } else {
            CustomSnackBar('error');
          }*/
        });
        await prefs.setString(AppConst.profileApi, now.toString());
      }


      // Retrieve JSON data
      var retrievedProfileData = await ProfileStorage().getProfile();
      if (retrievedProfileData.toString().isNotEmpty) {
        var responseBody = json.decode(retrievedProfileData.toString());
        if (responseBody["st"] == 100) {
          ProfilePodo profilePodo = ProfilePodo.fromJson(responseBody);
          email = profilePodo.data!.email.toString();
          userName = profilePodo.data!.realUsername.toString();
          dateJoined =
              profilePodo.data!.created ?? DateTime.now().toString();
          DateTime? dateTime = DateTime.parse(dateJoined);
          dateJoined = DateFormat('dd MMM yyyy').format(dateTime);

          noData.value = false;
          hasData.value = true;
          hideProgress();
        } else if (responseBody['detail'] == "Signature has expired.") {
          prefs.setBool(AppConst.loginStatus, false);
          await prefs.clear();
          hasData.value = false;
          noData.value = false;
          showLogin.value = true;
        }
      }

    } catch (e) {
      hideProgress();
      rethrow;
    }
  }

  Future<void> continueApi() async {
    continueList.clear();
    final prefs = await SharedPreferences.getInstance();
    try {
      _apiProviders.ContinueApi().then((value) async {
        if (value.isNotEmpty) {
          hasData.value = false;
          var responseBody = json.decode(value);
          hideProgress();
          if (responseBody['st'] == 100) {
            ContinueWatchPodo continueWatchPodo = ContinueWatchPodo.fromJson(responseBody);
            dataLength = continueList.length;
            continueList = continueWatchPodo.data!;
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