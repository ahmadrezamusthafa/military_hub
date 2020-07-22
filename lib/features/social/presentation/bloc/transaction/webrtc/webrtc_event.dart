import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class WebRTCEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateWebRTCTransactionEvent extends WebRTCEvent {}
