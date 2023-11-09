import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:animerush/screens/bottomBar.dart';
import 'package:animerush/screens/auth.dart';
import 'package:animerush/utils/appConst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      navigatePg();
    });
    super.initState();
  }

  Future<void> navigatePg() async {
    versionController.appVersionApiCall(context, 'splash');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(AppConst.loginStatus) == null) {
      prefs.setBool(AppConst.loginStatus, false);
    }
    if (prefs.getBool(AppConst.loginStatus) == false) {
      Get.to(() => const Auth());
    } else if (prefs.getBool(AppConst.loginStatus) == true) {
      Get.to(() => const BottomBar(currentIndex: 0, checkVersion: true));
    }
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      setState(() {
        if (updateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          if (updateInfo.immediateUpdateAllowed) {
            InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
              if (appUpdateResult == AppUpdateResult.success) {}
            });
          } else if (updateInfo.flexibleUpdateAllowed) {
            InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
              if (appUpdateResult == AppUpdateResult.success) {
                InAppUpdate.completeFlexibleUpdate();
              }
            });
          }
        }
      });
    }).catchError((e) {
      log("update error: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: appTheme.scaffoldBackgroundColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 150, bottom: 50),
          width: size.width / 1.5,
          height: size.height / 9.9,
          child: FadeInUp(
            duration: const Duration(seconds: 2),
            delay: const Duration(seconds: 0),
            child: Image.asset('assets/img/white_logo.png'),
            // child: Image.network(white_logo),
          ),
        ),
      ),
    );
  }
}
