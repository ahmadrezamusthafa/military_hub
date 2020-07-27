// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_db_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDbModel _$UserDbModelFromJson(Map<String, dynamic> json) {
  return UserDbModel(
    userId: json['userId'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    name: json['name'] as String,
    gender: json['gender'] as String,
    address: json['address'] as String,
    phoneNumber: json['phoneNumber'] as String,
    birthDate: json['birthDate'] as String,
    education: json['education'] as String,
    occupation: json['occupation'] as String,
    profileStatus: json['profileStatus'] as String,
    profilePicture: json['profilePicture'] as String,
    apiToken: json['apiToken'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    syncedAt: json['syncedAt'] as String,
  )
    ..nickName = json['nickName'] as String
    ..country = json['country'] as String
    ..latitude = (json['latitude'] as num)?.toDouble()
    ..longitude = (json['longitude'] as num)?.toDouble();
}

Map<String, dynamic> _$UserDbModelToJson(UserDbModel instance) =>
    <String, dynamic>{
      'nickName': instance.nickName,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'userId': instance.userId,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'gender': instance.gender,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'birthDate': instance.birthDate,
      'education': instance.education,
      'occupation': instance.occupation,
      'profileStatus': instance.profileStatus,
      'profilePicture': instance.profilePicture,
      'apiToken': instance.apiToken,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'syncedAt': instance.syncedAt,
    };
