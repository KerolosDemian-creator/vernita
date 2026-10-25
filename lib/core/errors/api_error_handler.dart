import 'package:dio/dio.dart';
import 'package:vernita/core/errors/api_error_model.dart';

const String defaultErrorMessage = 'Something went wrong. Please try again.';

/// Translates exceptions into a user-presentable [ApiErrorModel].
///
/// Network failures, malformed error bodies and local validation errors all go
/// through here so the UI only has to deal with one error type.
class ErrorHandler implements Exception {
  ErrorHandler(this.apiErrorModel);

  final ApiErrorModel apiErrorModel;

  factory ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      return ErrorHandler(_fromDioException(error));
    }
    return ErrorHandler(
      _buildError(message: localMessage, status: -5, error: 'Unknown Error'),
    );
  }

  factory ErrorHandler.local(String message) {
    return ErrorHandler(
      _buildError(message: message, status: 400, error: 'Local Error'),
    );
  }

  static const localMessage = defaultErrorMessage;
}

/// Single place to build the model so required fields are never forgotten.
ApiErrorModel _buildError({
  required String message,
  required int status,
  required String error,
}) {
  return ApiErrorModel(
    timestamp: DateTime.now().toIso8601String(),
    status: status,
    error: error,
    message: message,
  );
}

ApiErrorModel _fromDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return _buildError(
        message: 'The request timed out. Please try again.',
        status: -1,
        error: 'Timeout',
      );
    case DioExceptionType.connectionError:
      return _buildError(
        message: 'No internet connection. Please check your network.',
        status: -2,
        error: 'Connection Error',
      );
    case DioExceptionType.cancel:
      return _buildError(
        message: 'The request was cancelled.',
        status: -3,
        error: 'Cancelled',
      );
    case DioExceptionType.badCertificate:
      return _buildError(
        message: 'The server certificate could not be verified.',
        status: -4,
        error: 'Bad Certificate',
      );
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      return _fromResponse(error.response);
  }
}

ApiErrorModel _fromResponse(Response<dynamic>? response) {
  final data = response?.data;
  if (data is Map<String, dynamic>) {
    try {
      return ApiErrorModel.fromJson(data);
    } on Object {
      // Fall through to a status based message.
    }
  }

  final statusCode = response?.statusCode ?? 0;
  return _buildError(
    message: _messageForStatus(statusCode),
    status: statusCode,
    error: response?.statusMessage ?? 'Error',
  );
}

String _messageForStatus(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'The request was invalid. Please check your details.';
    case 401:
      return 'Your session has expired. Please sign in again.';
    case 403:
      return 'You do not have permission to perform this action.';
    case 404:
      return 'The requested resource was not found.';
    case 422:
      return 'Some of the details you entered are invalid.';
    case 500:
    case 502:
    case 503:
      return 'The server is unavailable right now. Please try again later.';
    default:
      return ErrorHandler.localMessage;
  }
}
