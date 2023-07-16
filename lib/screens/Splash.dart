import 'package:animate_do/animate_do.dart';
import 'package:animerush/screens/BottomBar.dart';
import 'package:animerush/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/CustomScreenRoute.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Duration duration = const Duration(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 500),
                child: Container(
                  margin: const EdgeInsets.only(top: 150, bottom: 45),
                  width: size.width / 1.5,
                  height: size.height / 9.9,
                  child: Image.asset('assets/img/white_logo.png'),
                ),
              ),
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 1000),
                child: Text(
                  "Welcome !",
                  style: appTheme.textTheme.displayMedium,
                ),
              ),
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 1500),
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 100),
                  child: Text(
                    "AnimeRush.in - The best platform to watch anime online for Free",
                    textAlign: TextAlign.center,
                    style: appTheme.textTheme.displaySmall,
                  ),
                ),
              ),
              FadeInUp(
                duration: duration,
                delay: const Duration(milliseconds: 2000),
                child: ActionChip(
                  avatar: Icon(
                    CupertinoIcons.arrowtriangle_right_fill,
                    color: appTheme.iconTheme.color,
                  ),
                  label: Text(
                    'Continue',
                    style: appTheme.textTheme.bodyMedium,
                  ),
                  onPressed: () {
                    Get.off(() => const BottomBar(currentIndex: 0));
                  },
                  elevation: 3,
                  backgroundColor: appTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  side: BorderSide.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
