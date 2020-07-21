import 'package:json_annotation/json_annotation.dart';

part 'get_user_friends_model.g.dart';

@JsonSerializable()
class GetUserFriendsModel {
  String userId;
  String email;
  String name;
  String nickName;
  String gender;
  String address;
  String country;
  String birthDate;
  String education;
  String occupation;
  String profileStatus;
  String profilePicture;
  bool isOnline;
  String latitude;
  String longitude;

  GetUserFriendsModel({
    this.userId,
    this.email,
    this.name,
    this.nickName,
    this.gender,
    this.address,
    this.country,
    this.birthDate,
    this.education,
    this.occupation,
    this.profileStatus,
    this.profilePicture,
    this.isOnline,
    this.latitude,
    this.longitude,
  });

  factory GetUserFriendsModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserFriendsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserFriendsModelToJson(this);
}
