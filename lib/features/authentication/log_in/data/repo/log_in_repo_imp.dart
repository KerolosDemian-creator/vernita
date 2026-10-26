import 'package:dartz/dartz.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/network/api_service.dart';
import 'package:vernita/features/authentication/log_in/data/models/log_in_request_model.dart';
import 'package:vernita/features/authentication/log_in/data/models/log_in_response_model.dart';
import 'package:vernita/features/authentication/log_in/data/repo/log_in_repo.dart';

class LogInRepoImp implements LogInRepo {
  final ApiService _apiService;

  LogInRepoImp(this._apiService);

  @override
  Future<Either<ErrorHandler, LogInResponseModel>> logIn(
    LogInRequestModel logInRequestBody,
  ) async {
    try {
      final response = await _apiService.logIn(logInRequestBody);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
