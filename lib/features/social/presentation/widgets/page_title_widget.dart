import 'package:flutter/material.dart';

class PageTitleWidget extends StatelessWidget {

  final String title;
  PageTitleWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.title,
    );
  }
}