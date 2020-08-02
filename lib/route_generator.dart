import 'package:flutter/material.dart';
import 'package:military_hub/features/social/presentation/pages/home_tabpage.dart';
import 'package:military_hub/features/social/presentation/pages/login_page.dart';
import 'package:military_hub/features/social/presentation/pages/map_viewer_page.dart';
import 'package:military_hub/features/social/presentation/pages/post_page.dart';
import 'package:military_hub/features/social/presentation/pages/splash_page.dart';
import 'package:military_hub/features/social/presentation/pages/stream_viewer_page.dart';
import 'package:military_hub/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashPage());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/Home':
        return MaterialPageRoute(
            builder: (_) => HomeTabPage(
                  key: MyApp.homeTabPageKey,
                ));
      case '/Post':
        return MaterialPageRoute(
            builder: (_) => PostPage(
                  filePath: args,
                ));
      case '/StreamView':
        return MaterialPageRoute(
            builder: (_) => StreamViewerPage(
                  broadcaster: args,
                ));
      case '/MapView':
        return MaterialPageRoute(
            builder: (_) => MapViewerPage(
                  location: args,
                ));
    }
  }
}
