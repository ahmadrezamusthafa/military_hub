import 'package:json_annotation/json_annotation.dart';

part 'member_email_model.g.dart';

@JsonSerializable()
class MemberEmailModel {
  String email;

  MemberEmailModel({
    this.email,
  });

  factory MemberEmailModel.fromJson(Map<String, dynamic> json) =>
      _$MemberEmailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberEmailModelToJson(this);
}
