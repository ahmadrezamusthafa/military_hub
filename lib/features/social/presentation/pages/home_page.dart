import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:military_hub/features/social/presentation/widgets/user_avatar_widget.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int likes = 136;
  bool isLiked = false;
  LocationResult _pickedLocation;

  void reactToPost() {
    setState(() {
      if (isLiked) {
        isLiked = false;
        likes--;
      } else {
        isLiked = true;
        likes++;
      }
    });
    print("Liked Post ? : $isLiked");
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
                Text("Hub",
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
          SliverList(
              delegate: new SliverChildListDelegate([
            _getSeparator(5),
            _addPost(),
            _getSeparator(10),
            Column(children: _getPosts())
          ]))
        ],
      ),
    );
  }

  List<Widget> _getAppBarActions() {
    return [
      Container(
        child: IconButton(
          icon: Icon(Icons.search),
          color: Theme.of(context).accentColor,
          onPressed: () {},
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
          icon: Icon(Icons.notifications),
          color: Theme.of(context).accentColor,
          onPressed: () {},
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

  Widget _getSeparator(double height) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).dividerColor),
      constraints: BoxConstraints(maxHeight: height),
    );
  }

  Widget _addPostHeader() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  imageUrl: currentUser.value.profilePicture,
                  placeholder: (context, url) => Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
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
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
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
              padding: EdgeInsets.only(right: 10)),
          Text(
            "What's on your Mind ?",
            style: TextStyle(color: Colors.black87),
          )
        ],
      ),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    );
  }

  Widget _addPostOptions() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
              child: FlatButton.icon(
                  icon: Icon(Icons.videocam, color: Colors.red),
                  label: Text('Live'),
                  textColor: Colors.grey,
                  onPressed: () {}),
              flex: 1),
          Expanded(
              child: FlatButton.icon(
                  icon: Icon(Icons.photo, color: Colors.green),
                  label: Text('Photo'),
                  textColor: Colors.grey,
                  onPressed: () {}),
              flex: 1),
          Expanded(
            child: FlatButton.icon(
                icon: Icon(Icons.location_on, color: Colors.pink),
                label: Text('Check In'),
                textColor: Colors.grey,
                onPressed: () async {
                  LocationResult result = await showLocationPicker(
                    context,
                    "AIzaSyA45S8Vcq7_RzUQoMvKfHTv1nfBhy2BHdA",
                    initialCenter:
                        LatLng(-7.545449647437256, 112.46844716370106),
                    myLocationButtonEnabled: true,
                    layersButtonEnabled: true,
                  );
                  print("result = $result");
                  setState(() => _pickedLocation = result);
                }),
            flex: 1,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }

  Widget _addPost() {
    return Container(
      child: Column(children: <Widget>[
        _addPostHeader(),
        Divider(),
        _addPostOptions(),
      ]),
      decoration: BoxDecoration(color: Colors.white),
    );
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
                  Text('Ahmad Reza Musthafa',
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
                  Text(likes.toString(), style: TextStyle(color: Colors.grey))
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
                  textColor: isLiked == true ? Colors.blue : Colors.grey,
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

  Widget _getPost() {
    return Container(
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
    );
  }

  List<Widget> _getPosts() {
    List<Widget> _posts = [];
    for (var i = 0; i < 5; i++) {
      _posts.add(_getPost());
    }
    return _posts;
  }

  Widget _getStories() {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.yellow),
        height: 300,
      ),
    );
  }
}
