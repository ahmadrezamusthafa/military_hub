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
import 'package:military_hub/features/social/domain/entities/room_participant.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen/screen.dart';

class LivePage extends StatefulWidget {
  final _localRenderer = new RTCVideoRenderer();

  LivePageState createState() => LivePageState();
}

class LivePageState extends State<LivePage> {
  final janusSecret = "adminpwd";
  JanusClient _j;
  JanusClient _jChecker;
  Plugin _pluginHandle;
  Plugin _pluginChecker;
  MediaStream _myStream;
  Timer _timer;
  bool isStopped = true;
  int idNumber;

  @override
  void initState() {
    print("live page initState");
    super.initState();
    initPermission();
    initRenderer();
    idNumber = getIdNumber();
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
    var ids = currentUser.value.userId.split("_");
    if (ids.isNotEmpty && ids.length > 1) {
      var id = int.parse(ids[1]);
      return id;
    }
    return 0;
  }

  Future<void> initPlatformState() async {
    setState(() {
      if (_j == null) {
        _j = JanusClient(iceServers: [
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
        "room": idNumber,
        "ptype": "publisher",
        "display": currentUser.value.name,
        "id": idNumber
      };
      if (!_j.isConnected || _pluginHandle == null) {
        _j.connect(onSuccess: () async {
          debugPrint('voilla! connection established');
          _j.attach(Plugin(
              plugin: 'janus.plugin.videoroom',
              onMessage: (msg, jsep) async {
                print('publisheronmsg');
                if (jsep != null) {
                  _pluginHandle.handleRemoteJsep(jsep);
                }
              },
              onSuccess: (plugin) async {
                setState(() {
                  _pluginHandle = plugin;
                });
                MediaStream stream = await plugin.initializeMediaDevices();
                setState(() {
                  _myStream = stream;
                });
                setState(() {
                  widget._localRenderer.srcObject = _myStream;
                  widget._localRenderer.mirror = false;
                  widget._localRenderer.objectFit =
                      RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;
                });

                var create = {
                  "request": "create",
                  "room": idNumber,
                  "permanent": false,
                  "description": currentUser.value.name,
                  "secret": janusSecret
                };
                plugin.send(
                    message: create,
                    onSuccess: (data) async {
                      print("room $idNumber success created");
                      plugin.send(
                          message: register,
                          onSuccess: () async {
                            var publish = {
                              "request": "configure",
                              "audio": true,
                              "video": true,
                              "bitrate": 2000000
                            };
                            RTCSessionDescription offer =
                                await plugin.createOffer();
                            plugin.send(
                                message: publish,
                                jsep: offer,
                                onSuccess: () {});
                          });
                    });
              }));
        }, onError: (e) {
          debugPrint('some error occured');
        });
      } else {
        _pluginHandle.send(
            message: register,
            onSuccess: () async {
              var publish = {
                "request": "configure",
                "audio": true,
                "video": true,
                "bitrate": 2000000
              };
              RTCSessionDescription offer = await _pluginHandle.createOffer();
              _pluginHandle.send(
                  message: publish, jsep: offer, onSuccess: () {});
            },
            onError: (e) {
              print("send pluginHandle error: ${e.toString()}");
            });
      }
    });
  }

  Future<void> syncPlatformState() async {
    if (_jChecker == null) {
      _jChecker = JanusClient(iceServers: [
        RTCIceServer(
            url: "stun:stun.l.google.com:19302",
            username: "onemandev",
            credential: "SecureIt"),
      ], server: [
        'ws://kitaundang.com:8188'
      ], withCredentials: true, apiSecret: "SecureIt");
    }
    var list = {"request": "listparticipants", "room": idNumber};
    if (!_jChecker.isConnected || _pluginChecker == null) {
      _jChecker.connect(onSuccess: () async {
        print("onSuccess connect");
        _jChecker.attach(Plugin(
            plugin: 'janus.plugin.videoroom',
            onMessage: (msg, jsep) async {},
            onSuccess: (plugin) async {
              setState(() {
                _pluginChecker = plugin;
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
      _pluginChecker.send(
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
    RoomParticipant participant = RoomParticipant.fromJson(data);
    print("receive LIST data ${data.toString()}");
    int i = 0;
    bool found = false;
    for (var value in participant.participants) {
      i++;
      print("participant $i id:${value.id} display:${value.display}");
      if (value.id == idNumber) {
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
      Screen.keepOn(true);
      isStopped = false;
      await this.initRenderer();
      await this.initPlatformState();
      startTimer();
    }
  }

  stopLive() {
    Screen.keepOn(false);
    isStopped = true;
    stopTimer();
    if (_pluginHandle != null) {
      //delete room
      var delete = {
        "request": "destroy",
        "room": idNumber,
        "permanent": false,
        "secret": janusSecret
      };
      _pluginHandle.send(
          message: delete,
          onSuccess: () async {
            print("room success deleted");
          });

      _pluginHandle.hangup();
      _pluginHandle.detach();
    }
    if (_pluginChecker != null) {
      _pluginChecker.hangup();
      _pluginChecker.detach();
    }
    if (widget._localRenderer != null) {
      widget._localRenderer.srcObject = null;
    }
    try {
      widget._localRenderer.dispose();
    } catch (e) {
      print("got error when call dispose: ${e.toString()}");
    }
    setState(() {
      _pluginHandle = null;
      _pluginChecker = null;
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
            Text("BROADCAST",
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
                      Theme.of(context).hintColor.withOpacity(0.8),
                      Theme.of(context).highlightColor.withOpacity(0.2),
                    ])),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Container(
                color: Theme.of(context).hintColor,
                constraints: BoxConstraints.expand(),
                child: RTCVideoView(
                  widget._localRenderer,
                ),
              ),
            ),
          ),
          isStopped
              ? Container(
                  alignment: Alignment.center,
                  child: Text("Press play button to broadcast your camera",
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
                      mini: true,
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
                      backgroundColor: Colors.redAccent,
                      child: const Icon(Icons.play_arrow),
                      onPressed: () async {
                        await startLive();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    FloatingActionButton(
                      mini: true,
                      backgroundColor: Colors.white10.withAlpha(70),
                      child: const Icon(Icons.autorenew),
                      onPressed: () {
                        if (_pluginHandle != null) {
                          _pluginHandle.switchCamera();
                        }
                      },
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
