import 'package:json_annotation/json_annotation.dart';

part 'get_user_groups_model.g.dart';

@JsonSerializable()
class GetUserGroupsModel {
  String kodeGroup;
  String name;
  String description;
  String profilePicture;
  String ownerId;

  GetUserGroupsModel({
    this.kodeGroup,
    this.name,
    this.description,
    this.profilePicture,
    this.ownerId,
  });

  factory GetUserGroupsModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserGroupsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserGroupsModelToJson(this);
}
