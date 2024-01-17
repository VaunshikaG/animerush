import 'dart:developer';

import 'package:notix_inapp_flutter/notix.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/appConst.dart';

class AdsController {

  InterstitialData? interstitialData;
  Future<void> ads() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var loader = await Notix.Interstitial.createLoader(AppConst.ZONE_ID_1);
      loader.startLoading();
      interstitialData = await loader.next();
      DateTime? lastClicked = prefs.containsKey(AppConst.adTimeStamp1)
          ? DateTime.parse(prefs.getString(AppConst.adTimeStamp1)!)
          : null;

      if (lastClicked == null ||
          DateTime.now().difference(lastClicked) >=
              const Duration(minutes: 2)) {
        prefs.setString(AppConst.adTimeStamp1, DateTime.now().toString());
        Notix.Interstitial.show(interstitialData!);
      } else {
        log('Interstitial loaded within the last 2 mins. Not executing code1.');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

}