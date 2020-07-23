import 'package:json_annotation/json_annotation.dart';
import 'package:military_hub/features/social/data/models/janus/results/room_model.dart';

part 'get_room_result_model.g.dart';

@JsonSerializable()
class GetRoomResultModel {
  @JsonKey(name: "videoroom")
  String videoRoom;
  List<RoomModel> rooms;

  GetRoomResultModel({
    this.videoRoom,
    this.rooms,
  });

  factory GetRoomResultModel.fromJson(Map<String, dynamic> json) =>
      _$GetRoomResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetRoomResultModelToJson(this);
}
