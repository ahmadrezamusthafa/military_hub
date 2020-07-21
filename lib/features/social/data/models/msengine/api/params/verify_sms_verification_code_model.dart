import 'package:json_annotation/json_annotation.dart';

part 'verify_sms_verification_code_model.g.dart';

@JsonSerializable()
class VerifySMSVerificationCodeModel {
  String phone;
  String verificationCode;

  VerifySMSVerificationCodeModel({
    this.phone,
    this.verificationCode,
  });

  factory VerifySMSVerificationCodeModel.fromJson(Map<String, dynamic> json) =>
      _$VerifySMSVerificationCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifySMSVerificationCodeModelToJson(this);
}
