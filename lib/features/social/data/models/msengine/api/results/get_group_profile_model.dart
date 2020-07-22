import 'package:json_annotation/json_annotation.dart';

part 'get_group_profile_model.g.dart';

@JsonSerializable()
class GetGroupProfileModel {
  String kodeGroup;
  String name;
  String description;
  String profilePicture;
  String ownerId;

  GetGroupProfileModel({
    this.kodeGroup,
    this.name,
    this.description,
    this.profilePicture,
    this.ownerId,
  });

  factory GetGroupProfileModel.fromJson(Map<String, dynamic> json) =>
      _$GetGroupProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetGroupProfileModelToJson(this);
}
