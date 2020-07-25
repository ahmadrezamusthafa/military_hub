import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:military_hub/features/social/domain/usecase/feeds_usecase.dart';

import 'bloc.dart';

class GetFeedsBloc extends Bloc<FeedsEvent, FetchState> {
  final FeedsUseCase feedsUseCase;

  GetFeedsBloc({
    @required this.feedsUseCase,
  }) : assert(feedsUseCase != null);

  @override
  FetchState get initialState => Loading();

  @override
  Stream<FetchState> mapEventToState(FeedsEvent event) async* {
    if (event is GetFeedsEvent) {
      yield Loading();
      final feeds = await feedsUseCase.getFeeds(
          event.email, event.password, event.page, event.limit,
          errorCallBack: event.errorCallBack);
      if (feeds.isEmpty) {
        yield Empty();
      } else {
        yield ListLoaded(lists: feeds);
      }
    }
  }
}
