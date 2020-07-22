// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_verified_email_sms_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVerifiedEmailSMSStatusModel _$GetVerifiedEmailSMSStatusModelFromJson(
    Map<String, dynamic> json) {
  return GetVerifiedEmailSMSStatusModel(
    email: json['email'] as String,
    phone: json['phone'] as String,
    isActive: json['isActive'] as bool,
    isVerifiedSMS: json['isVerifiedSMS'] as bool,
    isVerifiedEmail: json['isVerifiedEmail'] as bool,
  );
}

Map<String, dynamic> _$GetVerifiedEmailSMSStatusModelToJson(
        GetVerifiedEmailSMSStatusModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'isActive': instance.isActive,
      'isVerifiedSMS': instance.isVerifiedSMS,
      'isVerifiedEmail': instance.isVerifiedEmail,
    };
