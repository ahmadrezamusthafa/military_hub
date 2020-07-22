// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_sms_verification_code_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifySMSVerificationCodeResultModel
    _$VerifySMSVerificationCodeResultModelFromJson(Map<String, dynamic> json) {
  return VerifySMSVerificationCodeResultModel(
    isSuccess: json['isSuccess'] as bool,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$VerifySMSVerificationCodeResultModelToJson(
        VerifySMSVerificationCodeResultModel instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'message': instance.message,
    };
