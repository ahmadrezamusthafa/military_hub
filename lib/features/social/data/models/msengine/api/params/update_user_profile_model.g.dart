// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserProfileModel _$UpdateUserProfileModelFromJson(
    Map<String, dynamic> json) {
  return UpdateUserProfileModel(
    email: json['email'] as String,
    password: json['password'] as String,
    name: json['name'] as String,
    address: json['address'] as String,
    birthDate: json['birthDate'] as String,
    education: json['education'] as String,
    occupation: json['occupation'] as String,
    profileStatus: json['profileStatus'] as String,
  );
}

Map<String, dynamic> _$UpdateUserProfileModelToJson(
        UpdateUserProfileModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'address': instance.address,
      'birthDate': instance.birthDate,
      'education': instance.education,
      'occupation': instance.occupation,
      'profileStatus': instance.profileStatus,
    };
