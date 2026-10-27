import 'package:get_it/get_it.dart';
import 'package:vernita/core/helper/shared_pref_helper.dart';
import 'package:vernita/core/network/api_service.dart';
import 'package:vernita/core/network/dio_factory.dart';
import 'package:vernita/core/storage/auth_token_storage.dart';
import 'package:vernita/features/authentication/forget_password/data/repo/forget_pass_repo.dart';
import 'package:vernita/features/authentication/forget_password/data/repo/forget_pass_repo_imp.dart';
import 'package:vernita/features/authentication/forget_password/logic/forget_pass_cubit.dart';
import 'package:vernita/features/authentication/logic/auth_session_cubit.dart';
import 'package:vernita/features/authentication/log_in/data/repo/log_in_repo.dart';
import 'package:vernita/features/authentication/log_in/data/repo/log_in_repo_imp.dart';
import 'package:vernita/features/authentication/log_in/logic/log_in_cubit.dart';
import 'package:vernita/features/authentication/reset_password/data/repo/reset_pass_repo.dart';
import 'package:vernita/features/authentication/reset_password/data/repo/reset_pass_repo_imp.dart';
import 'package:vernita/features/authentication/reset_password/logic/reset_pass_cubit.dart';
import 'package:vernita/features/authentication/sign_up/data/repo/sign_up_repo.dart';
import 'package:vernita/features/authentication/sign_up/data/repo/sign_up_repo_imp.dart';
import 'package:vernita/features/authentication/sign_up/logic/sign_up_cubit.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';

final getIt = GetIt.instance;

Future<void> getItSetup() async {
  await SharedPrefHelper.init();

  getIt.registerFactory<CvUploadCubit>(() => CvUploadCubit());

  getIt.registerLazySingleton<AuthTokenStorage>(() => AuthTokenStorage());
  getIt.registerLazySingleton<AuthSessionCubit>(
    () => AuthSessionCubit(getIt()),
    dispose: (cubit) => cubit.close(),
  );

  final dio = DioFactory.getDio(
    readToken: () => getIt<AuthTokenStorage>().readToken(),
    onUnauthorized: () => getIt<AuthSessionCubit>().invalidateSession(),
  );
  await DioFactory.addDioHeaders();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepoImp(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));

  getIt.registerLazySingleton<LogInRepo>(() => LogInRepoImp(getIt()));
  getIt.registerFactory<LogInCubit>(
    () => LogInCubit(getIt(), getIt<AuthSessionCubit>()),
  );

  getIt.registerLazySingleton<ForgetPassRepo>(() => ForgetPassRepoImp(getIt()));
  getIt.registerFactory<ForgetPassCubit>(() => ForgetPassCubit(getIt()));

  getIt.registerLazySingleton<ResetPassRepo>(() => ResetPassRepoImp(getIt()));
  getIt.registerFactory<ResetPassCubit>(() => ResetPassCubit(getIt()));
}
