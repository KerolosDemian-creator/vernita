class UserModel {
  const UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.specialization,
    required this.targetTrack,
    required this.cvFileName,
    this.isVerified = true,
    this.avatarUrl,
  });

  final String name;
  final String email;
  final String phone;
  final String location;
  final String specialization;
  final String targetTrack;
  final String cvFileName;
  final bool isVerified;
  final String? avatarUrl;

  /// Demo data until the real API is connected.
  static const UserModel mock = UserModel(
    name: 'Alex Mercer',
    email: 'alex.mercer@example.com',
    phone: '+20 515485',
    location: 'Cairo, Egypt',
    specialization: 'Engineering (Frontend)',
    targetTrack: 'Senior Product Designer / Frontend',
    cvFileName: 'Alex_Mercer_CV.pdf',
  );
}
