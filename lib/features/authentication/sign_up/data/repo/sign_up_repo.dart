import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/features/authentication/sign_up/data/models/sign_up_request_model.dart';
import 'package:vernita/features/authentication/sign_up/data/models/sign_up_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpRepo {
  Future<Either<ErrorHandler, SignUpResponseModel>> signUp(
    SignUpRequestModel signUpRequestBody,
  );
}
