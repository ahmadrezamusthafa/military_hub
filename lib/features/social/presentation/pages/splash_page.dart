import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
        child: Image(
          image: AssetImage('assets/img/logo_military_hub_l.png'),
          height: 100,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
    );
  }
}