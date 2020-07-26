// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_information_by_radius_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserRangeInformationByRadiusModel
    _$GetUserRangeInformationByRadiusModelFromJson(Map<String, dynamic> json) {
  return GetUserRangeInformationByRadiusModel(
    userId: json['userId'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    address: json['address'] as String,
    profilePicture: json['profilePicture'] as String,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
  );
}

Map<String, dynamic> _$GetUserRangeInformationByRadiusModelToJson(
        GetUserRangeInformationByRadiusModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'address': instance.address,
      'profilePicture': instance.profilePicture,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
