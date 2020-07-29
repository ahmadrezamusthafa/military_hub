// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostModel _$CreatePostModelFromJson(Map<String, dynamic> json) {
  return CreatePostModel(
    userId: json['userId'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
    locationName: json['locationName'] as String,
    type: json['type'] as int,
  );
}

Map<String, dynamic> _$CreatePostModelToJson(CreatePostModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'description': instance.description,
      'image': instance.image,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'locationName': instance.locationName,
      'type': instance.type,
    };
