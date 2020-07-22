import 'package:json_annotation/json_annotation.dart';

part 'set_active_from_sms_verification_result_model.g.dart';

@JsonSerializable()
class SetActiveFromSMSVerificationResultModel {
  bool isSuccess;
  String message;

  SetActiveFromSMSVerificationResultModel({
    this.isSuccess,
    this.message,
  });

  factory SetActiveFromSMSVerificationResultModel.fromJson(
          Map<String, dynamic> json) =>
      _$SetActiveFromSMSVerificationResultModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SetActiveFromSMSVerificationResultModelToJson(this);
}
