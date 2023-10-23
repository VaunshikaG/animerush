import 'dart:developer';
import 'dart:io';

import 'package:animerush/screens/splash.dart';
import 'package:animerush/utils/appConst.dart';
import 'package:animerush/utils/appTheme.dart';
import 'package:animerush/widgets/customButtons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:get/get.dart';
// import 'package:flutter_ironsource_x/flutter_ironsource_x.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/versionController.dart';

// class DownloadClass {
//   static void callback(String id, DownloadTaskStatus status, int progress) {
//     debugPrint("Download Status: $status,  Progress: $progress");
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
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

class _MyAppState extends State<MyApp> with IronSourceImpressionDataListener, IronSourceInitializationListener {
  bool? _jailbroken;
  bool? _developerMode;

  @override
  void initState() {
    initIronSource();
    initPlatformState();
    super.initState();
  }

  Future<void> initIronSource() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(AppConst.adTimeStamp1);
    prefs.remove(AppConst.adTimeStamp2);
    final appKey = Platform.isAndroid
    // ? "85460dcd"
        ? AppConst.APP_KEY_IRON_SOURCE
        : throw Exception("Unsupported Platform");

    try {
      IronSource.setFlutterVersion(versionController.packageInfo.version); // fetch automatically
      IronSource.setImpressionDataListener(this);
      await enableDebug();
      await IronSource.shouldTrackNetworkState(true);

      // GDPR, CCPA, COPPA etc
      await setRegulationParams();

      // Segment info
      // await setSegment();

      // For Offerwall
      // Must be called before init
      // await IronSource.setClientSideCallbacks(true);

      // GAID, IDFA, IDFV
      String id = await IronSource.getAdvertiserId();
      print('AdvertiserID: $id');

      // Do not use AdvertiserID for this.
      //  offerwall ad unit or using server-to-server callbacks to reward your users
      // await IronSource.setUserId(AppConst.APP_USER_ID);

      // Finally, initialize
      await IronSource.init(
          appKey: appKey,
          adUnits: [
            IronSourceAdUnit.RewardedVideo,
            IronSourceAdUnit.Interstitial,
            IronSourceAdUnit.Banner,
            IronSourceAdUnit.Offerwall,
          ],
          initListener: this);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> enableDebug() async {
    await IronSource.setAdaptersDebug(true);
    // this function doesn't have to be awaited
    IronSource.validateIntegration();
  }

  // Sample Segment Params - adsz as per user requirements
  Future<void> setSegment() {
    final segment = IronSourceSegment();
    segment.age = 20;
    segment.gender = IronSourceUserGender.Female;
    segment.level = 3;
    segment.isPaying = false;
    segment.userCreationDateInMillis = DateTime.now().millisecondsSinceEpoch;
    segment.iapTotal = 1000;
    segment.setCustom(key: 'DemoCustomKey', value: 'DemoCustomVal');
    return IronSource.setSegment(segment);
  }

  Future<void> setRegulationParams() async {
    // GDPR
    await IronSource.setConsent(true);
    await IronSource.setMetaData({
      // CCPA
      'do_not_sell': ['false'],
      // COPPA
      'is_child_directed': ['false'],
      // 'is_test_suite': ['enable']
      // 'is_test_suite': ['disable']
    });

    return;
  }

  @override
  void onImpressionSuccess(IronSourceImpressionData? impressionData) {
    log('Impression Data: $impressionData');
  }

  // Initialization listener
  @override
  void onInitializationComplete() {
    log('onInitializationComplete');
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
