import 'package:dartz/dartz.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/network/api_service.dart';
import 'package:vernita/core/network/models/message_response_model.dart';
import 'package:vernita/features/authentication/forget_password/data/models/forget_pass_request_model.dart';
import 'package:vernita/features/authentication/forget_password/data/repo/forget_pass_repo.dart';

class ForgetPassRepoImp implements ForgetPassRepo {
  final ApiService _apiService;

  ForgetPassRepoImp(this._apiService);

  @override
  Future<Either<ErrorHandler, MessageResponseModel>> forgotPassword(
    ForgetPassRequestModel forgetPassRequestBody,
  ) async {
    try {
      final response = await _apiService.forgotPassword(forgetPassRequestBody);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
