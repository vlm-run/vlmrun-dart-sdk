import 'dart:convert';

import '../vlmrun_client.dart';
import '../types/error.dart';
import '../types/schema.dart';

/// Resource class for schema-related endpoints.
class SchemaResource {
  SchemaResource(this._client);

  final VlmRun _client;

  /// Generate a schema prediction.
  Future<PredictionResponse> generate({
    required String prompt,
    required Map<String, dynamic> schema,
    String? model,
    Map<String, dynamic>? options,
  }) async {
    final params = {
      'prompt': prompt,
      'schema': schema,
      if (model != null) 'model': model,
      if (options != null) 'options': options,
    };

    final response = await _client.request(
      'POST',
      '/v1/schema/generate',
      body: jsonEncode(params),
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
