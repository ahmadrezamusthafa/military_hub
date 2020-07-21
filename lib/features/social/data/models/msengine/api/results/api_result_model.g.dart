// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIResultModel _$APIResultModelFromJson(Map<String, dynamic> json) {
  return APIResultModel(
    result: json['result'] as List,
    targetUrl: json['targetUrl'] as String,
    success: json['success'] as bool,
    error: json['error'] as String,
  );
}

Map<String, dynamic> _$APIResultModelToJson(APIResultModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'targetUrl': instance.targetUrl,
      'success': instance.success,
      'error': instance.error,
    };
