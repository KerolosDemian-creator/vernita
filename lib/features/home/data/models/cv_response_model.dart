import 'package:json_annotation/json_annotation.dart';

part 'cv_response_model.g.dart';

@JsonSerializable(createToJson: false)
class CvResponseModel {
  final int id;
  final String fileName;
  final String fileType;
  final int fileSize;
  final bool active;
  final String? uploadedAt;

  const CvResponseModel({
    required this.id,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.active,
    this.uploadedAt,
  });

  factory CvResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CvResponseModelFromJson(json);

  CvResponseModel copyWith({
    int? id,
    String? fileName,
    String? fileType,
    int? fileSize,
    bool? active,
    String? uploadedAt,
  }) {
    return CvResponseModel(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      fileSize: fileSize ?? this.fileSize,
      active: active ?? this.active,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
