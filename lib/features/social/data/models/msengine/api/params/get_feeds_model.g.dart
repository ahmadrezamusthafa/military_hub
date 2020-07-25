// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_feeds_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFeedsModel _$GetFeedsModelFromJson(Map<String, dynamic> json) {
  return GetFeedsModel(
    email: json['email'] as String,
    password: json['password'] as String,
    page: json['page'] as int,
    limit: json['limit'] as int,
  );
}

Map<String, dynamic> _$GetFeedsModelToJson(GetFeedsModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'page': instance.page,
      'limit': instance.limit,
    };
