import 'package:json_annotation/json_annotation.dart';

part 'set_active_from_sms_verification_model.g.dart';

@JsonSerializable()
class SetActiveFromSMSVerificationModel {
  String email;
  String verificationCode;

  SetActiveFromSMSVerificationModel({
    this.email,
    this.verificationCode,
  });

  factory SetActiveFromSMSVerificationModel.fromJson(
          Map<String, dynamic> json) =>
      _$SetActiveFromSMSVerificationModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SetActiveFromSMSVerificationModelToJson(this);
}
