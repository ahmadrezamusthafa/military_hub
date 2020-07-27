import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:military_hub/features/social/domain/entities/user.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:military_hub/features/social/domain/usecase/user_usecase.dart';
import 'package:military_hub/features/social/presentation/pages/home_page.dart';
import 'package:military_hub/features/social/presentation/pages/live_page.dart';
import 'package:military_hub/features/social/presentation/pages/profile_page.dart';
import 'package:military_hub/features/social/presentation/pages/stream_page.dart';
import 'package:background_location/background_location.dart';
import 'package:military_hub/injection_container.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeTabPageState();
}

class HomeTabPageState extends State<HomeTabPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    print("HomeTabPage initState");
    super.initState();
    tabController = new TabController(vsync: this, length: 4);
    BackgroundLocation.startLocationService();
    BackgroundLocation.getLocationUpdates((location) async {
      if (currentUser.value.latitude != location.latitude ||
          currentUser.value.longitude != location.longitude) {
        currentUser.value.latitude = location.latitude;
        currentUser.value.longitude = location.longitude;

        await sl<UserUseCase>()
            .updateUserLocationLocalDb(location.latitude, location.longitude);

        var status = await sl<UserUseCase>().updateUserLocation(
            currentUser.value.email,
            currentUser.value.password,
            currentUser.value.latitude,
            currentUser.value.longitude);
        if (status != null) {
          print("update location status issuccess=${status.isSuccess}");
        }
        print(
            "receive location lat:${location.latitude} lon:${location.longitude}");
      }
    });
  }

  @override
  void dispose() {
    print("HomeTabPage dispose");
    tabController.dispose();
    super.dispose();
    BackgroundLocation.stopLocationService();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        body: TabBarView(
          controller: tabController,
          children: [
            HomePage(),
            StreamPage(),
            LivePage(),
            ProfilePage(),
          ],
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
            controller: tabController,
            tabs: <Widget>[
              Tab(
                  icon: Icon(
                FontAwesomeIcons.home,
                size: 16,
              )),
              Tab(icon: Icon(FontAwesomeIcons.stream, size: 16)),
              Tab(icon: Icon(FontAwesomeIcons.video, size: 16)),
              Tab(icon: Icon(FontAwesomeIcons.user, size: 16)),
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
