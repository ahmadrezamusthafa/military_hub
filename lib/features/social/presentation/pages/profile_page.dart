import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:military_hub/features/social/domain/entities/menu_item.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:military_hub/features/social/presentation/widgets/photo_viewer_widget.dart';
import 'package:military_hub/features/social/presentation/widgets/profile_settings_dialog.dart';
import 'package:military_hub/helpers/helper.dart';

class ProfilePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ProfilePage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  String imagePath;

  void _onImageButtonPressed({BuildContext context}) async {
    _showModal(context, (double maxWidth, double maxHeight, int quality,
        ImageSource source) async {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        setState(() {
          imagePath = pickedFile.path;
          print(imagePath);
        });
      } catch (e) {
        print("$e");
      }
    });
  }

  void _showModal(BuildContext context, OnPickImageCallback onPick) {
    final double maxWidth = 1000;
    final double maxHeight = 1000;
    final int maxQuality = 80;

    List<MenuItem> menuItems = [
      MenuItem(
        text: "Camera",
        icons: Icons.camera_alt,
        color: Colors.amber,
      ),
      MenuItem(
        text: "Gallery",
        icons: Icons.album,
        color: Colors.blue,
      )
    ];

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
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
                  ListView.builder(
                    itemCount: menuItems.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return new Material(
                        color: Colors.transparent,
                        child: new InkWell(
                          onTap: () {
                            if (menuItems[index].text == "Camera") {
                              onPick(maxWidth, maxHeight, maxQuality,
                                  ImageSource.camera);
                            } else {
                              onPick(maxWidth, maxHeight, maxQuality,
                                  ImageSource.gallery);
                            }
                            Navigator.of(context).pop();
                            print("tapped ${menuItems[index].text}");
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: menuItems[index].color.shade50,
                                ),
                                height: 50,
                                width: 50,
                                child: Icon(
                                  menuItems[index].icons,
                                  size: 20,
                                  color: menuItems[index].color.shade400,
                                ),
                              ),
                              title: Text(menuItems[index].text),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text("Profile",
            style: Theme.of(context)
                .textTheme
                .headline2
                .merge(TextStyle(
                    letterSpacing: 1.3, color: Theme.of(context).primaryColor))
                .merge(TextStyle(fontSize: 13))),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 150,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  _onImageButtonPressed(context: context);
                                },
                                child: Icon(Icons.photo_camera,
                                    color: Theme.of(context).primaryColor),
                                color: Theme.of(context).accentColor,
                                shape: StadiumBorder(),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhotoViewerWidget(
                                      imageProvider: CachedNetworkImageProvider(
                                          currentUser.value.profilePicture),
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: "viewPhotoTag",
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  child: CachedNetworkImage(
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                    imageUrl: currentUser.value.profilePicture,
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
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: ProfileSettingsDialog(
                                user: currentUser.value,
                                onChanged: () {
                                  //setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 110),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: <Widget>[
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Text(
                          "Name",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        trailing: Text(
                          currentUser.value.name,
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Text(
                          "Email",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        trailing: Text(
                          currentUser.value.email,
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Text(
                          "Phone",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        trailing: Text(
                          currentUser.value.phoneNumber,
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Text(
                          "Address",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        trailing: Text(
                          Helper.limitString(currentUser.value.address),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Text(
                          "Status",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        trailing: Text(
                          Helper.limitString(currentUser.value.profileStatus),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality, ImageSource source);
