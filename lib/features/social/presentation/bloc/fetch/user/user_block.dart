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
      final userInfo = await userUseCase.getUser(event.email, event.password);
      if (userInfo == null) {
        yield Empty();
      } else {
        yield Loaded(item: userInfo);
      }
    }
  }
}
