// ignore_for_file: unused_import, unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:animerush/utils/AppConst.dart';
import 'package:animerush/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/CommonResponse.dart';
import '../model/LoginPodo.dart';
import '../model/ProflePodo.dart';
import '../model/RqModels.dart';
import '../screens/BottomBar.dart';
import '../utils/ApiProviders.dart';
import '../widgets/CustomSnackbar.dart';

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
  ProfileData? profileData;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
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
          hideProgress();
          if (responseBody['st'] == 100) {
            prefs.setBool(AppConst.loginStatus, true);
            showPg.value = false;
            profileApi();
            LoginPodo loginPodo = LoginPodo.fromJson(responseBody);
            prefs.setString(AppConst.token, loginPodo.data!.jwtToken!);
            isLogin.value = false;
            isUserLoggedIn.value = true;
            Get.to(() => const BottomBar(currentIndex: 3));
            CustomSnackBar("Login Successful");
            // userNameController.clear();
            // emailController.clear();
            passwordController.clear();
            otpController.clear();
          } else if (responseBody['st'] == 101) {
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
            isSignin.value = false;
            isLogin.value = true;
            // Get.offAll(const BottomBar(currentIndex: 3));
            userNameController.clear();
            emailController.clear();
            passwordController.clear();
            otpController.clear();
          } else if (responseBody['st'] == 101) {
            isSignin.value = true;
            isLogin.value = false;
            message = responseBody['msg'];
          } else {
            CustomSnackBar(responseBody['msg']);
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
      _apiProviders.otpVerfiyApi(model: otpVerfiyModel).then((value) {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          if (responseBody['st'] == 100) {
            CommonResponse commonResponse =
                CommonResponse.fromJson(responseBody);
            isOtp.value = false;
            isPassword.value = true;
            userNameController.clear();
            emailController.clear();
            passwordController.clear();
            otpController.clear();
            CustomSnackBar(responseBody['msg']);
          } else if (responseBody['st'] == 101) {
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
            isForgot.value = false;
            isOtp.value = true;
            userNameController.clear();
            emailController.clear();
            passwordController.clear();
            otpController.clear();
            CustomSnackBar(responseBody['msg']);
          } else if (responseBody['st'] == 101) {
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
            isLogin.value = true;
            isPassword.value = false;
            userNameController.clear();
            emailController.clear();
            passwordController.clear();
            otpController.clear();
            CustomSnackBar(responseBody['msg']);
          } else if (responseBody['st'] == 101) {
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
      _apiProviders.ProfileApi().then((value) async {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          hideProgress();
          if (responseBody['st'] == 100) {
            ProflePodo proflePodo = ProflePodo.fromJson(responseBody);
            profileData = proflePodo.data;
            message = profileData!.created.toString();
            showPg.value = true;
            hideProgress();
          } else if (responseBody['detail'] == "Signature has expired.") {
            prefs.setBool(AppConst.loginStatus, false);
            await prefs.clear();
            // Get.deleteAll();
            showPg.value = true;
            isLogin.value = true;
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
