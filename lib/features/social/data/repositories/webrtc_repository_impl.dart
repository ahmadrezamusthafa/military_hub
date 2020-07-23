import 'package:military_hub/features/social/data/datasources/janus/janus_webrtc_repository.dart';
import 'package:military_hub/features/social/domain/entities/live_broadcaster.dart';
import 'package:military_hub/features/social/domain/entities/participant.dart';
import 'package:military_hub/features/social/domain/entities/room.dart';
import 'package:military_hub/features/social/domain/repositories/webrtc_repository.dart';

class WebRTCRepositoryImpl implements WebRTCRepository {
  final JanusWebRTCRepository janusWebRTCRepository;

  WebRTCRepositoryImpl({this.janusWebRTCRepository});

  @override
  Future<int> createTransaction() async {
    var response = await janusWebRTCRepository.createTransaction();
    if (response != null) {
      return response.id;
    }
    return 0;
  }

  @override
  Future<int> attachPlugin(int sessionId, String plugin) async {
    var response = await janusWebRTCRepository.attachPlugin(sessionId, plugin);
    if (response != null) {
      return response.id;
    }
    return 0;
  }

  @override
  Future<List<Room>> getRoomList(int sessionId, int handleId) async {
    List<Room> roomList = List<Room>();
    var response = await janusWebRTCRepository.getRoomList(sessionId, handleId);
    if (response != null) {
      if (response.rooms != null && response.rooms.isNotEmpty) {
        for (var room in response.rooms) {
          roomList.add(Room(
            room: room.room,
            description: room.description,
            participantCount: room.participantCount,
          ));
        }
      }
    }
    return roomList;
  }

  @override
  Future<List<Participant>> getRoomParticipantList(
      int sessionId, int handleId, int room) async {
    List<Participant> participantList = List<Participant>();
    var response = await janusWebRTCRepository.getRoomParticipantList(
        sessionId, handleId, room);
    if (response != null) {
      if (response.participants != null && response.participants.isNotEmpty) {
        for (var participant in response.participants) {
          participantList.add(Participant(
            id: participant.id,
            display: participant.display,
            publisher: participant.publisher,
            talking: participant.talking,
          ));
        }
      }
    }
    return participantList;
  }

  @override
  Future<List<Room>> getRoomListDirectly() async {
    List<Room> roomList = List<Room>();
    var sessionId = await createTransaction();
    if (sessionId != null && sessionId != 0) {
      var handleId = await attachPlugin(sessionId, "janus.plugin.videoroom");
      if (handleId != null && handleId != 0) {
        roomList = await getRoomList(sessionId, handleId);
      }
    }
    return roomList;
  }

  @override
  Future<List<Participant>> getRoomParticipantListDirectly(int room) async {
    List<Participant> participantList = List<Participant>();
    var sessionId = await createTransaction();
    if (sessionId != null && sessionId != 0) {
      var handleId = await attachPlugin(sessionId, "janus.plugin.videoroom");
      if (handleId != null && handleId != 0) {
        participantList =
            await getRoomParticipantList(sessionId, handleId, room);
      }
    }
    return participantList;
  }

  @override
  Future<List<LiveBroadcaster>> getLiveBroadcasterList() async {
    List<LiveBroadcaster> broadcasterList = new List<LiveBroadcaster>();
    var sessionId = await createTransaction();
    if (sessionId != null && sessionId != 0) {
      var handleId = await attachPlugin(sessionId, "janus.plugin.videoroom");
      if (handleId != null && handleId != 0) {
        var roomList = await getRoomList(sessionId, handleId);
        if (roomList != null && roomList.isNotEmpty) {
          for (var room in roomList) {
            if (room.participantCount > 0) {
              var participantList =
                  await getRoomParticipantList(sessionId, handleId, room.room);
              for (var participant in participantList) {
                if (participant.publisher) {
                  broadcasterList.add(LiveBroadcaster(
                    roomId: room.room,
                    userId: participant.id,
                    name: participant.display,
                  ));
                }
              }
            }
          }
        }
      }
    }
    return broadcasterList;
  }
}
