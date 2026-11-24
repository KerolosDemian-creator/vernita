import 'package:dartz/dartz.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/network/api_service.dart';
import 'package:vernita/features/profile/profile/data/models/update_profile_request_model.dart';
import 'package:vernita/features/profile/profile/data/models/user_model.dart';
import 'package:vernita/features/profile/profile/data/repo/profile_repo.dart';

class ProfileRepoImp implements ProfileRepo {
  final ApiService _apiService;

  ProfileRepoImp(this._apiService);

  @override
  Future<Either<ErrorHandler, UserModel>> getProfile() async {
    try {
      final response = await _apiService.getCurrentUser();
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<ErrorHandler, UserModel>> updateProfile(
    UpdateProfileRequestModel updateProfileRequestBody,
  ) async {
    try {
      final response = await _apiService.updateCurrentUser(
        updateProfileRequestBody,
      );
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
