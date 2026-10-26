import 'package:dartz/dartz.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/network/models/message_response_model.dart';
import 'package:vernita/features/authentication/reset_password/data/models/reset_pass_request_model.dart';

abstract class ResetPassRepo {
  Future<Either<ErrorHandler, MessageResponseModel>> resetPassword(
    ResetPassRequestModel resetPassRequestBody,
  );
}
