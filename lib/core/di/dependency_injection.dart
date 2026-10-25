import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vernita/core/network/api_service.dart';
import 'package:vernita/core/network/dio_factory.dart';
import 'package:vernita/features/authentication/sign_up/data/repo/sign_up_repo.dart';
import 'package:vernita/features/authentication/sign_up/data/repo/sign_up_repo_imp.dart';
import 'package:vernita/features/authentication/sign_up/logic/sign_up_cubit.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';

final getIt = GetIt.instance;
Future<void> getItSetup() async {
  getIt.registerFactory<CvUploadCubit>(() => CvUploadCubit());

  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepoImp(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
}
