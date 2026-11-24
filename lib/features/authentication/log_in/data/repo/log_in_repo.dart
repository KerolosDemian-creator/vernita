import 'package:dartz/dartz.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/features/authentication/log_in/data/models/log_in_request_model.dart';
import 'package:vernita/features/authentication/log_in/data/models/log_in_response_model.dart';

abstract class LogInRepo {
  Future<Either<ErrorHandler, LogInResponseModel>> logIn(
    LogInRequestModel logInRequestBody,
  );
}
