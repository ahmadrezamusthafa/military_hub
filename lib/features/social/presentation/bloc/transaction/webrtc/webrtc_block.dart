import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:military_hub/features/social/domain/usecase/webrtc_usecase.dart';

import 'bloc.dart';

class CreateWebRTCTransactionBloc extends Bloc<WebRTCEvent, TransactionState> {
  final WebRTCUseCase webRTCUseCase;

  CreateWebRTCTransactionBloc({
    @required this.webRTCUseCase,
  }) : assert(webRTCUseCase != null);

  @override
  TransactionState get initialState => Loading();

  @override
  Stream<TransactionState> mapEventToState(WebRTCEvent event) async* {
    if (event is CreateWebRTCTransactionEvent) {
      yield Loading();
      final id = await webRTCUseCase.createTransaction();
      if (id == null) {
        yield Empty();
      } else {
        yield Loaded(item: id);
      }
    }
  }
}
