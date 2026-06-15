/// Base class for all Vlm API errors.
class VlmError implements Exception {
  VlmError(this.message, {this.code, this.response});

  final String message;
  final String? code;
  final Map<String, dynamic>? response;

  @override
  String toString() =>
      'VlmError: $message${code != null ? ' (code: $code)' : ''}';
}

/// Error thrown when the API returns a 400 status code.
class BadRequestError extends VlmError {
  BadRequestError(String message,
      {String? code, Map<String, dynamic>? response})
      : super(message, code: code, response: response);
}

/// Error thrown when the API returns a 401 status code.
class AuthenticationError extends VlmError {
  AuthenticationError(String message,
      {String? code, Map<String, dynamic>? response})
      : super(message, code: code, response: response);
}

/// Error thrown when the API returns a 403 status code.
class PermissionError extends VlmError {
  PermissionError(String message,
      {String? code, Map<String, dynamic>? response})
      : super(message, code: code, response: response);
}

/// Error thrown when the API returns a 404 status code.
class NotFoundError extends VlmError {
  NotFoundError(String message, {String? code, Map<String, dynamic>? response})
      : super(message, code: code, response: response);
}

/// Error thrown when the API returns a 429 status code.
class RateLimitError extends VlmError {
  RateLimitError(String message, {String? code, Map<String, dynamic>? response})
      : super(message, code: code, response: response);
}

/// Error thrown when the API returns a 500 status code.
class InternalServerError extends VlmError {
  InternalServerError(String message,
      {String? code, Map<String, dynamic>? response})
      : super(message, code: code, response: response);
}
