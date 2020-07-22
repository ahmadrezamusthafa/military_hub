// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_phone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserPhoneModel _$UpdateUserPhoneModelFromJson(Map<String, dynamic> json) {
  return UpdateUserPhoneModel(
    email: json['email'] as String,
    verificationCode: json['verificationCode'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$UpdateUserPhoneModelToJson(
        UpdateUserPhoneModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'verificationCode': instance.verificationCode,
      'phone': instance.phone,
    };
