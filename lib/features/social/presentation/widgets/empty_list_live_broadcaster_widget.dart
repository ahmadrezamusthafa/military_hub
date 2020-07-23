import 'package:flutter/material.dart';
import '../../../../config/app_config.dart' as config;

class EmptyListLiveBroadcasterWidget extends StatefulWidget {
  EmptyListLiveBroadcasterWidget({
    Key key,
  }) : super(key: key);

  @override
  _EmptyListLiveBroadcasterWidgetState createState() =>
      _EmptyListLiveBroadcasterWidgetState();
}

class _EmptyListLiveBroadcasterWidgetState
    extends State<EmptyListLiveBroadcasterWidget> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(40),
          alignment: AlignmentDirectional.center,
          padding: EdgeInsets.symmetric(horizontal: 0),
          height: config.App(context).appHeight(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Theme.of(context).focusColor.withOpacity(0.7),
                              Theme.of(context).focusColor.withOpacity(0.05),
                            ])),
                    child: Icon(
                      Icons.supervised_user_circle,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 65,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Opacity(
                opacity: 0.4,
                child: Text(
                  "No broadcaster live",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .merge(TextStyle(fontWeight: FontWeight.w300, fontSize: 24)),
                ),
              ),
              SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
