// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_room_participant_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRoomParticipantResultModel _$GetRoomParticipantResultModelFromJson(
    Map<String, dynamic> json) {
  return GetRoomParticipantResultModel(
    videoRoom: json['videoroom'] as String,
    room: json['room'] as int,
    participants: (json['participants'] as List)
        ?.map((e) => e == null
            ? null
            : ParticipantModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetRoomParticipantResultModelToJson(
        GetRoomParticipantResultModel instance) =>
    <String, dynamic>{
      'videoroom': instance.videoRoom,
      'room': instance.room,
      'participants': instance.participants,
    };
