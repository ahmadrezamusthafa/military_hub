import 'package:cached_network_image/cached_network_image.dart';
import 'package:military_hub/features/social/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:military_hub/features/social/presentation/widgets/menu_title_widget.dart';
import '../widgets/page_title_widget.dart';

class MenuPage extends StatefulWidget {
  MenuPage();

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: PageTitleWidget(title: 'Menu'),
            backgroundColor: Colors.white,
            centerTitle: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                title: MenuTitleWidget(title: currentUser.value.name),
                leading: ClipRRect(
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
                subtitle: Text('View your profile'),
                onTap: () {},
              ),
              ListTile(
                title: MenuTitleWidget(title: 'Settings & Privacy'),
                leading: Icon(
                  Icons.settings,
                  size: 35,
                  color: Colors.blueGrey[300],
                ),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: MenuTitleWidget(title: 'Log Out'),
                leading: Icon(
                  Icons.power_settings_new,
                  size: 35,
                  color: Colors.blueGrey[300],
                ),
                onTap: () {},
              ),
              Divider(),
            ]),
          )
        ],
      ),
    );
  }
}
