import 'package:dartz/dartz.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/network/api_service.dart';
import 'package:vernita/core/network/models/message_response_model.dart';
import 'package:vernita/features/authentication/reset_password/data/models/reset_pass_request_model.dart';
import 'package:vernita/features/authentication/reset_password/data/repo/reset_pass_repo.dart';

class ResetPassRepoImp implements ResetPassRepo {
  final ApiService _apiService;

  ResetPassRepoImp(this._apiService);

  @override
  Future<Either<ErrorHandler, MessageResponseModel>> resetPassword(
    ResetPassRequestModel resetPassRequestBody,
  ) async {
    try {
      final response = await _apiService.resetPassword(resetPassRequestBody);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
