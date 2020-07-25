import 'package:json_annotation/json_annotation.dart';

part 'get_post_comment_result_model.g.dart';

@JsonSerializable()
class GetPostCommentResultModel {
  String postCode;
  String commentCode;
  String userId;
  String name;
  String comment;
  String createdAt;

  GetPostCommentResultModel({
    this.postCode,
    this.commentCode,
    this.userId,
    this.name,
    this.comment,
    this.createdAt,
  });

  factory GetPostCommentResultModel.fromJson(Map<String, dynamic> json) =>
      _$GetPostCommentResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostCommentResultModelToJson(this);
}
