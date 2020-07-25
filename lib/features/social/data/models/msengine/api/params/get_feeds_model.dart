import 'package:json_annotation/json_annotation.dart';

part 'get_feeds_model.g.dart';

@JsonSerializable()
class GetFeedsModel {
  String email;
  String password;
  int page;
  int limit;

  GetFeedsModel({
    this.email,
    this.password,
    this.page,
    this.limit,
  });

  factory GetFeedsModel.fromJson(Map<String, dynamic> json) =>
      _$GetFeedsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetFeedsModelToJson(this);
}
