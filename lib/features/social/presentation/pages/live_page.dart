import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
import 'package:military_hub/features/social/domain/entities/room_participant.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class LivePage extends StatefulWidget {
  final _localRenderer = new RTCVideoRenderer();

  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  JanusClient j;
  JanusClient jChecker;
  Plugin pluginHandle;
  Plugin pluginChecker;
  MediaStream myStream;
  Timer _timer;
  bool isStopped = true;

  @override
  void initState() {
    print("live page initState");
    super.initState();
    initPermission();
    initRenderer();
  }

  @override
  void dispose() {
    print("live page dispose");
    stopLive();
    super.dispose();
  }

  void initPermission() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  initRenderer() async {
    await widget._localRenderer.initialize();
  }

  int getIdNumber() {
    /*var ids = currentUser.value.userId.split("_");
    if (ids.isNotEmpty && ids.length > 1) {
      var id = int.parse(ids[1]);
      return id;
    }
    return 0;*/
    return 1234;
  }

  Future<void> initPlatformState() async {
    setState(() {
      if (j == null) {
        j = JanusClient(iceServers: [
          RTCIceServer(
              url: "stun:stun.l.google.com:19302",
              username: "onemandev",
              credential: "SecureIt"),
        ], server: [
          'ws://kitaundang.com:8188'
        ], withCredentials: true, apiSecret: "SecureIt");
      }
      var register = {
        "request": "join",
        "room": getIdNumber(),
        "ptype": "publisher",
        "display": currentUser.value.name + " - " + currentUser.value.email,
        "id": getIdNumber()
      };
      if (!j.isConnected || pluginHandle == null) {
        j.connect(onSuccess: () async {
          debugPrint('voilla! connection established');
          j.attach(Plugin(
              plugin: 'janus.plugin.videoroom',
              onMessage: (msg, jsep) async {
                print('publisheronmsg');
                if (jsep != null) {
                  pluginHandle.handleRemoteJsep(jsep);
                }
              },
              onSuccess: (plugin) async {
                setState(() {
                  pluginHandle = plugin;
                });
                MediaStream stream = await plugin.initializeMediaDevices();
                setState(() {
                  myStream = stream;
                });
                setState(() {
                  widget._localRenderer.srcObject = myStream;
                  widget._localRenderer.mirror = true;
                });
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
      } else {
        pluginHandle.send(
            message: register,
            onSuccess: () async {
              var publish = {
                "request": "configure",
                "audio": true,
                "video": true,
                "bitrate": 2000000
              };
              RTCSessionDescription offer = await pluginHandle.createOffer();
              pluginHandle.send(
                  message: publish, jsep: offer, onSuccess: () {});
            },
            onError: (e) {
              print("send pluginHandle error: ${e.toString()}");
            });
      }
    });
  }

  Future<void> syncPlatformState() async {
    if (jChecker == null) {
      jChecker = JanusClient(iceServers: [
        RTCIceServer(
            url: "stun:stun.l.google.com:19302",
            username: "onemandev",
            credential: "SecureIt"),
      ], server: [
        'ws://kitaundang.com:8188'
      ], withCredentials: true, apiSecret: "SecureIt");
    }
    var list = {"request": "listparticipants", "room": getIdNumber()};
    if (!jChecker.isConnected || pluginChecker == null) {
      jChecker.connect(onSuccess: () async {
        print("onSuccess connect");
        jChecker.attach(Plugin(
            plugin: 'janus.plugin.videoroom',
            onMessage: (msg, jsep) async {},
            onSuccess: (plugin) async {
              setState(() {
                pluginChecker = plugin;
              });
              print("onSuccess attach");
              plugin.send(
                  message: list,
                  onSuccess: (data) async {
                    processParticipant(data);
                  });
            }));
      }, onError: (e) {
        debugPrint('some error occured');
      });
    } else {
      pluginChecker.send(
          message: list,
          onSuccess: (data) async {
            processParticipant(data);
          },
          onError: (e) {
            print("send pluginChecker error: ${e.toString()}");
          });
    }
  }

  void processParticipant(dynamic data) async {
    Participant participant = Participant.fromJson(data);
    print("receive LIST data ${data.toString()}");
    int i = 0;
    bool found = false;
    for (var value in participant.participants) {
      i++;
      print("participant $i id:${value.id} display:${value.display}");
      if (value.id == getIdNumber()) {
        found = true;
        break;
      }
    }
    if (!found) {
      print("force reload connection");
      stopLive();
      await Future.delayed(Duration(seconds: 1));
      startLive();
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 3);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          print("timer tick");
          try {
            syncPlatformState();
          } catch (e) {
            print("exception syncPlatformState: ${e.toString()}");
          }
        },
      ),
    );
  }

  void stopTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  startLive() async {
    if (isStopped) {
      isStopped = false;
      await this.initRenderer();
      await this.initPlatformState();
      startTimer();
    }
  }

  stopLive() {
    isStopped = true;
    stopTimer();
    if (pluginHandle != null) {
      pluginHandle.hangup();
      pluginHandle.detach();
    }
    if (pluginChecker != null) {
      pluginChecker.hangup();
      pluginChecker.detach();
    }
    widget._localRenderer.srcObject = null;
    try {
      widget._localRenderer.dispose();
    } catch (e) {
      print("got error when call dispose: ${e.toString()}");
    }
    setState(() {
      pluginHandle = null;
      pluginChecker = null;
    });
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
                Text("LIVE CAMERA",
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
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Container(
              child: RTCVideoView(
                widget._localRenderer,
              ),
              height: 10,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getAppBarActions() {
    return [
      Container(
        child: IconButton(
          icon: Icon(
            Icons.stop,
            color: Colors.red,
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {
            stopLive();
          },
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
          icon: Icon(
            Icons.play_circle_outline,
            color: Colors.green,
          ),
          color: Theme.of(context).accentColor,
          onPressed: () async {
            await startLive();
          },
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
          icon: Icon(
            Icons.switch_video,
            color: Colors.blueAccent,
            size: 20,
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {
            if (pluginHandle != null) {
              pluginHandle.switchCamera();
            }
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
}
