// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_friend_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFriendProfileModel _$GetFriendProfileModelFromJson(
    Map<String, dynamic> json) {
  return GetFriendProfileModel(
    userId: json['userId'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    address: json['address'] as String,
    education: json['education'] as String,
    occupation: json['occupation'] as String,
    profileStatus: json['profileStatus'] as String,
    profilePicture: json['profilePicture'] as String,
  );
}

Map<String, dynamic> _$GetFriendProfileModelToJson(
        GetFriendProfileModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'address': instance.address,
      'education': instance.education,
      'occupation': instance.occupation,
      'profileStatus': instance.profileStatus,
      'profilePicture': instance.profilePicture,
    };
