import 'package:flutter/material.dart';

class CheckInModal extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 400);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor {
    return Colors.white.withOpacity(0);
  }

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  color: Theme.of(context).hintColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  "Check in",
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onChanged: (text) {
                  //_con.refreshSearch(text);
                },
                onSubmitted: (text) {
                  //_con.saveSearch(text);
                },
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: "Search location",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .caption
                      .merge(TextStyle(fontSize: 14)),
                  prefixIcon:
                      Icon(Icons.search, color: Theme.of(context).accentColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.1))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.3))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.1))),
                ),
              ),
            ),
//            PlacePicker(
//              apiKey: "AIzaSyAzbMso6DF4mCtqUNzSnNf-ZNzPtEgHMDE",
//              initialPosition: LatLng(0, 0),
//              useCurrentLocation: true,
//              //usePlaceDetailSearch: true,
//              onPlacePicked: (result) {
//                Navigator.of(context).pop();
//                setState(() {});
//              },
//            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var begin = Offset(0.0, 1.0);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end);
    Animation<Offset> offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
