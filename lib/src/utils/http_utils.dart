import '../types/error.dart';

/// Utility class for HTTP-related operations
class HttpUtils {
  /// Check if the status code is in the successful range (2xx)
  static bool isSuccessful(int statusCode) =>
      statusCode >= 200 && statusCode < 300;

  /// Handle error response and throw appropriate exception
  static void handleErrorResponse(
      int statusCode, Map<String, dynamic> responseJson) {
    switch (statusCode) {
      case 400:
        throw BadRequestError(
          statusCode: statusCode,
          details: responseJson,
        );
      case 401:
        throw AuthenticationError(
          statusCode: statusCode,
          details: responseJson,
        );
      case 404:
        throw NotFoundError(
          statusCode: statusCode,
          details: responseJson,
        );
      case 429:
        throw RateLimitError(
          statusCode: statusCode,
          details: responseJson,
        );
      default:
        throw InternalServerError(
          statusCode: statusCode,
          details: responseJson,
        );
    }
  }
}
