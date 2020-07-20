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
import 'package:permission_handler/permission_handler.dart';

class LivePage extends StatefulWidget {
  final _localRenderer = new RTCVideoRenderer();

  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  JanusClient j;
  Plugin pluginHandle;
  MediaStream myStream;

  @override
  void initState() {
    super.initState();
    initPermission();
    initRenderer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initPermission() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  initRenderer() async {
    await widget._localRenderer.initialize();
  }

  Future<void> initPlatformState() async {
    setState(() {
      j = JanusClient(iceServers: [
        RTCIceServer(
            url: "stun:stun.l.google.com:19302",
            username: "onemandev",
            credential: "SecureIt"),
      ], server: [
        'ws://kitaundang.com:8188',
        'http://kitaundang.com:8001/janus'
      ], withCredentials: true, apiSecret: "SecureIt");
      j.connect(onSuccess: () async {
        debugPrint('voilla! connection established');
        Map<String, dynamic> configuration = {
          "iceServers": j.iceServers.map((e) => e.toMap()).toList()
        };

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
              var register = {
                "request": "join",
                "room": 1234,
                "ptype": "publisher",
                "display": 'reza'
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
            child: Expanded(
              flex: 1,
              child: Container(
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
            pluginHandle.hangup();
            widget._localRenderer.srcObject = null;
            widget._localRenderer.dispose();
            setState(() {
              pluginHandle = null;
            });
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
            await this.initRenderer();
            await this.initPlatformState();
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
