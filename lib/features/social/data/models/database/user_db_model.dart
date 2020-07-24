import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:military_hub/features/social/domain/entities/user.dart';

part 'user_db_model.g.dart';

@JsonSerializable()
class UserDbModel extends User {
  String userId;
  String email;
  String password;
  String name;
  String gender;
  String address;
  String phoneNumber;
  String birthDate;
  String education;
  String occupation;
  String profileStatus;
  String profilePicture;
  String apiToken;
  String createdAt;
  String updatedAt;
  String syncedAt;

  UserDbModel({
    @required this.userId,
    @required this.email,
    @required this.password,
    @required this.name,
    this.gender,
    this.address,
    this.phoneNumber,
    this.birthDate,
    this.education,
    this.occupation,
    this.profileStatus,
    this.profilePicture,
    this.apiToken,
    @required this.createdAt,
    this.updatedAt,
    this.syncedAt,
  });

  UserDbModel.fromMap(Map<String, dynamic> map) {
    this.userId = map['userId'];
    this.email = map['email'];
    this.password = map['password'];
    this.name = map['name'];
    this.gender = map['gender'];
    this.address = map['address'];
    this.phoneNumber = map['phoneNumber'];
    this.birthDate = map['birthDate'];
    this.education = map['education'];
    this.occupation = map['occupation'];
    this.profileStatus = map['profileStatus'];
    this.profilePicture = map['profilePicture'];
    this.apiToken = map['apiToken'];
    this.createdAt = map['createdAt'];
    this.updatedAt = map['updatedAt'];
    this.syncedAt = map['syncedAt'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['userId'] = this.userId;
    map['email'] = this.email;
    map['password'] = this.password;
    map['name'] = this.name;
    map['gender'] = this.gender;
    map['address'] = this.address;
    map['phoneNumber'] = this.phoneNumber;
    map['birthDate'] = this.birthDate;
    map['education'] = this.education;
    map['occupation'] = this.occupation;
    map['profileStatus'] = this.profileStatus;
    map['profilePicture'] = this.profilePicture;
    map['apiToken'] = this.apiToken;
    map['createdAt'] = this.createdAt;
    map['updatedAt'] = this.updatedAt;
    map['syncedAt'] = this.syncedAt;
    return map;
  }

  factory UserDbModel.fromJson(Map<String, dynamic> json) =>
      _$UserDbModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDbModelToJson(this);
}
