import 'dart:convert';

import '../vlmrun_client.dart';
import '../types/shared/prediction_response.dart';
import '../utils/http_utils.dart';

class RequestTimeoutError implements Exception {
  RequestTimeoutError(this.message);
  final String message;

  @override
  String toString() => 'RequestTimeoutError: $message';
}

/// Resource class for prediction-related endpoints.
class PredictionsResource {
  PredictionsResource(this._client);

  final VlmRun _client;

  /// List all predictions.
  Future<List<PredictionResponse>> list({
    int? skip,
    int? limit,
  }) async {
    final queryParams = <String, String>{};
    if (skip != null) queryParams['skip'] = skip.toString();
    if (limit != null) queryParams['limit'] = limit.toString();

    var path = '/v1/predictions';
    if (queryParams.isNotEmpty) {
      final uri = Uri.parse(path).replace(queryParameters: queryParams);
      path = uri.toString();
    }

    final response = await _client.request('GET', path);

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as List<dynamic>;
    return json
        .map(
            (item) => PredictionResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Get a prediction by ID.
  Future<PredictionResponse> get(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('Expected a non-empty value for `id`');
    }

    final response = await _client.request('GET', '/v1/predictions/$id');

    if (!HttpUtils.isSuccessful(response.statusCode)) {
      HttpUtils.handleErrorResponse(
        response.statusCode,
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return PredictionResponse.fromJson(json);
  }

  /// Wait for a prediction to complete.
  ///
  /// [id] - ID of prediction to wait for
  /// [timeout] - Timeout in seconds (default: 60)
  /// [sleep] - Sleep time in seconds between checks (default: 1)
  Future<PredictionResponse> wait(
    String id, {
    int timeout = 60,
    int sleep = 1,
  }) async {
    final startTime = DateTime.now();
    final timeoutDuration = Duration(seconds: timeout);

    while (DateTime.now().difference(startTime) < timeoutDuration) {
      final response = await get(id);
      if (response.status == 'completed') {
        return response;
      }
      await Future.delayed(Duration(seconds: sleep));
    }

    throw RequestTimeoutError(
      'Prediction $id did not complete within $timeout seconds',
    );
  }
}
