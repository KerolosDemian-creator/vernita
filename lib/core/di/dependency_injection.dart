import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vernita/core/network/api_service.dart';
import 'package:vernita/core/network/dio_factory.dart';
import 'package:vernita/core/storage/auth_token_storage.dart';
import 'package:vernita/features/authentication/log_in/data/repo/log_in_repo.dart';
import 'package:vernita/features/authentication/log_in/data/repo/log_in_repo_imp.dart';
import 'package:vernita/features/authentication/log_in/logic/log_in_cubit.dart';
import 'package:vernita/features/authentication/sign_up/data/repo/sign_up_repo.dart';
import 'package:vernita/features/authentication/sign_up/data/repo/sign_up_repo_imp.dart';
import 'package:vernita/features/authentication/sign_up/logic/sign_up_cubit.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';

final getIt = GetIt.instance;
Future<void> getItSetup() async {
  getIt.registerFactory<CvUploadCubit>(() => CvUploadCubit());

  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  getIt.registerLazySingleton<AuthTokenStorage>(() => AuthTokenStorage());

  getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepoImp(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));

  getIt.registerLazySingleton<LogInRepo>(() => LogInRepoImp(getIt()));
  getIt.registerFactory<LogInCubit>(() => LogInCubit(getIt(), getIt()));
}
