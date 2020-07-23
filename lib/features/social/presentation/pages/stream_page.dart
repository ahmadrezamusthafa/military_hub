import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:military_hub/features/social/domain/usecase/webrtc_usecase.dart';
import 'package:military_hub/features/social/presentation/widgets/user_avatar_widget.dart';
import 'package:military_hub/injection_container.dart';

class StreamPage extends StatefulWidget {
  _StreamPageState createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  @override
  void initState() {
    super.initState();
    _testWebApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(backgroundColor: Colors.white, elevation: 0),
      ),
      body: CustomScrollView(
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
              delegate:
                  new SliverChildListDelegate([Column(children: _getPosts())]))
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
          onPressed: () {},
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

  Widget _postHeader() {
    return Container(
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: UserAvatarWidget(),
                padding: EdgeInsets.only(right: 10),
              ),
              Column(
                children: <Widget>[
                  Text('Ahmad Reza Musthafa',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black)),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )
              //Container(),
            ],
          ),
          Row(
            children: <Widget>[
              FlatButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                  icon: Icon(Icons.play_circle_outline,
                      size: 34, color: Colors.green),
                  label: Text('Play', style: TextStyle(fontSize: 12)),
                  textColor: Colors.grey,
                  onPressed: () {}),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    );
  }

  Widget _getPost() {
    return Container(
      child: Column(
        children: <Widget>[
          _getSeparator(10),
          _postHeader(),
        ],
      ),
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  List<Widget> _getPosts() {
    List<Widget> _posts = [];
    for (var i = 0; i < 5; i++) {
      _posts.add(_getPost());
    }
    return _posts;
  }

  void _testWebApi() async {
    var broadcasterList = await sl<WebRTCUseCase>().getLiveBroadcasterList();
    print("receive broadcaster: ${broadcasterList.length}");
    for (var room in broadcasterList) {
      print("room ${room.roomId} ${room.name}");
    }
  }
}
