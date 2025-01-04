import 'dart:convert';

import '../vlm_client.dart';
import '../types/error.dart';
import '../types/model_info_response.dart';

/// Resource class for model-related endpoints.
class ModelsResource {
  ModelsResource(this._client);

  final Vlm _client;

  /// Get the list of supported models.
  Future<List<ModelInfoResponse>> list() async {
    final response = await _client.request(
      'GET',
      '/v1/models',
    );

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

    final json = jsonDecode(response.body) as List<dynamic>;
    return json
        .map((item) => ModelInfoResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
