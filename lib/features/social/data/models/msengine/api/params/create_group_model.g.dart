// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGroupModel _$CreateGroupModelFromJson(Map<String, dynamic> json) {
  return CreateGroupModel(
    ownerId: json['ownerId'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$CreateGroupModelToJson(CreateGroupModel instance) =>
    <String, dynamic>{
      'ownerId': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
    };
