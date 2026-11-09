import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:vernita/core/network/api_constants.dart';
import 'package:vernita/features/home/data/models/cv_response_model.dart';
import 'package:vernita/features/home/data/models/picked_cv_model.dart';

/// Performs the CV HTTP calls through the shared authenticated [Dio] instance.
///
/// The shared Dio has no base URL because Retrofit applies it for the auth
/// client. CV paths are built from the single [ApiEndPoints.apiBaseUrl] and the
/// existing endpoint constants so dynamic resume IDs stay interpolation-only.
class CvRemoteDataSource {
  CvRemoteDataSource(this._dio);

  final Dio _dio;

  Future<CvResponseModel> uploadCv(PickedCvModel cv) async {
    final file = await MultipartFile.fromFile(cv.path, filename: cv.name);
    final formData = FormData();
    formData.files.add(MapEntry('file', file));

    final response = await _dio.post<Map<String, dynamic>>(
      _url(ApiEndPoints.uploadCv),
      data: formData,
    );

    return CvResponseModel.fromJson(response.data!);
  }

  Future<List<CvResponseModel>> getCvs() async {
    final response = await _dio.get<List<dynamic>>(_url(ApiEndPoints.getCv));
    final data = response.data;

    if (data == null) {
      throw StateError('The CV list response had no body.');
    }

    return data
        .map((item) => CvResponseModel.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  Future<void> deleteCv(int id) async {
    await _dio.delete<void>(_url(ApiEndPoints.deleteResume(id)));
  }

  Future<Uint8List> downloadCv(int id) async {
    final response = await _dio.get<Uint8List>(
      _url(ApiEndPoints.downloadResume(id)),
      options: Options(responseType: ResponseType.bytes),
    );

    return response.data ?? Uint8List(0);
  }

  String _url(String endpoint) => '${ApiEndPoints.apiBaseUrl}$endpoint';
}
