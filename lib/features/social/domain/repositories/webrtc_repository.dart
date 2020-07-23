import 'package:military_hub/features/social/domain/entities/participant.dart';
import 'package:military_hub/features/social/domain/entities/room.dart';

abstract class WebRTCRepository {
  Future<int> createTransaction();

  Future<int> attachPlugin(int sessionId, String plugin);

  Future<List<Room>> getRoomList(int sessionId, int handleId);

  Future<List<Participant>> getRoomParticipantList(
      int sessionId, int handleId, int room);
}
