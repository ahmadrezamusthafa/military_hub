import 'package:json_annotation/json_annotation.dart';

part 'get_user_information_full_by_phone_model.g.dart';

@JsonSerializable()
class GetUserInformationFullByPhoneModel {
  String userId;
  String email;
  String phoneNumber;
  String encryptedPassword;
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
  bool isAktif;
  String elsaUser;
  String elsaNetwork;
  String elsaInstance;
  String elsaDBName;
  bool isElsaDownloaded;
  String deviceId;
  String deviceName;
  String deviceEmail;

  GetUserInformationFullByPhoneModel({
    this.userId,
    this.email,
    this.phoneNumber,
    this.encryptedPassword,
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
    this.isAktif,
    this.elsaUser,
    this.elsaNetwork,
    this.elsaInstance,
    this.elsaDBName,
    this.isElsaDownloaded,
    this.deviceId,
    this.deviceName,
    this.deviceEmail,
  });

  factory GetUserInformationFullByPhoneModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserInformationFullByPhoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserInformationFullByPhoneModelToJson(this);
}
