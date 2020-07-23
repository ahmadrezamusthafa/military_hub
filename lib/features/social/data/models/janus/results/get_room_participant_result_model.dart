import 'package:json_annotation/json_annotation.dart';
import 'package:military_hub/features/social/data/models/janus/results/participant_model.dart';

part 'get_room_participant_result_model.g.dart';

@JsonSerializable()
class GetRoomParticipantResultModel {
  @JsonKey(name: "videoroom")
  String videoRoom;
  int room;
  List<ParticipantModel> participants;

  GetRoomParticipantResultModel({
    this.videoRoom,
    this.room,
    this.participants,
  });

  factory GetRoomParticipantResultModel.fromJson(Map<String, dynamic> json) =>
      _$GetRoomParticipantResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetRoomParticipantResultModelToJson(this);
}
