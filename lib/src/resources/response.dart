import 'dart:convert';

import '../vlmrun_client.dart';
import '../types/error.dart';
import '../types/shared/prediction_response.dart';

/// Resource class for response-related endpoints.
class ResponseResource {
  ResponseResource(this._client);

  final VlmRun _client;

  /// Get response JSON by request ID.
  Future<PredictionResponse> retrieve(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('Expected a non-empty value for `id`');
    }

    final response = await _client.request(
      'GET',
      '/v1/response/$id',
    );

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      switch (response.statusCode) {
        case 400:
          throw BadRequestError(
            statusCode: response.statusCode,
            details: responseJson,
          );
        case 401:
          throw AuthenticationError(
            statusCode: response.statusCode,
            details: responseJson,
          );
        case 404:
          throw NotFoundError(
            statusCode: response.statusCode,
            details: responseJson,
          );
        case 429:
          throw RateLimitError(
            statusCode: response.statusCode,
            details: responseJson,
          );
        default:
          throw InternalServerError(
            statusCode: response.statusCode,
            details: responseJson,
          );
      }
    }

    return PredictionResponse.fromJson(json);
  }
}
