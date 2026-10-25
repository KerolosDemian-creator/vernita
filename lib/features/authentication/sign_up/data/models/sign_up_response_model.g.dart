// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponseModel _$SignUpResponseModelFromJson(Map<String, dynamic> json) =>
    SignUpResponseModel(
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      id: (json['id'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$SignUpResponseModelToJson(
  SignUpResponseModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'fullName': instance.fullName,
  'id': instance.id,
  'message': instance.message,
};
