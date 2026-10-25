import 'package:dartz/dartz.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/network/api_service.dart';
import 'package:vernita/features/authentication/sign_up/data/models/sign_up_request_model.dart';
import 'package:vernita/features/authentication/sign_up/data/models/sign_up_response_model.dart';
import 'package:vernita/features/authentication/sign_up/data/repo/sign_up_repo.dart';

class SignUpRepoImp implements SignUpRepo {
  final ApiService _apiService;

  SignUpRepoImp(this._apiService);
  @override
  Future<Either<ErrorHandler, SignUpResponseModel>> signUp(
    SignUpRequestModel signUpRequestBody,
  ) async {
    try {
      final response = await _apiService.signUp(signUpRequestBody);
      return right(response);
    } catch (e) { 
      return left(ErrorHandler.handle(e));
    }
  }
}
