// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_public_channels_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPublicChannelsModel _$GetPublicChannelsModelFromJson(
    Map<String, dynamic> json) {
  return GetPublicChannelsModel(
    kodeChannel: json['kodeChannel'] as String,
    name: json['name'] as String,
    kodeCompany: json['kodeCompany'] as String,
    profilePicture: json['profilePicture'] as String,
    ownerId: json['ownerId'] as String,
    memberCount: json['memberCount'] as int,
  );
}

Map<String, dynamic> _$GetPublicChannelsModelToJson(
        GetPublicChannelsModel instance) =>
    <String, dynamic>{
      'kodeChannel': instance.kodeChannel,
      'name': instance.name,
      'kodeCompany': instance.kodeCompany,
      'profilePicture': instance.profilePicture,
      'ownerId': instance.ownerId,
      'memberCount': instance.memberCount,
    };
