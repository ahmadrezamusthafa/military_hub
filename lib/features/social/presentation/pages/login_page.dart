import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:military_hub/core/http/http_request.dart';
import 'package:military_hub/features/social/domain/entities/user.dart';
import 'package:military_hub/features/social/domain/usecase/user_usecase.dart';
import 'package:military_hub/features/social/presentation/bloc/fetch/user/bloc.dart';
import 'package:military_hub/features/social/presentation/widgets/block_button_widget.dart';
import 'package:minimize_app/minimize_app.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../../../config/app_config.dart' as config;
import '../../../../injection_container.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  final User user = new User();
  bool hidePassword = true;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  LoginPage({Key key, this.hidePassword = true});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _tryLogin = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: buildBody(context),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _tryLogin = true;
    });
    var userInfo = await sl<UserUseCase>()
        .getUser(widget.user.email, widget.user.password,
            errorCallBack: (msg, code) async {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          content: new Text(msg),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('OK'),
            ),
          ],
        ),
      );
    });
    if (userInfo != null) {
      Navigator.of(context).pushReplacementNamed('/Home');
    }
    setState(() {
      _tryLogin = false;
    });
  }

  BlocProvider buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetUserInfoBloc>(),
      child:
          Stack(alignment: AlignmentDirectional.topCenter, children: <Widget>[
        Container(
          width: config.App(context).appWidth(100),
          height: config.App(context).appHeight(37),
          decoration: BoxDecoration(color: Theme.of(context).accentColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.all(0),
                child: Image(
                  image: AssetImage('assets/img/logo_military_hub_l.png'),
                ),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              /*Padding(
                padding: EdgeInsets.all(3),
              ),
              Text("MILITARY",
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .merge(TextStyle(fontFamily: "Staatliches"))
                      .merge(TextStyle(color: Colors.white))
                      .merge(TextStyle(letterSpacing: 1.3))
                      .merge(TextStyle(fontSize: 32))),*/
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: config.App(context).appHeight(37) - 50 >= 0
                  ? config.App(context).appHeight(37) - 50
                  : 0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                      )
                    ]),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding:
                    EdgeInsets.only(top: 30, right: 27, left: 27, bottom: 10),
                width: config.App(context).appWidth(95),
                child: Form(
                  key: widget.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => widget.user.email = input.trim(),
                        validator: (input) => !input.contains('@')
                            ? "Should be a valid email"
                            : null,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'ahmad.reza.musthafa@gmail.com',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.email,
                              size: 20, color: Theme.of(context).accentColor),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      //SizedBox(height: 5),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => widget.user.password = input,
                        validator: (input) => input.length < 3
                            ? "Should be more than 3 characters"
                            : null,
                        obscureText: widget.hidePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: '••••••••••••',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.lock_outline,
                              size: 20, color: Theme.of(context).accentColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.hidePassword = !widget.hidePassword;
                              });
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(widget.hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 30),
                      BlockButtonWidget(
                        text: Text(
                          "Login",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          if (widget.formKey.currentState.validate()) {
                            widget.formKey.currentState.save();
                            _login();
                          }
                        },
                      ),
                      _tryLogin
                          ? Container(
                              margin: EdgeInsets.only(top: 30),
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                              ),
                            )
                          : Container(),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(7)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Theme.of(context).hintColor.withOpacity(0.1),
                      )
                    ]),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 0),
                width: config.App(context).appWidth(95),
                child: Form(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
//                            Navigator.of(context).pushNamed('/SignUp');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'Sign up',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(width: 5),
                        FlatButton(
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
//                            Navigator.of(context).pushNamed('/ForgetPassword');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          textColor: Theme.of(context).hintColor,
                          child: Text(
                            "Forgot password ?",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit from Military Hub'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  MinimizeApp.minimizeApp();
                  Navigator.of(context).pop(false);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
