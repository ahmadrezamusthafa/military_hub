import 'package:json_annotation/json_annotation.dart';

part 'update_user_profile_model.g.dart';

@JsonSerializable()
class UpdateUserProfileModel {
  String email;
  String password;
  String name;
  String address;
  String birthDate;
  String education;
  String occupation;
  String profileStatus;

  UpdateUserProfileModel({
    this.email,
    this.password,
    this.name,
    this.address,
    this.birthDate,
    this.education,
    this.occupation,
    this.profileStatus,
  });

  factory UpdateUserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserProfileModelToJson(this);
}
