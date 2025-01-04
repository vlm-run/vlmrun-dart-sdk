import 'dart:convert';

import '../../types/openai/model.dart';
import '../../vlmrun_client.dart';
import '../../types/error.dart';

/// Resource class for model-related endpoints.
class ModelsResource {
  ModelsResource(this._client);

  final Vlmrun _client;

  /// List all available models.
  Future<ModelList> list() async {
    final response = await _client.request('GET', '/v1/openai/models');
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

    return ModelList.fromJson(json);
  }

  /// Retrieve a model by ID.
  Future<Model> retrieve(String modelId) async {
    final response = await _client.request('GET', '/v1/openai/models/$modelId');
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

    return Model.fromJson(json);
  }
}
