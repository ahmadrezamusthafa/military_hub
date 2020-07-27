// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserLocationModel _$UpdateUserLocationModelFromJson(
    Map<String, dynamic> json) {
  return UpdateUserLocationModel(
    email: json['email'] as String,
    password: json['password'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$UpdateUserLocationModelToJson(
        UpdateUserLocationModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
