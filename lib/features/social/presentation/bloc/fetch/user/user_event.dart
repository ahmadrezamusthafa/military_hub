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
