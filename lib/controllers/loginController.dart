// ignore_for_file: unused_import, unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:animerush/utils/appConst.dart';
import 'package:animerush/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/commonResponse.dart';
import '../model/continueWatchPodo.dart';
import '../model/loginPodo.dart';
import '../model/profilePodo.dart';
import '../model/rqModels.dart';
import '../screens/bottomBar.dart';
import '../utils/apiProviders.dart';
import '../widgets/customSnackbar.dart';

class LoginController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();
  RxBool isUserLoggedIn = false.obs,
      isLogin = true.obs,
      isSignin = false.obs,
      isForgot = false.obs,
      isOtp = false.obs,
      isPassword = false.obs,
      isChangePass = false.obs,
      showPg = false.obs;

  var message;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  Future<void> loginApi() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      LoginModel loginModel = LoginModel(
        username: userNameController.text,
        password: passwordController.text,
      );
      _apiProviders.loginApi(model: loginModel).then((value) {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          if (responseBody['st'] == 100) {
            showPg.value = false;
            prefs.setBool(AppConst.loginStatus, true);
            isLogin.value = false;
            isUserLoggedIn.value = true;
            LoginPodo loginPodo = LoginPodo.fromJson(responseBody);
            prefs.setString(AppConst.token, loginPodo.data!.jwtToken!);
            hideProgress();
            Get.to(() => const BottomBar(currentIndex: 0, checkVersion: false));
            CustomSnackBar("Login Successful");
            // userNameController.clear();
            // emailController.clear();
            passwordController.clear();
            otpController.clear();
          } else if (responseBody['st'] == 101) {
            hideProgress();
            CustomSnackBar(responseBody['msg']);
          } else {
            hideProgress();
            CustomSnackBar(responseBody['msg']);
          }
        }
      });
    } catch (e) {
      hideProgress();
      rethrow;
    }
  }

  Future<void> signUpApi() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      SignUpModel signUpModel = SignUpModel(
        username: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      _apiProviders.signUpApi(model: signUpModel).then((value) {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          if (responseBody['st'] == 100) {
            CommonResponse commonResponse =
                CommonResponse.fromJson(responseBody);
            message = commonResponse.msg;
            CustomSnackBar(message);
            hideProgress();
            isSignin.value = false;
            isLogin.value = true;
            userNameController.clear();
            emailController.clear();
            passwordController.clear();
            otpController.clear();
          } else if (responseBody['st'] == 101) {
            hideProgress();
            isSignin.value = true;
            isLogin.value = false;
            message = responseBody['msg'];
          } else {
            hideProgress();
            CustomSnackBar(responseBody['msg']);
          }
        }
      });
    } catch (e) {
      hideProgress();
      rethrow;
    }
  }

  Future<void> otpApi() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString(AppConst.otp, otpController.text);
      OtpVerfiyModel otpVerfiyModel = OtpVerfiyModel(
        email: prefs.getString(AppConst.email),
        otp: otpController.text,
      );
      _apiProviders.otpVerfiyApi(model: otpVerfiyModel).then((value) {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          if (responseBody['st'] == 100) {
            CommonResponse commonResponse =
                CommonResponse.fromJson(responseBody);
            hideProgress();
            isOtp.value = false;
            isPassword.value = true;
            userNameController.clear();
            emailController.clear();
            passwordController.clear();
            otpController.clear();
            CustomSnackBar(responseBody['msg']);
          } else if (responseBody['st'] == 101) {
            hideProgress();
            CustomSnackBar(responseBody['msg']);
          } else {
            hideProgress();
            CustomSnackBar(responseBody['msg']);
          }
        }
      });
    } catch (e) {
      hideProgress();
      rethrow;
    }
  }

  Future<void> forgotPasswordApi() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString(AppConst.email, emailController.text);
      _apiProviders
          .forgotPasswordApi(email: emailController.text)
          .then((value) {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          if (responseBody['st'] == 100) {
            CommonResponse commonResponse =
                CommonResponse.fromJson(responseBody);
            hideProgress();
            isForgot.value = false;
            isOtp.value = true;
            userNameController.clear();
            emailController.clear();
            passwordController.clear();
            otpController.clear();
            CustomSnackBar(responseBody['msg']);
          } else if (responseBody['st'] == 101) {
            hideProgress();
            CustomSnackBar(responseBody['msg']);
          } else {
            hideProgress();
            CustomSnackBar(responseBody['msg']);
          }
        }
      });
    } catch (e) {
      hideProgress();
      rethrow;
    }
  }

  Future<void> changePasswordApi() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      ChangePasswordModel changePasswordModel = ChangePasswordModel(
        otp: prefs.getString(AppConst.otp),
        email: prefs.getString(AppConst.email),
        password: passwordController.text,
      );
      _apiProviders.changePasswordApi(model: changePasswordModel).then((value) {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          if (responseBody['st'] == 100) {
            CommonResponse commonResponse =
                CommonResponse.fromJson(responseBody);
            hideProgress();
            isLogin.value = true;
            isPassword.value = false;
            userNameController.clear();
            emailController.clear();
            passwordController.clear();
            otpController.clear();
            CustomSnackBar(responseBody['msg']);
          } else if (responseBody['st'] == 101) {
            hideProgress();
            CustomSnackBar(responseBody['msg']);
          } else {
            hideProgress();
            CustomSnackBar(responseBody['msg']);
          }
        }
      });
    } catch (e) {
      hideProgress();
      rethrow;
    }
  }
}
