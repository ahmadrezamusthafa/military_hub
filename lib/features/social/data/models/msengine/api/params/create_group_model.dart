import 'package:json_annotation/json_annotation.dart';

part 'create_group_model.g.dart';

@JsonSerializable()
class CreateGroupModel {
   String ownerId;
   String name;
   String description;

  CreateGroupModel({
    this.ownerId,
    this.name,
    this.description,
  });

  factory CreateGroupModel.fromJson(Map<String, dynamic> json) =>
      _$CreateGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGroupModelToJson(this);
}
