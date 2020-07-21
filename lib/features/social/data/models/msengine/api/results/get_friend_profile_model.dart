import 'package:json_annotation/json_annotation.dart';

part 'get_friend_profile_model.g.dart';

@JsonSerializable()
class GetFriendProfileModel {
  String userId;
  String email;
  String name;
  String address;
  String education;
  String occupation;
  String profileStatus;
  String profilePicture;

  GetFriendProfileModel({
    this.userId,
    this.email,
    this.name,
    this.address,
    this.education,
    this.occupation,
    this.profileStatus,
    this.profilePicture,
  });

  factory GetFriendProfileModel.fromJson(Map<String, dynamic> json) =>
      _$GetFriendProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetFriendProfileModelToJson(this);
}
