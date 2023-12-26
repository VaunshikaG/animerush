import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:animerush/widgets/customButtons.dart';
import 'package:animerush/widgets/loader.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/versionPodo.dart';
import '../utils/apiProviders.dart';
import '../utils/appConst.dart';
import '../widgets/launch_url.dart';

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
            if (versionPodo.data!.version!.isNotEmpty &&
                versionPodo.data!.version != packageInfo.version &&
                pg == 'bottom') {
              Get.defaultDialog(
                barrierDismissible: false,
                onWillPop: () async {
                  return false;
                },
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
                      launchURL(strUrl: versionPodo.data!.apkUrl!);
                      // Get.back();
                    },
                  ),
                ),
                radius: 6,
                titlePadding: const EdgeInsets.only(top: 15),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: appTheme.colorScheme.background,
              );
            } else {
              white_logo = '${AppConst.app_weburl}${versionPodo.data!.logo!}';
              fevicon = '${AppConst.app_weburl}${versionPodo.data!.fevicon!}';
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

  Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        print(deviceId);
        prefs.setString(AppConst.deviceId, deviceId);
      }
    } catch (e) {
      print('Error getting device ID: $e');
    }

    return deviceId ?? "null";
  }
}
