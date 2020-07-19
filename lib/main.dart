import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:military_hub/features/social/presentation/pages/home_page.dart';
import 'package:military_hub/features/social/presentation/pages/menu_page.dart';
import 'package:military_hub/features/social/presentation/pages/splash_page.dart';

import 'features/social/domain/repositories/user_repository.dart';
import 'themes/Theme.dart';

void main() {
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Military Hub',
      home: MilitaryHubWidget(),
      theme: MyTheme(),
    );
  }
}

class MilitaryHubWidget extends StatefulWidget {
  MilitaryHubWidget({Key key}) : super(key: key);

  _MilitaryHubWidgetState createState() => _MilitaryHubWidgetState();
}

class _MilitaryHubWidgetState extends State<MilitaryHubWidget> {
  int counter = 0;
  bool isLoading = true;

  void changeCounter() {
    setState(() {
      counter++;
    });
    print("increment counter $counter");
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> pages = [
    HomePage(),
    MenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      Timer(Duration(seconds: 5), () {
        print("Hub has been loaded...");
        setState(() => this.isLoading = false);
      });
      return SplashPage();
    }
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: TabBarView(
          children: pages,
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: new TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.menu)),
            ],
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 47.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 3.0,
              ),
            ),
            labelPadding: EdgeInsets.only(right: 0.0, left: 0.0),
          ),
        ),
      ),
    );
  }
}
