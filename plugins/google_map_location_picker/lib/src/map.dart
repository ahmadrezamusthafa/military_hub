import 'dart:async';
import 'dart:convert';

import 'package:android_intent/android_intent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:google_map_location_picker/generated/i18n.dart';
import 'package:google_map_location_picker/src/providers/location_provider.dart';
import 'package:google_map_location_picker/src/utils/loading_builder.dart';
import 'package:google_map_location_picker/src/utils/log.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'model/location_result.dart';
import 'utils/location_utils.dart';

class MapPicker extends StatefulWidget {
  const MapPicker(
    this.apiKey, {
    Key key,
    this.initialCenter,
    this.initialZoom,
    this.requiredGPS,
    this.myLocationButtonEnabled,
    this.layersButtonEnabled,
    this.automaticallyAnimateToCurrentLocation,
    this.mapStylePath,
    this.appBarColor,
    this.searchBarBoxDecoration,
    this.hintText,
    this.resultCardConfirmIcon,
    this.resultCardAlignment,
    this.resultCardDecoration,
    this.resultCardPadding,
  }) : super(key: key);

  final String apiKey;

  final LatLng initialCenter;
  final double initialZoom;

  final bool requiredGPS;
  final bool myLocationButtonEnabled;
  final bool layersButtonEnabled;
  final bool automaticallyAnimateToCurrentLocation;

  final String mapStylePath;

  final Color appBarColor;
  final BoxDecoration searchBarBoxDecoration;
  final String hintText;
  final Widget resultCardConfirmIcon;
  final Alignment resultCardAlignment;
  final Decoration resultCardDecoration;
  final EdgeInsets resultCardPadding;

  @override
  MapPickerState createState() => MapPickerState();
}

class MapPickerState extends State<MapPicker> {
  Completer<GoogleMapController> mapController = Completer();

  MapType _currentMapType = MapType.normal;

  String _mapStyle;

  LatLng _lastMapPosition;

  Position _currentPosition;

  String _address;

  void _onToggleMapTypePressed() {
    final MapType nextType =
        MapType.values[(_currentMapType.index + 1) % MapType.values.length];

    setState(() => _currentMapType = nextType);
  }

  // this also checks for location permission.
  Future<void> _initCurrentLocation() async {
    Position currentPosition;
    try {
      currentPosition = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

      d("position = $currentPosition");

      setState(() => _currentPosition = currentPosition);
    } on PlatformException catch (e) {
      currentPosition = null;
      d("_initCurrentLocation#e = $e");
    }

    if (!mounted) return;

    setState(() => _currentPosition = currentPosition);

    if (currentPosition != null)
      moveToCurrentLocation(
          LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  Future moveToCurrentLocation(LatLng currentLocation) async {
    final controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: currentLocation, zoom: 16),
    ));
  }

  @override
  void initState() {
    super.initState();
    if (widget.automaticallyAnimateToCurrentLocation) _initCurrentLocation();

    if (widget.mapStylePath != null) {
      rootBundle.loadString(widget.mapStylePath).then((string) {
        _mapStyle = string;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.requiredGPS) {
      _checkGps();
      _checkGeolocationPermission();
    }
    return Scaffold(
      body: Builder(builder: (context) {
        if (_currentPosition == null &&
            widget.automaticallyAnimateToCurrentLocation &&
            widget.requiredGPS) {
          return const Center(child: CircularProgressIndicator());
        }

        return buildMap();
      }),
    );
  }

  Widget buildMap() {
    return Center(
      child: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: false,
            scrollGesturesEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            initialCameraPosition: CameraPosition(
              target: widget.initialCenter,
              zoom: widget.initialZoom,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
              //Implementation of mapStyle
              if (widget.mapStylePath != null) {
                controller.setMapStyle(_mapStyle);
              }

              _lastMapPosition = widget.initialCenter;
              LocationProvider.of(context, listen: false)
                  .setLastIdleLocation(_lastMapPosition);
            },
            onCameraMove: (CameraPosition position) {
              _lastMapPosition = position.target;
            },
            onCameraIdle: () async {
              print("onCameraIdle#_lastMapPosition = $_lastMapPosition");
              LocationProvider.of(context, listen: false)
                  .setLastIdleLocation(_lastMapPosition);
            },
            onCameraMoveStarted: () {
              print("onCameraMoveStarted#_lastMapPosition = $_lastMapPosition");
            },
            mapType: _currentMapType,
            myLocationEnabled: true,
          ),
          _MapFabs(
            myLocationButtonEnabled: widget.myLocationButtonEnabled,
            layersButtonEnabled: widget.layersButtonEnabled,
            onToggleMapTypePressed: _onToggleMapTypePressed,
            onMyLocationPressed: _initCurrentLocation,
          ),
          pin(),
          locationCard(),
        ],
      ),
    );
  }

  Widget locationCard() {
    return Align(
      alignment: widget.resultCardAlignment ?? Alignment.bottomCenter,
      child: Stack(
        alignment: widget.resultCardAlignment ?? Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 200,
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(155, 17, 91, 145),
                Color.fromARGB(0, 17, 91, 145)
              ],
            )),
          ),
          Padding(
              padding: widget.resultCardPadding ?? EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Consumer<LocationProvider>(
                          builder: (context, locationProvider, _) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 20,
                                  child: FutureLoadingBuilder<String>(
                                      future: getAddress(
                                          locationProvider.lastIdleLocation),
                                      mutable: true,
                                      loadingIndicator: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                                      builder: (context, address) {
                                        _address = address;
                                        return Text(
                                          address ?? 'Unnamed place',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        );
                                      }),
                                ),
                                Spacer(),
                                FloatingActionButton(
                                  onPressed: () {
                                    Navigator.of(context).pop({
                                      'location': LocationResult(
                                        latLng:
                                            locationProvider.lastIdleLocation,
                                        address: _address,
                                      )
                                    });
                                  },
                                  child: widget.resultCardConfirmIcon ??
                                      Icon(Icons.check),
                                ),
                              ],
                            ),
                            SizedBox(height: 14,),
                            Divider(),
                            SizedBox(height: 8,),
                            Form(
                              child: Column(
                                children: <Widget>[
                                  new TextFormField(
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                    keyboardType: TextInputType.text,
                                    decoration: getInputDecoration(
                                      hintText: "Describe about the situations",
                                      labelText: "What's on your Mind?",
                                    ),
                                    initialValue: "",
                                    validator: (input) => input.trim().length < 3
                                        ? "Invalid full name"
                                        : null,
                                    onSaved: (input) => {},
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        );
                      }),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.0))),
      focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.0))),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  Future<String> getAddress(LatLng location) async {
    try {
      var endPoint =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location?.latitude},${location?.longitude}&key=${widget.apiKey}';
      var response = jsonDecode((await http.get(
        endPoint,
      ))
          .body);

      return response['results'][0]['formatted_address'];
    } catch (e) {
      print(e);
    }

    return null;
  }

  Widget pin() {
    return IgnorePointer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.place,
              size: 36,
              color: Colors.blueAccent,
            ),
            Container(
              decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black38,
                  ),
                ],
                shape: CircleBorder(
                  side: BorderSide(
                    width: 4,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  var dialogOpen;

  Future _checkGeolocationPermission() async {
    var geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();

    if (geolocationStatus == GeolocationStatus.denied && dialogOpen == null) {
      d('showDialog');
      dialogOpen = showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(S.of(context)?.access_to_location_denied ??
                'Access to location denied'),
            content: Text(
                S.of(context)?.allow_access_to_the_location_services ??
                    'Allow access to the location services.'),
            actions: <Widget>[
              FlatButton(
                child: Text(S.of(context)?.ok ?? 'Ok'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  _initCurrentLocation();
                  dialogOpen = null;
                },
              ),
            ],
          );
        },
      );
    } else if (geolocationStatus == GeolocationStatus.disabled) {
      // FIXME: handle this case
    } else if (geolocationStatus == GeolocationStatus.granted) {
      d('GeolocationStatus.granted');
      if (dialogOpen != null) {
        Navigator.of(context, rootNavigator: true).pop();
        dialogOpen = null;
      }
    }
  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(S.of(context)?.cant_get_current_location ??
                  "Can't get current location"),
              content: Text(S
                      .of(context)
                      ?.please_make_sure_you_enable_gps_and_try_again ??
                  'Please make sure you enable GPS and try again'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    final AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');

                    intent.launch();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}

class _MapFabs extends StatelessWidget {
  const _MapFabs({
    Key key,
    @required this.myLocationButtonEnabled,
    @required this.layersButtonEnabled,
    @required this.onToggleMapTypePressed,
    @required this.onMyLocationPressed,
  })  : assert(onToggleMapTypePressed != null),
        super(key: key);

  final bool myLocationButtonEnabled;
  final bool layersButtonEnabled;

  final VoidCallback onToggleMapTypePressed;
  final VoidCallback onMyLocationPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: kToolbarHeight + 0, right: 8),
      child: Column(
        children: <Widget>[
          // if (layersButtonEnabled)
//          FloatingActionButton(
//            onPressed: onToggleMapTypePressed,
//            materialTapTargetSize: MaterialTapTargetSize.padded,
//            mini: true,
//            child: const Icon(Icons.layers),
//            heroTag: "layers",
//          ),
          // if (myLocationButtonEnabled)
          FloatingActionButton(
            onPressed: onMyLocationPressed,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            mini: true,
            child: const Icon(Icons.my_location),
            heroTag: "myLocation",
          ),
        ],
      ),
    );
  }
}
