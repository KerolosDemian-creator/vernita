// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  userId: (_readUserId(json, 'userId') as num).toInt(),
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String? ?? '',
  avatarUrl: json['avatarUrl'] as String?,
  specialization: json['specialization'] as String? ?? '',
  careerTarget: json['careerTarget'] as String? ?? '',
);
