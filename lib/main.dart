import 'dart:developer';

import 'package:animerush/screens/splash.dart';
import 'package:animerush/utils/appConst.dart';
import 'package:animerush/utils/appTheme.dart';
import 'package:animerush/widgets/customButtons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/versionController.dart';

// class DownloadClass {
//   static void callback(String id, DownloadTaskStatus status, int progress) {
//     debugPrint("Download Status: $status,  Progress: $progress");
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  RequestConfiguration requestConfiguration = RequestConfiguration(testDeviceIds: ["58B757A64BD02A967D6059C6172704E3"]);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // await FlutterDownloader.initialize(
  //   debug: true,
  //   ignoreSsl: true,
  // );
  runApp(const MyApp());
}

VersionController versionController = Get.put(VersionController());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? _jailbroken;
  bool? _developerMode;

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final appTheme = Theme.of(context);

    bool jailBroken;
    bool developerMode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      jailBroken = await FlutterJailbreakDetection.jailbroken;
      developerMode = await FlutterJailbreakDetection.developerMode;

      if (jailBroken) {
        Get.defaultDialog(
          title: "Device Security Warning",
          middleText:
              "This app cannot be used on a jailbroken or rooted device.",
          titleStyle: appTheme.textTheme.bodyLarge,
          middleTextStyle: appTheme.textTheme.labelSmall,
          cancel: textButton(text: 'Ok', onPressed: () {}),
          radius: 6,
          titlePadding: const EdgeInsets.only(top: 15),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: appTheme.colorScheme.background,
          barrierDismissible: false,
        );
      }
    } on PlatformException {
      jailBroken = true;
      developerMode = true;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _jailbroken = jailBroken;
      _developerMode = developerMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: context.read(flavorConfigProvider).state.appname,
      title: 'AnimeRush',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const Splash(),
      // getPages: AppRoutes.pages,
    );
  }
}
