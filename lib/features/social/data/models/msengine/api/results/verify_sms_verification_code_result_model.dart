import 'package:json_annotation/json_annotation.dart';

part 'verify_sms_verification_code_result_model.g.dart';

@JsonSerializable()
class VerifySMSVerificationCodeResultModel {
  bool isSuccess;
  String message;

  VerifySMSVerificationCodeResultModel({
    this.isSuccess,
    this.message,
  });

  factory VerifySMSVerificationCodeResultModel.fromJson(
          Map<String, dynamic> json) =>
      _$VerifySMSVerificationCodeResultModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VerifySMSVerificationCodeResultModelToJson(this);
}
