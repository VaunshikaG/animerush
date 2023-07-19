import 'dart:developer';

import 'package:animerush/screens/Account.dart';
import 'package:animerush/screens/BottomBar.dart';
import 'package:animerush/screens/Splash.dart';
import 'package:animerush/utils/AppTheme.dart';
import 'package:animerush/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadClass {
  static void callback(String id, DownloadTaskStatus status, int progress) {
    log("Download Status: $status");
    log("Download Progress: $progress");
    log("${status.value}");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(
  //   debug: true,
  //   ignoreSsl: true,
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Anime Rush',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      // home: const Splash(),
      home: const BottomBar(currentIndex: 2),
    );
  }
}
