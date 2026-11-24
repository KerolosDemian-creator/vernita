import 'package:dartz/dartz.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/network/models/message_response_model.dart';
import 'package:vernita/features/authentication/forget_password/data/models/forget_pass_request_model.dart';

abstract class ForgetPassRepo {
  Future<Either<ErrorHandler, MessageResponseModel>> forgotPassword(
    ForgetPassRequestModel forgetPassRequestBody,
  );
}
