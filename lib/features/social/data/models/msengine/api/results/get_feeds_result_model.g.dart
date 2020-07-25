// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_feeds_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFeedsResultModel _$GetFeedsResultModelFromJson(Map<String, dynamic> json) {
  return GetFeedsResultModel(
    postCode: json['postCode'] as String,
    type: json['type'] as int,
    image: json['image'] as String,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
    locationName: json['locationName'] as String,
    description: json['description'] as String,
    userId: json['userId'] as String,
    name: json['name'] as String,
    profilePicture: json['profilePicture'] as String,
    likeCount: json['likeCount'] as int,
    commentCount: json['commentCount'] as int,
    isLiked: json['isLiked'] as bool,
    createdAt: json['createdAt'] as String,
  );
}

Map<String, dynamic> _$GetFeedsResultModelToJson(
        GetFeedsResultModel instance) =>
    <String, dynamic>{
      'postCode': instance.postCode,
      'type': instance.type,
      'image': instance.image,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'locationName': instance.locationName,
      'description': instance.description,
      'userId': instance.userId,
      'name': instance.name,
      'profilePicture': instance.profilePicture,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'isLiked': instance.isLiked,
      'createdAt': instance.createdAt,
    };
