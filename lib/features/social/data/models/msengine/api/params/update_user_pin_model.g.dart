// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_pin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserPINModel _$UpdateUserPINModelFromJson(Map<String, dynamic> json) {
  return UpdateUserPINModel(
    email: json['email'] as String,
    password: json['password'] as String,
    pin: json['pin'] as String,
  );
}

Map<String, dynamic> _$UpdateUserPINModelToJson(UpdateUserPINModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'pin': instance.pin,
    };
