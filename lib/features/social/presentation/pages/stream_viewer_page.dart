import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_webrtc/enums.dart';
import 'package:flutter_webrtc/media_stream.dart';
import 'package:flutter_webrtc/rtc_session_description.dart';
import 'package:flutter_webrtc/rtc_video_view.dart';
import 'package:janus_client/Plugin.dart';
import 'package:janus_client/janus_client.dart';
import 'package:janus_client/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:military_hub/features/social/domain/entities/live_broadcaster.dart';
import 'package:military_hub/features/social/domain/entities/room_participant.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class StreamViewerPage extends StatefulWidget {
  final _localRenderer = new RTCVideoRenderer();
  final LiveBroadcaster broadcaster;

  StreamViewerPage({this.broadcaster});

  StreamViewerPageState createState() => StreamViewerPageState();
}

class StreamViewerPageState extends State<StreamViewerPage> {
  @override
  void initState() {
    print("viewer page initState");
    super.initState();
  }

  @override
  void dispose() {
    print("viewer page dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
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
            Text("STREAM VIEW",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .merge(TextStyle(fontFamily: "Staatliches"))
                    .merge(TextStyle(letterSpacing: 1.3))
                    .merge(TextStyle(fontSize: 16))),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
                ],
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Theme.of(context).highlightColor.withOpacity(0.8),
                      Theme.of(context).highlightColor.withOpacity(0.2),
                    ])),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                color: Theme.of(context).dividerColor,
                constraints: BoxConstraints.expand(),
                child: RTCVideoView(
                  widget._localRenderer,
                ),
                height: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
