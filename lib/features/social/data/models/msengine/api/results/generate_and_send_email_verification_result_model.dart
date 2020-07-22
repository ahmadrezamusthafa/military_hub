import 'package:json_annotation/json_annotation.dart';

part 'generate_and_send_email_verification_result_model.g.dart';

@JsonSerializable()
class GenerateAndSendEmailVerificationResultModel {
  String email;
  String verificationCode;
  String expiration;

  GenerateAndSendEmailVerificationResultModel({
    this.email,
    this.verificationCode,
    this.expiration,
  });

  factory GenerateAndSendEmailVerificationResultModel.fromJson(
          Map<String, dynamic> json) =>
      _$GenerateAndSendEmailVerificationResultModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GenerateAndSendEmailVerificationResultModelToJson(this);
}
