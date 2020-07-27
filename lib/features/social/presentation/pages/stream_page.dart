import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:military_hub/features/social/domain/usecase/webrtc_usecase.dart';
import 'package:military_hub/features/social/presentation/bloc/fetch/webrtc/bloc.dart';
import 'package:military_hub/features/social/presentation/widgets/live_broadcaster_list_widget.dart';
import 'package:military_hub/features/social/presentation/widgets/user_avatar_widget.dart';
import 'package:military_hub/injection_container.dart';

class StreamPage extends StatefulWidget {
  _StreamPageState createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  EasyRefreshController _controller;
  int _count = 20;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(backgroundColor: Colors.white, elevation: 0),
      ),
      body: buildBody(context),
    );
  }

  MultiBlocProvider buildBody(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetLiveBroadcasterListBloc>(
          create: (_) => sl<GetLiveBroadcasterListBloc>(),
        ),
      ],
      child: EasyRefresh.custom(
        enableControlFinishRefresh: false,
        enableControlFinishLoad: false,
        controller: _controller,
        header: ClassicalHeader(),
        footer: ClassicalFooter(),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            print('onRefresh');
            setState(() {
              _count = 20;
            });
            _controller.resetLoadState();
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 2), () {
            print('onLoad');
            setState(() {
              _count += 10;
            });
            _controller.finishLoad(noMore: _count >= 40);
          });
        },
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: false,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 20,
                  margin: EdgeInsets.all(0),
                  child: Image(
                    image: AssetImage('assets/img/logo_military_hub_s.png'),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                Padding(
                  padding: EdgeInsets.all(3),
                ),
                Text("STREAM",
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .merge(TextStyle(fontFamily: "Staatliches"))
                        .merge(TextStyle(letterSpacing: 1.3))
                        .merge(TextStyle(fontSize: 16))),
              ],
            ),
            backgroundColor: Colors.white,
            floating: true,
            snap: true,
            actions: _getAppBarActions(),
          ),
          SliverList(
              delegate: new SliverChildListDelegate([
            Column(
              children: <Widget>[LiveBroadcasterListWidget()],
            )
          ]))
        ],
      ),
    );
  }

  List<Widget> _getAppBarActions() {
    return [
      Container(
        child: IconButton(
          icon: Icon(Icons.filter_list),
          color: Theme.of(context).accentColor,
          onPressed: () {},
        ),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      Padding(
        padding: EdgeInsets.only(right: 5),
      ),
      Container(
        child: IconButton(
          icon: Icon(Icons.map),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.of(context).pushNamed('/MapView',
                arguments: LatLng(
                    currentUser.value.latitude, currentUser.value.longitude));
          },
        ),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      Padding(
        padding: EdgeInsets.only(right: 5),
      ),
    ];
  }

  Widget _getSeparator(double height) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).canvasColor),
      constraints: BoxConstraints(maxHeight: height),
    );
  }

  void _testWebApi() async {
    var broadcasterList = await sl<WebRTCUseCase>().getLiveBroadcasterList();
    print("receive broadcaster: ${broadcasterList.length}");
    for (var room in broadcasterList) {
      print("room ${room.roomId} ${room.name}");
    }
  }
}
