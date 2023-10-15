import 'dart:convert';

import 'package:animerush/widgets/customButtons.dart';
import 'package:animerush/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/versionPodo.dart';
import '../utils/apiProviders.dart';
import '../utils/appConst.dart';

class VersionController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();

  PackageInfo packageInfo =
      PackageInfo(appName: '', packageName: '', version: '', buildNumber: '');

  Future<void> appVersionApiCall(BuildContext context, String pg) async {
    final prefs = await SharedPreferences.getInstance();
    WidgetsFlutterBinding.ensureInitialized();
    final appTheme = Theme.of(context);
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;

    try {
      _apiProviders.appVersionApi().then((value) {
        if (value.isNotEmpty) {
          var responseBody = json.decode(value);
          if (responseBody['st'] == 100) {
            VersionPodo versionPodo = VersionPodo.fromJson(responseBody);
            hideProgress();
            print(versionPodo.data!.version);
            print(packageInfo.version);
            if (versionPodo.data!.version!.isNotEmpty &&
                versionPodo.data!.version != packageInfo.version &&
                pg == 'bottom') {
              Get.defaultDialog(
                title: "New Update Available",
                middleText:
                    // "A newer version of app available please update it now.",
                "Please uninstall current app and download and install the latest app for better experience.",
                titleStyle: appTheme.textTheme.bodyLarge,
                middleTextStyle: appTheme.textTheme.labelSmall,
                confirm: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 150, maxHeight: 40),
                  child: elevatedButton(
                    text: 'Update Now',
                    onPressed: () {
                      // Platform.isIOS
                      //     ? launchURL(AppConst.APP_STORE_URL)
                      //     : launchURL(AppConst.PLAY_STORE_URL);
                      launchURL(versionPodo.data!.apkUrl!);
                      Get.back();
                    },
                  ),
                ),
                cancel: textButton(text: 'Cancel', onPressed: () => Get.back()),
                radius: 6,
                titlePadding: const EdgeInsets.only(top: 15),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: appTheme.colorScheme.background,
              );
            } else {
              white_logo = 'https://animerush.in${versionPodo.data!.logo!}';
              fevicon = 'https://animerush.in${versionPodo.data!.fevicon!}';
              fevicon = versionPodo.data!.fevicon!;
              web_code = versionPodo.data!.webCode!;
              description = versionPodo.data!.description!;
            }
          }
        }
      });
    } catch (e) {
      hideProgress();
      rethrow;
    }
  }
  launchURL(String strUrl) async {
    final url = strUrl;
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        await launch(url);
      }
    } catch (e) {
      throw 'Could not launch $url';
    }
  }
}
