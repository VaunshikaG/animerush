import 'package:animerush/screens/account.dart';
import 'package:animerush/screens/auth.dart';
import 'package:animerush/screens/details.dart';
import 'package:animerush/screens/episode.dart';
import 'package:animerush/screens/search.dart';
import 'package:animerush/screens/watchList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../screens/home.dart';
import '../screens/splash.dart';

class Routes {
  static const String mainScreen = '/';
  static const String homeScreen = '/home';
  static const String searchScreen = '/search';
  static const String watchListScreen = '/watch-list';
  static const String profileScreen = '/profile';
  static const String authScreen = '/auth';
  static const String detailsScreen = '/details';
  static const String episodeScreen = '/episode';
  static const String splashScreen = '/splash';
}

class AppRoutes {
  AppRoutes._();

  static final pages = [
    GetPage(
      name: Routes.mainScreen,
      page: () => MyApp(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => const Home(),
    ),
    GetPage(
      name: Routes.searchScreen,
      page: () => const Search(),
    ),
    GetPage(
      name: Routes.watchListScreen,
      page: () => const WatchList(pg: ''),
    ),
    GetPage(
      name: Routes.profileScreen,
      page: () => const Account(),
    ),
    GetPage(
      name: Routes.detailsScreen,
      page: () => const Details(id: ''),
    ),
    GetPage(
      name: Routes.episodeScreen,
      page: () => const Episode(epDetails: [],pg: '',epId: '',aId: ''),
    ),
    GetPage(
      name: Routes.splashScreen,
      page: () => const Splash(),
    ),
    GetPage(
      name: Routes.authScreen,
      page: () => const Auth(),
    ),
  ];
}