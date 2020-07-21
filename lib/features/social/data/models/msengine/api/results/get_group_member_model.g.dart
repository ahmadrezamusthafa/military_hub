// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_group_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGroupMemberModel _$GetGroupMemberModelFromJson(Map<String, dynamic> json) {
  return GetGroupMemberModel(
    userId: json['userId'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    gender: json['gender'] as String,
    address: json['address'] as String,
    profileStatus: json['profileStatus'] as String,
    profilePicture: json['profilePicture'] as String,
    isOnline: json['isOnline'] as bool,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
    ownerId: json['ownerId'] as String,
    isAdmin: json['isAdmin'] as bool,
  );
}

Map<String, dynamic> _$GetGroupMemberModelToJson(
        GetGroupMemberModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'gender': instance.gender,
      'address': instance.address,
      'profileStatus': instance.profileStatus,
      'profilePicture': instance.profilePicture,
      'isOnline': instance.isOnline,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'ownerId': instance.ownerId,
      'isAdmin': instance.isAdmin,
    };
