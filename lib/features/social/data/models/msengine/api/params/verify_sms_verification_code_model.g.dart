// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_sms_verification_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifySMSVerificationCodeModel _$VerifySMSVerificationCodeModelFromJson(
    Map<String, dynamic> json) {
  return VerifySMSVerificationCodeModel(
    phone: json['phone'] as String,
    verificationCode: json['verificationCode'] as String,
  );
}

Map<String, dynamic> _$VerifySMSVerificationCodeModelToJson(
        VerifySMSVerificationCodeModel instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'verificationCode': instance.verificationCode,
    };
