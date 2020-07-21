import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:military_hub/features/social/presentation/pages/home_page.dart';
import 'package:military_hub/features/social/presentation/pages/live_page.dart';
import 'package:military_hub/features/social/presentation/pages/profile_page.dart';
import 'package:military_hub/features/social/presentation/pages/stream_page.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);

  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  int counter = 0;

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
    StreamPage(),
    LivePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
              Tab(icon: Icon(FontAwesomeIcons.home, size: 16,)),
              Tab(icon: Icon(FontAwesomeIcons.stream,size: 16)),
              Tab(icon: Icon(FontAwesomeIcons.video,size: 16)),
              Tab(icon: Icon(FontAwesomeIcons.user,size: 16)),
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
