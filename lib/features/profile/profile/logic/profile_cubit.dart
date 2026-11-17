import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/storage/auth_token_storage.dart';
import 'package:vernita/features/profile/profile/data/models/update_profile_request_model.dart';
import 'package:vernita/features/profile/profile/data/repo/profile_repo.dart';
import 'package:vernita/features/profile/profile/logic/profile_field.dart';
import 'package:vernita/features/profile/profile/logic/profile_state.dart';

/// App-wide user data (provided once in VernitaApp), so Profile and
/// Personal Info always show the same user.
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  final AuthTokenStorage tokenStorage;

  ProfileCubit(this.profileRepo, this.tokenStorage)
    : super(const ProfileState());

  /// GET /users/me
  Future<void> load() async {
    // No token = the user is not logged in yet, so don't call the backend
    // (it would answer 401/403 and we'd show a confusing error).
    final token = await tokenStorage.readToken();
    if (token == null || token.isEmpty) {
      emit(
        const ProfileState(
          status: ProfileStatus.failure,
          errorMessage: 'Please log in to see your profile.',
        ),
      );
      return;
    }

    // Fresh state (no user) so we never flash the previous user's data.
    emit(const ProfileState(status: ProfileStatus.loading));

    final result = await profileRepo.getProfile();

    result.fold(
      (failure) => emit(
        ProfileState(
          status: ProfileStatus.failure,
          errorMessage: failure.apiErrorModel.displayMessage,
        ),
      ),
      (user) => emit(ProfileState(status: ProfileStatus.loaded, user: user)),
    );
  }

  /// Clears the last save result, so an old error / success doesn't show up
  /// the next time the edit sheet is opened.
  void resetUpdateStatus() {
    if (state.updateStatus == ProfileUpdateStatus.idle) return;
    emit(state.copyWith(updateStatus: ProfileUpdateStatus.idle));
  }

  /// PUT /users/me  (changes one field, sends the whole profile).
  Future<void> updateField(ProfileField field, String value) async {
    final current = state.user;
    if (current == null) return;

    emit(state.copyWith(updateStatus: ProfileUpdateStatus.saving));

    final updatedUser = field.write(current, value);
    final request = UpdateProfileRequestModel.fromUser(updatedUser);
    final result = await profileRepo.updateProfile(request);

    result.fold(
      (failure) => emit(
        state.copyWith(
          updateStatus: ProfileUpdateStatus.failure,
          errorMessage: failure.apiErrorModel.displayMessage,
        ),
      ),
      // Use the user the server sends back, it's the source of truth.
      (user) => emit(
        state.copyWith(user: user, updateStatus: ProfileUpdateStatus.success),
      ),
    );
  }
}
