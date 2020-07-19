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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Menu",
            style: Theme.of(context)
                .textTheme
                .headline2
                .merge(TextStyle(letterSpacing: 1.3))
                .merge(TextStyle(fontSize: 13))),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                title: MenuTitleWidget(title: 'Settings'),
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
