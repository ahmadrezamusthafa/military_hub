import 'package:json_annotation/json_annotation.dart';

part 'get_userid_by_email_model.g.dart';

@JsonSerializable()
class GetUserIdByEmailModel {
  String email;
  String password;
  List<String> emailList;

  GetUserIdByEmailModel({
    this.email,
    this.password,
    this.emailList,
  });

  factory GetUserIdByEmailModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserIdByEmailModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserIdByEmailModelToJson(this);
}
