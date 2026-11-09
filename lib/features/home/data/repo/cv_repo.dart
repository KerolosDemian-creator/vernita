import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/features/home/data/models/cv_response_model.dart';
import 'package:vernita/features/home/data/models/picked_cv_model.dart';

abstract class CvRepo {
  Future<Either<ErrorHandler, List<CvResponseModel>>> getCvs();

  Future<Either<ErrorHandler, CvResponseModel>> uploadCv(PickedCvModel cv);

  Future<Either<ErrorHandler, Unit>> deleteCv(int id);

  Future<Either<ErrorHandler, Uint8List>> downloadCv(int id);
}
