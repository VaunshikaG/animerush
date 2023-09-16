import 'dart:convert';
import 'dart:io';

import 'package:animerush/widgets/customButtons.dart';
import 'package:animerush/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/versionPodo.dart';
import '../utils/apiProviders.dart';
import '../utils/appConst.dart';

class VersionController extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();

  PackageInfo packageInfo =
      PackageInfo(appName: '', packageName: '', version: '', buildNumber: '');

  Future<void> appVersionApiCall(BuildContext context) async {
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
                versionPodo.data!.version != packageInfo.version) {
              Get.defaultDialog(
                title: "New Update Available",
                middleText:
                    "A newer version of app available please update it now.",
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
            }
          }
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  launchURL(String strUrl) async {
    final Uri _url = Uri.parse(strUrl);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $strUrl';
    }
  }
}
