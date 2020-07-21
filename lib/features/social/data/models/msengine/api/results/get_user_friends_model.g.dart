// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_friends_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserFriendsModel _$GetUserFriendsModelFromJson(Map<String, dynamic> json) {
  return GetUserFriendsModel(
    userId: json['userId'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    nickName: json['nickName'] as String,
    gender: json['gender'] as String,
    address: json['address'] as String,
    country: json['country'] as String,
    birthDate: json['birthDate'] as String,
    education: json['education'] as String,
    occupation: json['occupation'] as String,
    profileStatus: json['profileStatus'] as String,
    profilePicture: json['profilePicture'] as String,
    isOnline: json['isOnline'] as bool,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
  );
}

Map<String, dynamic> _$GetUserFriendsModelToJson(
        GetUserFriendsModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'nickName': instance.nickName,
      'gender': instance.gender,
      'address': instance.address,
      'country': instance.country,
      'birthDate': instance.birthDate,
      'education': instance.education,
      'occupation': instance.occupation,
      'profileStatus': instance.profileStatus,
      'profilePicture': instance.profilePicture,
      'isOnline': instance.isOnline,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
