// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) {
  return RoomModel(
    room: json['room'] as int,
    description: json['description'] as String,
    participantCount: json['num_participants'] as String,
  );
}

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'room': instance.room,
      'description': instance.description,
      'num_participants': instance.participantCount,
    };
