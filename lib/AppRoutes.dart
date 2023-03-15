import 'package:flutter/cupertino.dart';

import 'main.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => Splash(),
  };

}