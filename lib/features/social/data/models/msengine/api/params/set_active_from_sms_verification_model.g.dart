// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_active_from_sms_verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetActiveFromSMSVerificationModel _$SetActiveFromSMSVerificationModelFromJson(
    Map<String, dynamic> json) {
  return SetActiveFromSMSVerificationModel(
    email: json['email'] as String,
    verificationCode: json['verificationCode'] as String,
  );
}

Map<String, dynamic> _$SetActiveFromSMSVerificationModelToJson(
        SetActiveFromSMSVerificationModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'verificationCode': instance.verificationCode,
    };
