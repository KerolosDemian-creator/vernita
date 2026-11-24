import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/features/home/data/data_source/cv_remote_data_source.dart';
import 'package:vernita/features/home/data/models/cv_response_model.dart';
import 'package:vernita/features/home/data/models/picked_cv_model.dart';
import 'package:vernita/features/home/data/repo/cv_repo.dart';

class CvRepoImp implements CvRepo {
  CvRepoImp(this._remoteDataSource);

  final CvRemoteDataSource _remoteDataSource;

  @override
  Future<Either<ErrorHandler, List<CvResponseModel>>> getCvs() async {
    try {
      final response = await _remoteDataSource.getCvs();
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ErrorHandler, CvResponseModel>> uploadCv(
    PickedCvModel cv,
  ) async {
    try {
      final response = await _remoteDataSource.uploadCv(cv);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ErrorHandler, Unit>> deleteCv(int id) async {
    try {
      await _remoteDataSource.deleteCv(id);
      return right(unit);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ErrorHandler, Uint8List>> downloadCv(int id) async {
    try {
      final bytes = await _remoteDataSource.downloadCv(id);
      if (bytes.isEmpty) {
        return left(
          ErrorHandler.local(
            'The downloaded CV file is empty. Please try again.',
          ),
        );
      }
      return right(bytes);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
