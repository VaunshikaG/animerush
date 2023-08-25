import 'package:animerush/screens/BottomBar.dart';
import 'package:animerush/screens/Splash.dart';
import 'package:animerush/utils/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


class DownloadClass {
  static void callback(String id, DownloadTaskStatus status, int progress) {
    debugPrint("Download Status: $status,  Progress: $progress");
    debugPrint("${status.value}");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );
  runApp(MyApp());
}

/*

var flavorConfigProvider;
Future<void> mainCommon(FlavorConfig config) async {
  flavorConfigProvider = StateProvider((ref) => config);

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]);
  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );
  runApp(ProviderScope(child: MyApp()));
}
*/

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
      // home: const BottomBar(currentIndex: 2),
    );
  }
}
