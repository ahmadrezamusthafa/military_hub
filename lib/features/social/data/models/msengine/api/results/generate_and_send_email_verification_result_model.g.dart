// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_and_send_email_verification_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateAndSendEmailVerificationResultModel
    _$GenerateAndSendEmailVerificationResultModelFromJson(
        Map<String, dynamic> json) {
  return GenerateAndSendEmailVerificationResultModel(
    email: json['email'] as String,
    verificationCode: json['verificationCode'] as String,
    expiration: json['expiration'] as String,
  );
}

Map<String, dynamic> _$GenerateAndSendEmailVerificationResultModelToJson(
        GenerateAndSendEmailVerificationResultModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'verificationCode': instance.verificationCode,
      'expiration': instance.expiration,
    };
