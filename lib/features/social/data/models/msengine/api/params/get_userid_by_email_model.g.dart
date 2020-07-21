// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_userid_by_email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserIdByEmailModel _$GetUserIdByEmailModelFromJson(
    Map<String, dynamic> json) {
  return GetUserIdByEmailModel(
    email: json['email'] as String,
    password: json['password'] as String,
    emailList: (json['emailList'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$GetUserIdByEmailModelToJson(
        GetUserIdByEmailModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'emailList': instance.emailList,
    };
