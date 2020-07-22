import 'package:json_annotation/json_annotation.dart';

part 'get_userid_model.g.dart';

@JsonSerializable()
class GetUserIdModel {
  String userId;

  GetUserIdModel({
    this.userId,
  });

  factory GetUserIdModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserIdModelToJson(this);
}
