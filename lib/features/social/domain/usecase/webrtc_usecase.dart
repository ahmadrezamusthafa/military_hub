import 'package:military_hub/features/social/domain/entities/live_broadcaster.dart';
import 'package:military_hub/features/social/domain/entities/participant.dart';
import 'package:military_hub/features/social/domain/entities/room.dart';
import 'package:military_hub/features/social/domain/repositories/webrtc_repository.dart';

class WebRTCUseCase {
  final WebRTCRepository repository;

  WebRTCUseCase(this.repository);

  Future<int> createTransaction() async {
    return repository.createTransaction();
  }

  Future<int> attachPlugin(int sessionId, String plugin) async {
    return repository.attachPlugin(sessionId, plugin);
  }

  Future<List<Room>> getRoomList(int sessionId, int handleId) async {
    return repository.getRoomList(sessionId, handleId);
  }

  Future<List<Room>> getRoomListDirectly() async {
    return repository.getRoomListDirectly();
  }

  Future<List<Participant>> getRoomParticipantList(
      int sessionId, int handleId, int room) async {
    return repository.getRoomParticipantList(sessionId, handleId, room);
  }

  Future<List<Participant>> getRoomParticipantListDirectly(int room) async {
    return repository.getRoomParticipantListDirectly(room);
  }

  Future<List<LiveBroadcaster>> getLiveBroadcasterList() async {
    return repository.getLiveBroadcasterList();
  }
}
