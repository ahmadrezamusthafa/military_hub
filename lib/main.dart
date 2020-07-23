import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:military_hub/config/api_config.dart';
import 'package:military_hub/features/social/presentation/pages/home_tabpage.dart';
import 'package:military_hub/route_generator.dart';
import 'config/app_config.dart' as config;
import 'features/social/domain/repositories/user_repository.dart';
import 'injection_container.dart' as di;

// Generate JSON serializer g.dart
//    $ flutter pub run build_runner build --delete-conflicting-outputs

void main() async {
  GoogleMap.init(API.GoogleAPIKey);
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  initDummyData();
  runApp(MyApp());
}

void initDummyData() {
  currentUser.value.userId = "ACM_3";
  currentUser.value.name = "Ahmad Reza Musthafa";
  currentUser.value.email = "rezaaltraz@yahoo.com";
  currentUser.value.password = "123";
  currentUser.value.phoneNumber = "+6289676583087";
  currentUser.value.profileStatus = "Hey there";
  currentUser.value.profilePicture =
      "http://idekuliner.com/images/profpic/ACM_3.jpg";
  currentUser.value.address = "Mojokerto";
}

class MyApp extends StatelessWidget {
  static final GlobalKey<HomeTabPageState> homeTabPageKey =
      new GlobalKey<HomeTabPageState>();

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) {
          if (brightness == Brightness.light) {
            return ThemeData(
              fontFamily: 'Poppins',
              primaryColor: Colors.white,
              brightness: brightness,
              accentColor: config.Colors().mainColor(1),
              focusColor: config.Colors().accentColor(1),
              hintColor: config.Colors().secondColor(1),
              textTheme: TextTheme(
                headline: TextStyle(
                    fontSize: 20.0, color: config.Colors().secondColor(1)),
                display1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: config.Colors().secondColor(1)),
                display2: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: config.Colors().secondColor(1)),
                display3: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: config.Colors().mainColor(1)),
                display4: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w300,
                    color: config.Colors().secondColor(1)),
                subhead: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: config.Colors().secondColor(1)),
                title: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: config.Colors().mainColor(1)),
                body1: TextStyle(
                    fontSize: 12.0, color: config.Colors().secondColor(1)),
                body2: TextStyle(
                    fontSize: 14.0, color: config.Colors().secondColor(1)),
                caption: TextStyle(
                    fontSize: 12.0, color: config.Colors().accentColor(1)),
              ),
            );
          } else {
            return ThemeData(
              fontFamily: 'Poppins',
              primaryColor: Color(0xFF252525),
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Color(0xFF2C2C2C),
              accentColor: config.Colors().mainDarkColor(1),
              hintColor: config.Colors().secondDarkColor(1),
              focusColor: config.Colors().accentDarkColor(1),
              textTheme: TextTheme(
                headline: TextStyle(
                    fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
                display1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: config.Colors().secondDarkColor(1)),
                display2: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: config.Colors().secondDarkColor(1)),
                display3: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: config.Colors().mainDarkColor(1)),
                display4: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w300,
                    color: config.Colors().secondDarkColor(1)),
                subhead: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: config.Colors().secondDarkColor(1)),
                title: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: config.Colors().mainDarkColor(1)),
                body1: TextStyle(
                    fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
                body2: TextStyle(
                    fontSize: 14.0, color: config.Colors().secondDarkColor(1)),
                caption: TextStyle(
                    fontSize: 12.0,
                    color: config.Colors().secondDarkColor(0.6)),
              ),
            );
          }
        },
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            title: "Military Hub",
            initialRoute: '/Splash',
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            theme: theme,
          );
        });
  }
}
