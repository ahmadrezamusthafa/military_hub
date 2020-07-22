import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class TransactionState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends TransactionState {}

class Loading extends TransactionState {}

class Error extends TransactionState {}

class ListLoaded extends TransactionState {
  final List<dynamic> lists;

  ListLoaded({
    @required this.lists,
  });

  @override
  List<Object> get props => [lists];
}

class Loaded extends TransactionState {
  final dynamic item;

  Loaded({
    @required this.item,
  });

  @override
  List<Object> get props => [item];
}
