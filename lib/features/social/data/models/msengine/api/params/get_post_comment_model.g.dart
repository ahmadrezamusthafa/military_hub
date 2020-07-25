// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostCommentModel _$GetPostCommentModelFromJson(Map<String, dynamic> json) {
  return GetPostCommentModel(
    email: json['email'] as String,
    password: json['password'] as String,
    postCode: json['postCode'] as String,
    page: json['page'] as int,
    limit: json['limit'] as int,
  );
}

Map<String, dynamic> _$GetPostCommentModelToJson(
        GetPostCommentModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'postCode': instance.postCode,
      'page': instance.page,
      'limit': instance.limit,
    };
