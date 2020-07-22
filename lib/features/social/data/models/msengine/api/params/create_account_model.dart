import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_account_model.g.dart';

@JsonSerializable()
class CreateAccountModel {
  final String name;
  final String email;
  final String password;
  final String birthDate;
  final String address;
  final String phoneNumber;

  CreateAccountModel({
    @required this.name,
    @required this.email,
    @required this.password,
    this.birthDate,
    this.address,
    this.phoneNumber,
  });

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountModelToJson(this);
}
