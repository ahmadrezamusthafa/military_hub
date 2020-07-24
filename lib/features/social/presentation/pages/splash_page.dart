import 'dart:async';

import 'package:flutter/material.dart';
import 'package:military_hub/features/social/domain/usecase/user_usecase.dart';

import '../../../../injection_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  SplashPageState();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Timer _timer;
  int _start = 2;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (_start < 1) {
          var userLocalExist = await sl<UserUseCase>().checkUserLocalDbExists();
          print("userLocalExist: $userLocalExist");
          if (userLocalExist) {
            Navigator.of(context).pushReplacementNamed('/Home');
          } else {
            Navigator.of(context).pushReplacementNamed('/Login');
          }
          timer.cancel();
        }
        setState(
          () {
            if (_start < 1) {
            } else {
              _start = _start - 1;
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
