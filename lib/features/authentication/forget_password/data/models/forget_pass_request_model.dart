import 'package:json_annotation/json_annotation.dart';

part 'forget_pass_request_model.g.dart';

@JsonSerializable(createFactory: false)
class ForgetPassRequestModel {
  const ForgetPassRequestModel({required this.email});

  final String email;

  Map<String, dynamic> toJson() => _$ForgetPassRequestModelToJson(this);
}
