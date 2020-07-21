class RoomParticipant {
  int id;
  String display;
  bool publisher;
  bool talking;

  RoomParticipant({
    this.id,
    this.display,
    this.publisher,
    this.talking,
  });

  RoomParticipant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        display = json['display'],
        publisher = json['publisher'],
        talking = json['talking'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'display': display,
        'publisher': publisher,
        'talking': talking,
      };
}

class Participant {
  String videoRoom;
  int room;
  List<RoomParticipant> participants;

  Participant({
    this.videoRoom,
    this.room,
    this.participants,
  });

  Participant.fromJson(Map<String, dynamic> json)
      : videoRoom = json['videoroom'],
        room = json['room'],
        participants = (json['participants'] as List)?.map((e) => e == null ? null : RoomParticipant.fromJson(e))
            ?.toList();

  Map<String, dynamic> toJson() => {
        'videoroom': videoRoom,
        'room': room,
        'participants': participants,
      };
}
