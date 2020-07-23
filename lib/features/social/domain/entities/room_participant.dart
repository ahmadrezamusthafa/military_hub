import 'package:military_hub/features/social/domain/entities/participant.dart';

class RoomParticipant {
  String videoRoom;
  int room;
  List<Participant> participants;

  RoomParticipant({
    this.videoRoom,
    this.room,
    this.participants,
  });

  RoomParticipant.fromJson(Map<String, dynamic> json)
      : videoRoom = json['videoroom'],
        room = json['room'],
        participants = (json['participants'] as List)
            ?.map((e) => e == null ? null : Participant.fromJson(e))
            ?.toList();

  Map<String, dynamic> toJson() => {
        'videoroom': videoRoom,
        'room': room,
        'participants': participants,
      };
}
