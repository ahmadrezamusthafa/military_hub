// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusResultModel _$StatusResultModelFromJson(Map<String, dynamic> json) {
  return StatusResultModel(
    isSuccess: json['isSuccess'] as bool,
    code: json['code'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$StatusResultModelToJson(StatusResultModel instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
    };
