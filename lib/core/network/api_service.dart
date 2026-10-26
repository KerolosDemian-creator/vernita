import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';
import 'package:vernita/core/network/api_constants.dart';
import 'package:vernita/features/authentication/log_in/data/models/log_in_request_model.dart';
import 'package:vernita/features/authentication/log_in/data/models/log_in_response_model.dart';
import 'package:vernita/features/authentication/sign_up/data/models/sign_up_request_model.dart';
import 'package:vernita/features/authentication/sign_up/data/models/sign_up_response_model.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiEndPoints.signUp)
  Future<SignUpResponseModel> signUp(
    @Body() SignUpRequestModel signUpRequestBody,
  );

  @POST(ApiEndPoints.login)
  Future<LogInResponseModel> logIn(@Body() LogInRequestModel logInRequestBody);
}
