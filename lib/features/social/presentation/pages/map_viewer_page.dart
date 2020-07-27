import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:military_hub/features/social/domain/entities/live_broadcaster.dart';
import 'package:military_hub/features/social/domain/entities/near_user.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:military_hub/features/social/domain/usecase/user_usecase.dart';
import 'package:military_hub/features/social/domain/usecase/webrtc_usecase.dart';
import 'package:military_hub/features/social/presentation/bloc/fetch/user/bloc.dart';
import 'package:military_hub/helpers/helper.dart';
import 'package:military_hub/injection_container.dart';

class MapViewerPage extends StatefulWidget {
  const MapViewerPage();

  @override
  State<StatefulWidget> createState() => MapViewerPageState();
}

class MapViewerPageState extends State<MapViewerPage> {
  MapViewerPageState();

  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(-7.545449647437256, 112.46844716370106),
    zoom: 11.0,
  );

  CameraPosition _position = _kInitialPosition;
  bool _compassEnabled = true;
  bool _mapToolbarEnabled = true;
  CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  MinMaxZoomPreference _minMaxZoomPreference = MinMaxZoomPreference.unbounded;
  MapType _mapType = MapType.normal;
  bool _rotateGesturesEnabled = true;
  bool _scrollGesturesEnabled = true;
  bool _tiltGesturesEnabled = true;
  bool _zoomControlsEnabled = true;
  bool _zoomGesturesEnabled = true;
  bool _indoorViewEnabled = true;
  bool _myLocationEnabled = true;
  bool _myTrafficEnabled = false;
  bool _myLocationButtonEnabled = true;
  GoogleMapController _controller;
  BitmapDescriptor _normalMarkerIcon;
  BitmapDescriptor _broadcastMarkerIcon;
  BitmapDescriptor _streamMarkerIcon;
  Set<Marker> _markers = new Set<Marker>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int getIdNumber(String userId) {
    var ids = userId.split("_");
    if (ids.isNotEmpty && ids.length > 1) {
      var id = int.parse(ids[1]);
      return id;
    }
    return 0;
  }

  void _getNearUser() async {
    var broadcasterList = await sl<WebRTCUseCase>().getLiveBroadcasterList();
    var nearUsers = await sl<UserUseCase>().getNearUserList(
        currentUser.value.email,
        currentUser.value.password,
        currentUser.value.latitude,
        currentUser.value.longitude,
        radius: 1000000);
    if (nearUsers != null && nearUsers.isNotEmpty) {
      for (var user in nearUsers) {
        if (broadcasterList != null && broadcasterList.isNotEmpty) {
          user.isPublisher = broadcasterList
              .any((element) => element.roomId == getIdNumber(user.userId));
        }

        setState(() {
          if (!_markers.any((element) =>
              element.markerId == MarkerId("marker_${user.userId}"))) {
            _markers.add(
              Marker(
                markerId: MarkerId("marker_${user.userId}"),
                position:
                    Helper.getLatLngFromString(user.latitude, user.longitude),
                icon:
                    user.isPublisher ? _broadcastMarkerIcon : _normalMarkerIcon,
                onTap: () {
                  _showModal(context, user,
                      (LiveBroadcaster broadcaster, bool isView) {});
                },
              ),
            );
          } else {
            _markers.removeWhere((element) =>
                element.markerId == MarkerId("marker_${user.userId}"));
            _markers.add(
              Marker(
                markerId: MarkerId("marker_${user.userId}"),
                position:
                    Helper.getLatLngFromString(user.latitude, user.longitude),
                icon:
                    user.isPublisher ? _broadcastMarkerIcon : _normalMarkerIcon,
                onTap: () {
                  _showModal(context, user,
                      (LiveBroadcaster broadcaster, bool isView) {});
                },
              ),
            );
          }
        });
      }
    }
  }

  Widget buildMap() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  onMapCreated: onMapCreated,
                  initialCameraPosition: _kInitialPosition,
                  compassEnabled: _compassEnabled,
                  mapToolbarEnabled: _mapToolbarEnabled,
                  cameraTargetBounds: _cameraTargetBounds,
                  minMaxZoomPreference: _minMaxZoomPreference,
                  mapType: _mapType,
                  rotateGesturesEnabled: _rotateGesturesEnabled,
                  scrollGesturesEnabled: _scrollGesturesEnabled,
                  tiltGesturesEnabled: _tiltGesturesEnabled,
                  zoomGesturesEnabled: _zoomGesturesEnabled,
                  zoomControlsEnabled: _zoomControlsEnabled,
                  indoorViewEnabled: _indoorViewEnabled,
                  myLocationEnabled: _myLocationEnabled,
                  myLocationButtonEnabled: _myLocationButtonEnabled,
                  trafficEnabled: _myTrafficEnabled,
                  onCameraMove: _updateCameraPosition,
                  markers: _markers,
                ),
              ],
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
          icon: Icon(Icons.refresh),
          color: Theme.of(context).accentColor,
          onPressed: () async {
            _getNearUser();
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

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    final ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context);
    if (_normalMarkerIcon == null) {
      var bitmap = await BitmapDescriptor.fromAssetImage(
          imageConfiguration, 'assets/img/marker_b.png');
      _normalMarkerIcon = bitmap;
    }
    if (_broadcastMarkerIcon == null) {
      var bitmap = await BitmapDescriptor.fromAssetImage(
          imageConfiguration, 'assets/img/marker_o.png');
      _broadcastMarkerIcon = bitmap;
    }
    if (_streamMarkerIcon == null) {
      var bitmap = await BitmapDescriptor.fromAssetImage(
          imageConfiguration, 'assets/img/marker_g.png');
      _streamMarkerIcon = bitmap;
    }
  }

  void _showModal(
      BuildContext context, NearUser user, OnActionCallback onAction) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 160,
            color: Color(0xff737373),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black12
                    : Colors.white,
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0), topLeft: Radius.circular(0)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Container(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                child: CachedNetworkImage(
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                  imageUrl: user.profilePicture,
                                  placeholder: (context, url) => Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.8),
                                              Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.2),
                                            ])),
                                    child: Icon(
                                      Icons.person,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.8),
                                              Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.2),
                                            ])),
                                    child: Icon(
                                      Icons.person,
                                      color: Theme.of(context).primaryColor,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              width: 40,
                              height: 40),
                          padding: EdgeInsets.only(right: 10),
                        ),
                        Text(user.name,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            )),
                        user.isPublisher
                            ? Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    FlatButton.icon(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.0)),
                                        icon: Icon(Icons.play_circle_outline,
                                            size: 34, color: Colors.green),
                                        label: Text('Play',
                                            style: TextStyle(fontSize: 12)),
                                        textColor: Colors.grey,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          LiveBroadcaster broadcaster =
                                              LiveBroadcaster(
                                            roomId: getIdNumber(user.userId),
                                            userId: getIdNumber(user.userId),
                                            name: user.name,
                                          );
                                          Navigator.of(context).pushNamed(
                                              '/StreamView',
                                              arguments: broadcaster);
                                        }),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context).whenComplete(() => _getNearUser());
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
          title: Text("Live monitoring",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .merge(TextStyle(letterSpacing: 1.3))
                  .merge(TextStyle(fontSize: 13))),
          actions: _getAppBarActions(),
        ),
        body: Builder(builder: (context) {
          return buildMap();
        }));
  }

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      _position = position;
    });
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }
}

typedef void OnActionCallback(LiveBroadcaster broadcaster, bool actionView);
