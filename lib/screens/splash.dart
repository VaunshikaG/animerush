import 'package:animate_do/animate_do.dart';
import 'package:animerush/screens/bottomBar.dart';
import 'package:animerush/screens/auth.dart';
import 'package:animerush/utils/appConst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoggedIn = false;

  @override
  void initState() {
    isLoggedIn = false;
    Future.delayed(const Duration(seconds: 2), () {
      navigatePg();
    });
    super.initState();
  }

  Future<void> navigatePg() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(AppConst.loginStatus)!;
    if (!isLoggedIn) {
      Get.off(() => const Auth());
    } else if (isLoggedIn) {
      Get.offAll(() => const BottomBar(currentIndex: 0, checkVersion: true));
    }
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
          ),
        ),
      ),
    );
  }
}
