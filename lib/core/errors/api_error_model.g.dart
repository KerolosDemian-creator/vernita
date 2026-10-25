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
      path: json['path'] as String?,
      validationErrors: (json['validationErrors'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
    );
