import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:military_hub/core/http/http_request.dart';

@immutable
abstract class FeedsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetFeedsEvent extends FeedsEvent {
  final String email;
  final String password;
  final int page;
  final int limit;
  final OnError errorCallBack;

  GetFeedsEvent(
      {this.email, this.password, this.page, this.limit, this.errorCallBack});

  @override
  List<Object> get props => [email];
}
