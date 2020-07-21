// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_verification_code_expiry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVerificationCodeExpiryModel _$GetVerificationCodeExpiryModelFromJson(
    Map<String, dynamic> json) {
  return GetVerificationCodeExpiryModel(
    verificationCode: json['verificationCode'] as String,
    expiryDate: json['expiryDate'] as String,
  );
}

Map<String, dynamic> _$GetVerificationCodeExpiryModelToJson(
        GetVerificationCodeExpiryModel instance) =>
    <String, dynamic>{
      'verificationCode': instance.verificationCode,
      'expiryDate': instance.expiryDate,
    };
