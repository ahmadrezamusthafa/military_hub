// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_active_from_sms_verification_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetActiveFromSMSVerificationResultModel
    _$SetActiveFromSMSVerificationResultModelFromJson(
        Map<String, dynamic> json) {
  return SetActiveFromSMSVerificationResultModel(
    isSuccess: json['isSuccess'] as bool,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$SetActiveFromSMSVerificationResultModelToJson(
        SetActiveFromSMSVerificationResultModel instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'message': instance.message,
    };
