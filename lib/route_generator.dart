import 'package:flutter/material.dart';
import 'package:military_hub/features/social/presentation/pages/home_tabpage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Home':
        return MaterialPageRoute(builder: (_) => HomeTabPage());
      default:
        return MaterialPageRoute(builder: (_) => HomeTabPage());
    }
  }
}
