import 'package:json_annotation/json_annotation.dart';

part 'get_verification_code_expiry_model.g.dart';

@JsonSerializable()
class GetVerificationCodeExpiryModel {
  String verificationCode;
  String expiryDate;

  GetVerificationCodeExpiryModel({
    this.verificationCode,
    this.expiryDate,
  });

  factory GetVerificationCodeExpiryModel.fromJson(Map<String, dynamic> json) =>
      _$GetVerificationCodeExpiryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetVerificationCodeExpiryModelToJson(this);
}
