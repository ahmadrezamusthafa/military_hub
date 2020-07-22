import 'package:json_annotation/json_annotation.dart';

part 'id_result_model.g.dart';

@JsonSerializable()
class IdResultModel {
  int id;

  IdResultModel({this.id});

  factory IdResultModel.fromJson(Map<String, dynamic> json) =>
      _$IdResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$IdResultModelToJson(this);
}
