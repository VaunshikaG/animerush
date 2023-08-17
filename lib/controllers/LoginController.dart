import 'dart:convert';
import 'dart:developer';

import 'package:animerush/utils/AppConst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/CommonResponse.dart';
import '../model/LoginPodo.dart';
import '../model/RqModels.dart';
import '../screens/BottomBar.dart';
import '../utils/ApiProviders.dart';
import '../widgets/CustomSnackbar.dart';

class LoginController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();
  RxBool isLoggedIn = false.obs,
      isLogin = true.obs,
      isSignin = false.obs,
      isForgot = false.obs,
      isOtp = false.obs,
      isPassword = false.obs,
      isChangePass = false.obs;
  var message, email, userName, dateJoined;

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
          if (responseBody['st'] == 100) {
            LoginPodo loginPodo = LoginPodo.fromJson(responseBody);
            email = loginPodo.data!.email;
            userName = loginPodo.data!.realUsername;
            prefs.setString(AppConst.token, loginPodo.data!.jwtToken!);
            prefs.setString(AppConst.userName, loginPodo.data!.realUsername!);
            prefs.setBool(AppConst.loginStatus, true);
            prefs.setString(AppConst.email, loginPodo.data!.email.toString());
            prefs.setString(AppConst.dateJoined, loginPodo.data!.created.toString());
            isLogin.value = false;
            isLoggedIn.value = true;
            Get.to(() => const BottomBar(currentIndex: 3));
            CustomSnackBar("Login Successful");
            // userNameController.clear();
            // emailController.clear();
            // passwordController.clear();
            // otpController.clear();
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
          CommonResponse commonResponse = CommonResponse.fromJson(responseBody);
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
          CommonResponse commonResponse = CommonResponse.fromJson(responseBody);
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
      _apiProviders.forgotPasswordApi(email: emailController.text)
          .then((value) {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          if (responseBody['st'] == 100) {
          CommonResponse commonResponse = CommonResponse.fromJson(responseBody);
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
            CommonResponse commonResponse = CommonResponse.fromJson(responseBody);
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
    final prefs = await SharedPreferences.getInstance();
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
}
