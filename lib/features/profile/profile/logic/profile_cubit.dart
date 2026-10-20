import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/user_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  Future<void> load() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    // TODO: fetch the real user from the API / repo.
    emit(state.copyWith(status: ProfileStatus.loaded, user: UserModel.mock));
  }
}
