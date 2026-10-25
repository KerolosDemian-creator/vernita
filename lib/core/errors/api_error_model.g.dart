// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    ApiErrorModel(
      timestamp: json['timestamp'] as String,
      status: (json['status'] as num).toInt(),
      error: json['error'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ApiErrorModelToJson(ApiErrorModel instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
    };
