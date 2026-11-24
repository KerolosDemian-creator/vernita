import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vernita/features/authentication/sign_up/data/models/sign_up_response_model.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.loading() = Loading;
  const factory SignUpState.failure({required String errMessage}) = Failure;
  const factory SignUpState.success(SignUpResponseModel user) = Success;
}