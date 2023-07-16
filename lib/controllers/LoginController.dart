import 'dart:convert';

import 'package:animerush/utils/AppConst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/CommonResponse.dart';
import '../model/login/LoginPodo.dart';
import '../model/login/RqModels.dart';
import '../screens/BottomBar.dart';
import '../utils/ApiProviders.dart';
import '../widgets/CustomSnackbar.dart';

class LoginController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();
  bool isLoggedIn = false,
      isLogin = true,
      isSignin = false,
      isForgot = false,
      isOtp = false,
      isPassword = false;
  var message, apiStatus;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void onReady() {
    super.onReady();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    // isLoggedIn = prefs.getBool(AppConst.LOGINSTATUS)!;
    isLoggedIn = true;
    isLogin = true;
    isSignin = false;
    isForgot = false;
    isOtp = false;
    isPassword = false;
  }

  Future<void> loginApi() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      LoginModel loginModel = LoginModel(
        username: userNameController.text,
        password: passwordController.text,
      );
      _apiProviders.LoginApi(model: loginModel).then((value) {
        if (value != null) {
          var responseBody = json.decode(value);
          LoginPodo loginPodo = LoginPodo.fromJson(responseBody);
          if (loginPodo.st == ("100")) {
            prefs.setString(AppConst.token, loginPodo.data!.jwtToken!);
            prefs.setString(AppConst.userName, loginPodo.data!.username!);
            Get.to(() => const BottomBar(currentIndex: 0));
          } else {
            CustomSnackBar(loginPodo.msg!);
          }
        }
      });
    } catch (e) {
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
      _apiProviders.SignUpApi(model: signUpModel).then((value) {
        if (value != null) {
          var responseBody = json.decode(value);
          CommonResponse commonResponse = CommonResponse.fromJson(responseBody);
          if (commonResponse.st == ("100")) {
            message = commonResponse.msg;
          } else if (commonResponse.st == ("101")) {
            message = commonResponse.msg;
          } else {
            CustomSnackBar(commonResponse.msg!);
          }
        }
      });
    } catch (e) {
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
      _apiProviders.OtpVerfiyApi(model: otpVerfiyModel).then((value) {
        if (value != null) {
          var responseBody = json.decode(value);
          CommonResponse commonResponse = CommonResponse.fromJson(responseBody);
          if (commonResponse.st == ("100")) {
            apiStatus = commonResponse.st;
            CustomSnackBar(commonResponse.msg!);
          } else if (commonResponse.st == ("101")) {
            CustomSnackBar(commonResponse.msg!);
          } else {
            CustomSnackBar(commonResponse.msg!);
          }
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgotPasswordApi() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString(AppConst.email, emailController.text);
      _apiProviders.ForgotPasswordApi(email: emailController.text)
          .then((value) {
        if (value != null) {
          var responseBody = json.decode(value);
          CommonResponse commonResponse = CommonResponse.fromJson(responseBody);
          if (commonResponse.st == ("100")) {
            isForgot = false;
            isOtp = true;
            CustomSnackBar(commonResponse.msg!);
          } else if (commonResponse.st == ("101")) {
            CustomSnackBar(commonResponse.msg!);
          } else {
            CustomSnackBar(commonResponse.msg!);
          }
        }
      });
    } catch (e) {
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
      _apiProviders.ChangePasswordApi(model: changePasswordModel).then((value) {
        if (value != null) {
          var responseBody = json.decode(value);
          CommonResponse commonResponse = CommonResponse.fromJson(responseBody);
          if (commonResponse.st == ("100")) {
            isLogin = true;
            isPassword = false;
            CustomSnackBar(commonResponse.msg!);
          } else if (commonResponse.st == ("101")) {
            CustomSnackBar(commonResponse.msg!);
          } else {
            CustomSnackBar(commonResponse.msg!);
          }
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
