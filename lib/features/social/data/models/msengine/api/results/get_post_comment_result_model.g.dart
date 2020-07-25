// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_comment_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostCommentResultModel _$GetPostCommentResultModelFromJson(
    Map<String, dynamic> json) {
  return GetPostCommentResultModel(
    postCode: json['postCode'] as String,
    commentCode: json['commentCode'] as String,
    userId: json['userId'] as String,
    name: json['name'] as String,
    comment: json['comment'] as String,
    createdAt: json['createdAt'] as String,
  );
}

Map<String, dynamic> _$GetPostCommentResultModelToJson(
        GetPostCommentResultModel instance) =>
    <String, dynamic>{
      'postCode': instance.postCode,
      'commentCode': instance.commentCode,
      'userId': instance.userId,
      'name': instance.name,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
    };
