import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:military_hub/features/social/domain/entities/live_broadcaster.dart';
import 'package:military_hub/features/social/presentation/widgets/user_avatar_widget.dart';
import 'package:military_hub/helpers/helper.dart';

class LiveBroadcasterListItemWidget extends StatelessWidget {
  final String heroTag;
  final LiveBroadcaster broadcaster;

  const LiveBroadcasterListItemWidget({Key key, this.broadcaster, this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _getSeparator(double height) {
      return Container(
        decoration: BoxDecoration(color: Theme.of(context).canvasColor),
        constraints: BoxConstraints(maxHeight: height),
      );
    }

    Widget _getContent() {
      return Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: CachedNetworkImage(
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      imageUrl:
                          Helper.getImageUrlByIdNumber(broadcaster.userId),
                      placeholder: (context, url) => Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Theme.of(context).focusColor.withOpacity(0.8),
                                  Theme.of(context).focusColor.withOpacity(0.2),
                                ])),
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Theme.of(context).focusColor.withOpacity(0.8),
                                  Theme.of(context).focusColor.withOpacity(0.2),
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
            Text(broadcaster.name,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                )),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FlatButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                      icon: Icon(Icons.play_circle_outline,
                          size: 34, color: Colors.green),
                      label: Text('Play', style: TextStyle(fontSize: 12)),
                      textColor: Colors.grey,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/StreamView', arguments: broadcaster);
                      }),
                ],
              ),
            )
          ],
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      );
    }

    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              _getSeparator(10),
              _getContent(),
            ],
          ),
          decoration: BoxDecoration(color: Colors.white),
        ),
      ),
    );
  }
}
