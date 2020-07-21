import 'package:json_annotation/json_annotation.dart';

part 'get_group_member_model.g.dart';

@JsonSerializable()
class GetGroupMemberModel {
  String userId;
  String email;
  String name;
  String gender;
  String address;
  String profileStatus;
  String profilePicture;
  bool isOnline;
  String latitude;
  String longitude;
  String ownerId;
  bool isAdmin;

  GetGroupMemberModel({
    this.userId,
    this.email,
    this.name,
    this.gender,
    this.address,
    this.profileStatus,
    this.profilePicture,
    this.isOnline,
    this.latitude,
    this.longitude,
    this.ownerId,
    this.isAdmin,
  });

  factory GetGroupMemberModel.fromJson(Map<String, dynamic> json) =>
      _$GetGroupMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetGroupMemberModelToJson(this);
}
