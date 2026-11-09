// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CvResponseModel _$CvResponseModelFromJson(Map<String, dynamic> json) =>
    CvResponseModel(
      id: (json['id'] as num).toInt(),
      fileName: json['fileName'] as String,
      fileType: json['fileType'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      active: json['active'] as bool,
      uploadedAt: json['uploadedAt'] as String?,
    );
