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
import 'package:uuid/uuid.dart';

class StreamViewerPage extends StatefulWidget {
  final _remoteRenderer = new RTCVideoRenderer();
  final _localRenderer = new RTCVideoRenderer();

  final LiveBroadcaster broadcaster;

  StreamViewerPage({this.broadcaster});

  StreamViewerPageState createState() => StreamViewerPageState();
}

class StreamViewerPageState extends State<StreamViewerPage> {
  JanusClient _j;
  Plugin subscriberHandle;
  MediaStream remoteStream;
  Plugin pluginHandle;
  MediaStream myStream;
  bool isStopped = true;
  int idNumber;

  @override
  void initState() {
    print("viewer page initState");
    super.initState();
    initRenderer();
    idNumber = getIdNumber();
  }

  @override
  void dispose() {
    print("viewer page dispose");
    super.dispose();
  }

  initRenderer() async {
    await widget._remoteRenderer.initialize();
  }

  startLive() async {
    if (isStopped) {
      isStopped = false;
      await this.initRenderer();
      await this.initPlatformState();
    }
  }

  stopLive() {
    isStopped = true;
    if (pluginHandle != null) {
      pluginHandle.hangup();
      pluginHandle.detach();
    }
    if (subscriberHandle != null) {
      subscriberHandle.hangup();
      subscriberHandle.detach();
    }

    if (widget._localRenderer != null) {
      widget._localRenderer.srcObject = null;
    }
    if (widget._remoteRenderer != null) {
      widget._remoteRenderer.srcObject = null;
    }
    try {
      widget._localRenderer.dispose();
    } catch (e) {
      print("got error when call dispose: ${e.toString()}");
    }
    try {
      widget._remoteRenderer.dispose();
    } catch (e) {
      print("got error when call dispose: ${e.toString()}");
    }
    setState(() {
      pluginHandle = null;
      subscriberHandle = null;
    });
  }

  int getIdNumber() {
    var ids = currentUser.value.userId.split("_");
    if (ids.isNotEmpty && ids.length > 1) {
      var id = int.parse(ids[1]);
      return id;
    }
    return 0;
  }

  _newRemoteFeed(JanusClient j, feed) async {
    print('remote plugin attached');
    j.attach(Plugin(
        plugin: 'janus.plugin.videoroom',
        onMessage: (msg, jsep) async {
          if (jsep != null) {
            await subscriberHandle.handleRemoteJsep(jsep);
            var body = {"request": "start", "room": widget.broadcaster.roomId};

            await subscriberHandle.send(
                message: body,
                jsep: await subscriberHandle.createAnswer(),
                onSuccess: () {});
          }
        },
        onSuccess: (plugin) {
          setState(() {
            subscriberHandle = plugin;
          });
          var register = {
            "request": "join",
            "room": widget.broadcaster.roomId,
            "ptype": "subscriber",
            "feed": feed,
            //"private_id": widget.broadcaster.userId,
          };
          subscriberHandle.send(message: register, onSuccess: () async {});
        },
        onRemoteStream: (stream) {
          print('got remote stream');
          setState(() {
            remoteStream = stream;
            widget._remoteRenderer.srcObject = remoteStream;
            widget._remoteRenderer.mirror = false;
          });
        }));
  }

  Future<void> initPlatformState() async {
    setState(() {
      _j = JanusClient(iceServers: [
        RTCIceServer(
            url: "stun:stun.l.google.com:19302",
            username: "onemandev",
            credential: "SecureIt"),
      ], server: [
        'ws://kitaundang.com:8188'
      ], withCredentials: true, apiSecret: "SecureIt");
      _j.connect(onSuccess: () async {
        debugPrint('voilla! connection established');
        Map<String, dynamic> configuration = {
          "iceServers": _j.iceServers.map((e) => e.toMap()).toList()
        };

        _j.attach(Plugin(
            plugin: 'janus.plugin.videoroom',
            onMessage: (msg, jsep) async {
              print('publisheronmsg');
              if (msg["publishers"] != null) {
                var list = msg["publishers"];
                print('got publihers');
                print(list);
                _newRemoteFeed(_j, list[0]["id"]);
              }

              if (jsep != null) {
                pluginHandle.handleRemoteJsep(jsep);
              }
            },
            onSuccess: (plugin) async {
              setState(() {
                pluginHandle = plugin;
              });
              var mediaConstraints = {
                "audio": true,
                "video": false,
              };
              MediaStream stream = await plugin.initializeMediaDevices(
                  mediaConstraints: mediaConstraints);
              setState(() {
                myStream = stream;
              });
              setState(() {
                widget._localRenderer.srcObject = myStream;
                widget._localRenderer.mirror = true;
              });
              var register = {
                "request": "join",
                "room": widget.broadcaster.roomId,
                "ptype": "publisher",
                "display": currentUser.value.name,
                "id": idNumber,
              };
              plugin.send(
                  message: register,
                  onSuccess: () async {
                    var publish = {
                      "request": "configure",
                      "audio": true,
                      "video": true,
                      "bitrate": 2000000
                    };
                    RTCSessionDescription offer = await plugin.createOffer();
                    plugin.send(
                        message: publish, jsep: offer, onSuccess: () {});
                  });
            }));
      }, onError: (e) {
        debugPrint('some error occured');
      });
    });
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
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
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
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Container(
                color: Theme.of(context).hintColor,
                constraints: BoxConstraints.expand(),
                child: RTCVideoView(
                  widget._remoteRenderer,
                ),
                height: 10,
              ),
            ),
          ),
          isStopped
              ? Container(
                  alignment: Alignment.center,
                  child: Text("Press play button to stream",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      )),
                )
              : Container(),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(10),
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: Uuid(),
                      backgroundColor: Colors.white10.withAlpha(70),
                      child: const Icon(Icons.stop),
                      onPressed: () {
                        stopLive();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    FloatingActionButton(
                      heroTag: Uuid(),
                      backgroundColor: Colors.redAccent,
                      child: const Icon(Icons.play_arrow),
                      onPressed: () async {
                        await startLive();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
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
                          Theme.of(context).accentColor.withOpacity(0.8),
                          Theme.of(context).primaryColorDark.withOpacity(0.2),
                        ])),
              ),
            ),
          )
        ],
      ),
    );
  }
}
