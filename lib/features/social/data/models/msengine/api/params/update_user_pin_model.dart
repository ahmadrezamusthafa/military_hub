import 'package:json_annotation/json_annotation.dart';

part 'update_user_pin_model.g.dart';

@JsonSerializable()
class UpdateUserPINModel {
  String email;
  String password;
  String pin;

  UpdateUserPINModel({
    this.email,
    this.password,
    this.pin,
  });

  factory UpdateUserPINModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserPINModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserPINModelToJson(this);
}
