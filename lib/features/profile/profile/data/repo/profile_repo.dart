import 'package:dartz/dartz.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/features/profile/profile/data/models/update_profile_request_model.dart';
import 'package:vernita/features/profile/profile/data/models/user_model.dart';

abstract class ProfileRepo {
  Future<Either<ErrorHandler, UserModel>> getProfile();

  Future<Either<ErrorHandler, UserModel>> updateProfile(
    UpdateProfileRequestModel updateProfileRequestBody,
  );
}
