import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:military_hub/features/social/domain/entities/post.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:video_player/video_player.dart';

class FeedsListItemWidget extends StatefulWidget {
  final String heroTag;
  final Post post;

  const FeedsListItemWidget({Key key, this.post, this.heroTag})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FeedsListItemWidgetState();
}

class _FeedsListItemWidgetState extends State<FeedsListItemWidget> {
  GlobalKey btnKey = GlobalKey();
  FlickManager flickManager;
  bool _isVideo;

  @override
  void initState() {
    super.initState();
    _isVideo = widget.post.image.contains(".mp4");
    if (_isVideo) {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(widget.post.image),
        autoPlay: false,
      );
    }
  }

  @override
  void dispose() {
    if (flickManager != null) {
      flickManager.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    Widget _getSeparator(double height) {
      return Container(
        decoration: BoxDecoration(color: Theme.of(context).dividerColor),
        constraints: BoxConstraints(maxHeight: height),
      );
    }

    void reactToPost() {
      setState(() {
        if (widget.post.isLiked) {
          widget.post.isLiked = false;
          widget.post.likeCount--;
        } else {
          widget.post.isLiked = true;
          widget.post.likeCount++;
        }
      });
      print("Liked Post ? : $widget.post.isLiked");
    }

    Widget _postHeader() {
      return Container(
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: CachedNetworkImage(
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                          imageUrl: widget.post.profilePicture,
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
                Column(
                  children: <Widget>[
                    Text(widget.post.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black)),
                    Row(
                      children: <Widget>[
                        Text(
                          widget.post.readableCreatedAt,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 4),
                        ),
                        Icon(Icons.language, size: 15, color: Colors.grey)
                      ],
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                )
                //Container(),
              ],
            ),
            Row(
              children: <Widget>[
                IconButton(
                  key: btnKey,
                  icon: Icon(Icons.more_horiz, color: Colors.grey),
                  onPressed: () {
                    PopupMenu menu = PopupMenu(
                      maxColumn: 2,
                      items: [
                        MenuItem(
                            title: 'Copy',
                            image: Icon(
                              Icons.content_copy,
                              color: Colors.white,
                            )),
                        MenuItem(
                            title: 'Show on map',
                            image: Icon(
                              Icons.map,
                              color: Colors.white,
                            ))
                      ],
                      onClickMenu: (value) {
                        if (value.menuTitle == 'Show on map') {
                          Navigator.of(context).pushNamed('/MapView',
                              arguments: widget.post.userLocation);
                        }
                      },
                    );
                    menu.show(widgetKey: btnKey);
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      );
    }

    Widget _postBody() {
      return Column(
        children: <Widget>[
          widget.post.image != ""
              ? _isVideo
                  ? Container(
                      constraints: BoxConstraints(maxHeight: 350),
                      child: FlickVideoPlayer(
                        flickManager: flickManager,
                        flickVideoWithControls: FlickVideoWithControls(
                          controls: FlickPortraitControls(),
                        ),
                        flickVideoWithControlsFullscreen:
                            FlickVideoWithControls(
                          controls: FlickLandscapeControls(),
                        ),
                      ),
                    )
                  : Container(
                      constraints: BoxConstraints(maxHeight: 350),
                      decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                          image: DecorationImage(
                              image:
                                  CachedNetworkImageProvider(widget.post.image),
                              fit: BoxFit.cover)),
                    )
              : Container(),
          widget.post.description != ""
              ? Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Wrap(
                        children: <Widget>[
                          MarkdownBody(
                            data: widget.post.description,
                            styleSheet:
                                MarkdownStyleSheet.fromTheme(Theme.of(context))
                                    .copyWith(
                              textAlign: WrapAlignment.start,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          widget.post.locationName != ""
              ? Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Theme.of(context).accentColor.withOpacity(0.9),
                            Theme.of(context).accentColor.withOpacity(0.3),
                          ]),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Theme.of(context).hintColor.withOpacity(0.1),
                        )
                      ]),
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).primaryColorLight,
                        size: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25),
                        child: Text(
                          widget.post.locationName,
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: Theme.of(context).textTheme.caption.merge(
                              TextStyle(
                                  color: Theme.of(context).primaryColorLight)),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      );
    }

    Widget postLikesAndComments() {
      return Container(
        child: Row(
          children: <Widget>[
            widget.post.likeCount > 0
                ? Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: RawMaterialButton(
                            child: Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                              size: 14,
                            ),
                            shape: new CircleBorder(
                                side: BorderSide(
                                    color: Colors.white,
                                    style: BorderStyle.solid)),
                            fillColor: Colors.blue,
                            onPressed: () {},
                            highlightElevation: 0,
                          ),
                          width: 30,
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(widget.post.likeCount.toString(),
                            style: TextStyle(color: Colors.grey))
                      ],
                    ),
                    height: 30,
                    decoration: BoxDecoration(color: Colors.white))
                : Container(),
            widget.post.commentCount > 0
                ? Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.post.commentCount.toString(),
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Comments',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        //  decoration: BoxDecoration(color: Colors.yellow),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      );
    }

    Widget postOptions() {
      return Row(
        children: <Widget>[
          Expanded(
              child: FlatButton.icon(
                  icon: Icon(
                    Icons.thumb_up,
                    size: 16,
                  ),
                  label: Text('Like', style: TextStyle(fontSize: 12)),
                  textColor:
                      widget.post.isLiked == true ? Colors.blue : Colors.grey,
                  onPressed: reactToPost),
              flex: 1),
          Expanded(
              child: FlatButton.icon(
                  icon: Icon(
                    Icons.comment,
                    size: 16,
                  ),
                  label: Text('Comment', style: TextStyle(fontSize: 12)),
                  textColor: Colors.grey,
                  onPressed: () {}),
              flex: 1),
          Expanded(
              child: FlatButton.icon(
                  icon: Icon(
                    Icons.share,
                    size: 16,
                  ),
                  label: Text('Share', style: TextStyle(fontSize: 12)),
                  textColor: Colors.grey,
                  onPressed: () {}),
              flex: 1),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      );
    }

    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager.autoPause();
        }
      },
      child: Container(
        child: Column(
          children: <Widget>[
            _getSeparator(10),
            _postHeader(),
            _postBody(),
            //postLikesAndComments(),
            Divider(height: 1),
            postOptions()
          ],
        ),
        decoration: BoxDecoration(color: Colors.white),
      ),
    );
  }
}
