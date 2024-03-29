import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:military_hub/features/social/domain/usecase/user_usecase.dart';

import 'bloc.dart';

class GetUserListByEmailsBloc extends Bloc<UserEvent, FetchState> {
  final UserUseCase userUseCase;

  GetUserListByEmailsBloc({
    @required this.userUseCase,
  }) : assert(userUseCase != null);

  @override
  FetchState get initialState => Loading();

  @override
  Stream<FetchState> mapEventToState(UserEvent event) async* {
    if (event is GetUserListByEmailsEvent) {
      yield Loading();
      final users = await userUseCase.getUserIdByEmailList(
          event.email, event.password, event.emailList);
      if (users.isEmpty) {
        yield Empty();
      } else {
        yield ListLoaded(lists: users);
      }
    }
  }
}

class GetUserInfoBloc extends Bloc<UserEvent, FetchState> {
  final UserUseCase userUseCase;

  GetUserInfoBloc({
    @required this.userUseCase,
  }) : assert(userUseCase != null);

  @override
  FetchState get initialState => Loading();

  @override
  Stream<FetchState> mapEventToState(UserEvent event) async* {
    if (event is GetUserInfoEvent) {
      yield Loading();
      final userInfo = await userUseCase.getUser(event.email, event.password,
          errorCallBack: event.errorCallBack);
      if (userInfo == null) {
        yield Empty();
      } else {
        yield Loaded(item: userInfo);
      }
    }
  }
}

class GetNearUserListBloc extends Bloc<UserEvent, FetchState> {
  final UserUseCase userUseCase;

  GetNearUserListBloc({
    @required this.userUseCase,
  }) : assert(userUseCase != null);

  @override
  FetchState get initialState => Loading();

  @override
  Stream<FetchState> mapEventToState(UserEvent event) async* {
    if (event is GetNearUserListEvent) {
      yield Loading();
      final users = await userUseCase.getNearUserList(
          event.email, event.password, event.latitude, event.longitude,
          radius: event.radius, errorCallBack: event.errorCallBack);
      if (users.isEmpty) {
        yield Empty();
      } else {
        yield ListLoaded(lists: users);
      }
    }
  }
}
