import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class FetchState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends FetchState {}

class Loading extends FetchState {}

class Error extends FetchState {}

class ListLoaded extends FetchState {
  final List<dynamic> lists;

  ListLoaded({
    @required this.lists,
  });

  @override
  List<Object> get props => [lists];
}

class Loaded extends FetchState {
  final dynamic item;

  Loaded({
    @required this.item,
  });

  @override
  List<Object> get props => [item];
}
