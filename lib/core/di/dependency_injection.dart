import 'package:get_it/get_it.dart';
import 'package:vernita/features/home/logic/home_cubit.dart';

final getIt = GetIt.instance;
Future<void> getItSetup() async {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}
