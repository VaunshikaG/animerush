import 'dart:developer';

import 'package:animerush/screens/Splash.dart';
import 'package:animerush/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
  await FlutterDownloader.initialize(debug: true);
  FlutterDownloader.registerCallback(DownloadClass.callback);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Rush',
      debugShowCheckedModeBanner: false,
      color: CustomTheme.black,
      theme: ThemeData(
        useMaterial3: true,
        // colorScheme: const ColorScheme.dark(),
        primarySwatch: Colors.orange,
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // home: const MyWidget(),
      // home: const BottomBar(currentIndex: 0),
      home: const Splash(),
    );
  }
}
