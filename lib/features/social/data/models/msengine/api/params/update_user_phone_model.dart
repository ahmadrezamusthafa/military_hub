import 'package:json_annotation/json_annotation.dart';

part 'update_user_phone_model.g.dart';

@JsonSerializable()
class UpdateUserPhoneModel {
  String email;
  String verificationCode;
  String phone;

  UpdateUserPhoneModel({
    this.email,
    this.verificationCode,
    this.phone,
  });

  factory UpdateUserPhoneModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserPhoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserPhoneModelToJson(this);
}
