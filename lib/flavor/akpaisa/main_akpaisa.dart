
import 'package:flutter/material.dart';

import '../../main_common.dart';
import '../FlavorConfig.dart';

void main() {
  // Inject our own configurations
  // Coffee Beans

  mainCommon(
    FlavorConfig()
    ..appname= 'FundspI'
    ..packagename= 'com.akpaisa'
    ..colorcode= Color(0xfffc6c1f)
    ..sub_br_code= 'SB-1'
    ..privacy_policy= 'https://akpaisa.com/privacy_policy/'
    ..termsofuse= 'https://akpaisa.com/terms_of_use/'
    ..web_url= 'https://akpaisa.com/'
    ..theme=ThemeData.light().copyWith(
        primaryColor: Color(0xFFfc6c1f),
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
          backgroundColor: Color(0xFF654321),
        ))
    ..imagelocation='assets/img/logoakpaisa.png'
      ..versioncode='1'
      ..versionname='0.0.1'
  );
}
