// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_information_full_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserInformationFullModel _$GetUserInformationFullModelFromJson(
    Map<String, dynamic> json) {
  return GetUserInformationFullModel(
    userId: json['userId'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    name: json['name'] as String,
    nickName: json['nickName'] as String,
    gender: json['gender'] as String,
    address: json['address'] as String,
    country: json['country'] as String,
    birthDate: json['birthDate'] as String,
    education: json['education'] as String,
    occupation: json['occupation'] as String,
    profileStatus: json['profileStatus'] as String,
    profilePicture: json['profilePicture'] as String,
    isAktif: json['isAktif'] as bool,
    elsaUser: json['elsaUser'] as String,
    elsaNetwork: json['elsaNetwork'] as String,
    elsaInstance: json['elsaInstance'] as String,
    elsaDBName: json['elsaDBName'] as String,
    isElsaDownloaded: json['isElsaDownloaded'] as bool,
    deviceId: json['deviceId'] as String,
    deviceName: json['deviceName'] as String,
    deviceEmail: json['deviceEmail'] as String,
  );
}

Map<String, dynamic> _$GetUserInformationFullModelToJson(
        GetUserInformationFullModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'nickName': instance.nickName,
      'gender': instance.gender,
      'address': instance.address,
      'country': instance.country,
      'birthDate': instance.birthDate,
      'education': instance.education,
      'occupation': instance.occupation,
      'profileStatus': instance.profileStatus,
      'profilePicture': instance.profilePicture,
      'isAktif': instance.isAktif,
      'elsaUser': instance.elsaUser,
      'elsaNetwork': instance.elsaNetwork,
      'elsaInstance': instance.elsaInstance,
      'elsaDBName': instance.elsaDBName,
      'isElsaDownloaded': instance.isElsaDownloaded,
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
      'deviceEmail': instance.deviceEmail,
    };
