import 'package:json_annotation/json_annotation.dart';

part 'get_verified_email_sms_status_model.g.dart';

@JsonSerializable()
class GetVerifiedEmailSMSStatusModel {
  String email;
  String phone;
  bool isActive;
  bool isVerifiedSMS;
  bool isVerifiedEmail;

  GetVerifiedEmailSMSStatusModel({
    this.email,
    this.phone,
    this.isActive,
    this.isVerifiedSMS,
    this.isVerifiedEmail,
  });

  factory GetVerifiedEmailSMSStatusModel.fromJson(Map<String, dynamic> json) =>
      _$GetVerifiedEmailSMSStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetVerifiedEmailSMSStatusModelToJson(this);
}
