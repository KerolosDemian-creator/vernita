import 'package:vernita/features/profile/profile/data/models/user_model.dart';

/// Loading the profile from the server.
enum ProfileStatus { initial, loading, loaded, failure }

/// Saving a change to the server.
enum ProfileUpdateStatus { idle, saving, success, failure }

class ProfileState {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.updateStatus = ProfileUpdateStatus.idle,
    this.user,
    this.errorMessage,
  });

  final ProfileStatus status;
  final ProfileUpdateStatus updateStatus;
  final UserModel? user;
  final String? errorMessage;

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileUpdateStatus? updateStatus,
    UserModel? user,
    String? errorMessage,
  }) => ProfileState(
    status: status ?? this.status,
    updateStatus: updateStatus ?? this.updateStatus,
    user: user ?? this.user,
    errorMessage: errorMessage,
  );
}
