class ForgetPassRequestModel {
  const ForgetPassRequestModel({required this.email});

  final String email;

  Map<String, dynamic> toJson() => {'email': email};
}
