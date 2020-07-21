// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_group_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGroupProfileModel _$GetGroupProfileModelFromJson(Map<String, dynamic> json) {
  return GetGroupProfileModel(
    kodeGroup: json['kodeGroup'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    profilePicture: json['profilePicture'] as String,
    ownerId: json['ownerId'] as String,
  );
}

Map<String, dynamic> _$GetGroupProfileModelToJson(
        GetGroupProfileModel instance) =>
    <String, dynamic>{
      'kodeGroup': instance.kodeGroup,
      'name': instance.name,
      'description': instance.description,
      'profilePicture': instance.profilePicture,
      'ownerId': instance.ownerId,
    };
