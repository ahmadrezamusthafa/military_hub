// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantModel _$ParticipantModelFromJson(Map<String, dynamic> json) {
  return ParticipantModel(
    id: json['id'] as int,
    display: json['display'] as String,
    publisher: json['publisher'] as bool,
    talking: json['talking'] as bool,
  );
}

Map<String, dynamic> _$ParticipantModelToJson(ParticipantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display': instance.display,
      'publisher': instance.publisher,
      'talking': instance.talking,
    };
