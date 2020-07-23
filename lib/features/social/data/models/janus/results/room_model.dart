import 'package:json_annotation/json_annotation.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  int room;
  String description;
  @JsonKey(name: 'num_participants')
  int participantCount;

  RoomModel({
    this.room,
    this.description,
    this.participantCount,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
