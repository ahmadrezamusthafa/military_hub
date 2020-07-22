import 'package:json_annotation/json_annotation.dart';

part 'status_result_model.g.dart';

@JsonSerializable()
class StatusResultModel {
  bool isSuccess;
  int code;
  String message;

  StatusResultModel({
    this.isSuccess,
    this.code,
    this.message,
  });

  factory StatusResultModel.fromJson(Map<String, dynamic> json) =>
      _$StatusResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusResultModelToJson(this);
}
