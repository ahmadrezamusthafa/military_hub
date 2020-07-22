import 'package:json_annotation/json_annotation.dart';

part 'api_result_model.g.dart';

@JsonSerializable()
class APIResultModel {
  List<dynamic> result;
  String targetUrl;
  bool success;
  String error;

  APIResultModel({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
  });

  factory APIResultModel.fromJson(Map<String, dynamic> json) =>
      _$APIResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$APIResultModelToJson(this);
}
