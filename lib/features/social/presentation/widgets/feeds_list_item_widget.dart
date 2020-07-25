import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:military_hub/features/social/domain/entities/post.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:military_hub/features/social/presentation/widgets/user_avatar_widget.dart';

class FeedsListItemWidget extends StatefulWidget {
  final String heroTag;
  final Post post;

  const FeedsListItemWidget({Key key, this.post, this.heroTag})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FeedsListItemWidgetState();
}

class _FeedsListItemWidgetState extends State<FeedsListItemWidget> {
  @override
  Widget build(BuildContext context) {
    Widget _getSeparator(double height) {
      return Container(
        decoration: BoxDecoration(color: Theme.of(context).canvasColor),
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
                  child: UserAvatarWidget(),
                  padding: EdgeInsets.only(right: 10),
                ),
                Column(
                  children: <Widget>[
                    Text(currentUser.value.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black)),
                    Row(
                      children: <Widget>[
                        Text(
                          '15 mins ',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
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
              children: <Widget>[Icon(Icons.more_horiz, color: Colors.grey)],
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      );
    }

    Widget _postBody() {
      return Container(
        constraints: BoxConstraints(maxHeight: 350),
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    'https://rajaampatbiodiversity.com/wp-content/uploads/2019/06/visitar-raja-ampat.jpg'),
                fit: BoxFit.fill)),
      );
    }

    Widget postLikesAndComments() {
      return Container(
        child: Row(
          children: <Widget>[
            Container(
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
                                color: Colors.white, style: BorderStyle.solid)),
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
                decoration: BoxDecoration(color: Colors.white)),
            Container(
                child: Row(
              children: <Widget>[
                Text(
                  '13',
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
            ))
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        //  decoration: BoxDecoration(color: Colors.yellow),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      );
    }

    Widget postOptions() {
      return Container(
        child: Row(
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
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.all(0),
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
              _postHeader(),
              _postBody(),
              postLikesAndComments(),
              Divider(height: 1),
              postOptions()
            ],
          ),
          decoration: BoxDecoration(color: Colors.white),
        ),
      ),
    );
  }
}
