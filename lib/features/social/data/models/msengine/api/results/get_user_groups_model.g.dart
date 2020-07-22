// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_groups_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserGroupsModel _$GetUserGroupsModelFromJson(Map<String, dynamic> json) {
  return GetUserGroupsModel(
    kodeGroup: json['kodeGroup'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    profilePicture: json['profilePicture'] as String,
    ownerId: json['ownerId'] as String,
  );
}

Map<String, dynamic> _$GetUserGroupsModelToJson(GetUserGroupsModel instance) =>
    <String, dynamic>{
      'kodeGroup': instance.kodeGroup,
      'name': instance.name,
      'description': instance.description,
      'profilePicture': instance.profilePicture,
      'ownerId': instance.ownerId,
    };
