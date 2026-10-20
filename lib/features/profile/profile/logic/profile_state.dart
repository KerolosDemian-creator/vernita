import '../data/models/user_model.dart';

enum ProfileStatus { initial, loading, loaded, failure }

class ProfileState {
  const ProfileState({this.status = ProfileStatus.initial, this.user});

  final ProfileStatus status;
  final UserModel? user;

  ProfileState copyWith({ProfileStatus? status, UserModel? user}) =>
      ProfileState(status: status ?? this.status, user: user ?? this.user);
}
