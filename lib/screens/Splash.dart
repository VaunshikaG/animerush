import 'package:animate_do/animate_do.dart';
import 'package:animerush/screens/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const BottomBar(currentIndex: 0));
    });
    super.initState();
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
