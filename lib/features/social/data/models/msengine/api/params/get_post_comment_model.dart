import 'package:json_annotation/json_annotation.dart';

part 'get_post_comment_model.g.dart';

@JsonSerializable()
class GetPostCommentModel {
  String email;
  String password;
  String postCode;
  int page;
  int limit;

  GetPostCommentModel({
    this.email,
    this.password,
    this.postCode,
    this.page,
    this.limit,
  });

  factory GetPostCommentModel.fromJson(Map<String, dynamic> json) =>
      _$GetPostCommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostCommentModelToJson(this);
}
