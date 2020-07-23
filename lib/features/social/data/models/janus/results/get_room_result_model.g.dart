// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_room_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRoomResultModel _$GetRoomResultModelFromJson(Map<String, dynamic> json) {
  return GetRoomResultModel(
    videoRoom: json['videoroom'] as String,
    rooms: (json['rooms'] as List)
        ?.map((e) =>
            e == null ? null : RoomModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetRoomResultModelToJson(GetRoomResultModel instance) =>
    <String, dynamic>{
      'videoroom': instance.videoRoom,
      'rooms': instance.rooms,
    };
