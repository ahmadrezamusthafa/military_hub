import 'package:flutter/material.dart';

class MenuTitleWidget extends StatelessWidget {

  final String title;

  MenuTitleWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.subhead
    );
  }
}