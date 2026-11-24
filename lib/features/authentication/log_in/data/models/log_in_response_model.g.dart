// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_in_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogInResponseModel _$LogInResponseModelFromJson(Map<String, dynamic> json) =>
    LogInResponseModel(
      id: (json['id'] as num).toInt(),
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      message: json['message'] as String,
      accessToken: json['accessToken'] as String,
      tokenType: json['tokenType'] as String,
    );
