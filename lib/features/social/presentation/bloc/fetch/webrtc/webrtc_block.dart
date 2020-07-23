import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:military_hub/features/social/domain/usecase/webrtc_usecase.dart';

import 'bloc.dart';

class GetLiveBroadcasterListBloc extends Bloc<WebRTCEvent, FetchState> {
  final WebRTCUseCase webRTCUseCase;

  GetLiveBroadcasterListBloc({
    @required this.webRTCUseCase,
  }) : assert(webRTCUseCase != null);

  @override
  FetchState get initialState => Loading();

  @override
  Stream<FetchState> mapEventToState(WebRTCEvent event) async* {
    if (event is GetLiveBroadcasterListEvent) {
      yield Loading();
      final broadcasters = await webRTCUseCase.getLiveBroadcasterList();
      if (broadcasters.isEmpty) {
        yield Empty();
      } else {
        yield ListLoaded(lists: broadcasters);
      }
    }
  }
}
