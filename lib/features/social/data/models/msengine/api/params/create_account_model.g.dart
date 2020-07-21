// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAccountModel _$CreateAccountModelFromJson(Map<String, dynamic> json) {
  return CreateAccountModel(
    name: json['name'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    birthDate: json['birthDate'] as String,
    address: json['address'] as String,
    phoneNumber: json['phoneNumber'] as String,
  );
}

Map<String, dynamic> _$CreateAccountModelToJson(CreateAccountModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'birthDate': instance.birthDate,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
    };
