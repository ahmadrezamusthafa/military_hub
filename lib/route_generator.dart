import 'package:flutter/material.dart';
import 'package:military_hub/features/social/presentation/pages/home_tabpage.dart';
import 'package:military_hub/features/social/presentation/pages/splash_page.dart';
import 'package:military_hub/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/Home':
        return MaterialPageRoute(
            builder: (_) => HomeTabPage(
                  key: MyApp.homeTabPageKey,
                ));
    }
  }
}
