import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:military_hub/features/social/presentation/pages/home_page.dart';
import 'package:military_hub/features/social/presentation/pages/menu_page.dart';
import 'package:military_hub/features/social/presentation/pages/profile_page.dart';
import 'package:military_hub/features/social/presentation/pages/splash_page.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);

  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
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
    ProfilePage(),
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
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(0),
//                    gradient: LinearGradient(colors: [Colors.yellow, Colors.redAccent]),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                  offset: Offset(0, 3),
                  blurRadius: 10)
            ],
          ),
          margin: EdgeInsets.only(bottom: 0),
          child: new TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.person)),
            ],
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 47.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            labelPadding: EdgeInsets.only(right: 0.0, left: 0.0),
          ),
        ),
      ),
    );
  }
}
