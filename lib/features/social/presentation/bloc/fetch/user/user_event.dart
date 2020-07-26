import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:military_hub/core/http/http_request.dart';

@immutable
abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserInfoEvent extends UserEvent {
  final String email;
  final String password;
  final OnError errorCallBack;

  GetUserInfoEvent({this.email, this.password, this.errorCallBack});

  @override
  List<Object> get props => [email];
}

class GetUserListByEmailsEvent extends UserEvent {
  final String email;
  final String password;
  final List<String> emailList;

  GetUserListByEmailsEvent({
    this.email,
    this.password,
    this.emailList,
  });

  @override
  List<Object> get props => [emailList];
}

class GetNearUserListEvent extends UserEvent {
  final String email;
  final String password;
  final double latitude;
  final double longitude;
  final int radius;
  final OnError errorCallBack;

  GetNearUserListEvent(
      {this.email,
      this.password,
      this.latitude,
      this.longitude,
      this.radius,
      this.errorCallBack});

  @override
  List<Object> get props => [email];
}
